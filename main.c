// $Id: main.c 626 2009-01-19 21:36:33Z tk $
/*
 * Pedal Switcher
 *
 * ==========================================================================
 *
 *  Copyright (C) <2012>  <R.Mouneyres> (<gorest@free.fr>)
 *  Licensed for personal non-commercial use only.
 *  All other rights reserved.
 * 
 * ==========================================================================
 */


/////////////////////////////////////////////////////////////////////////////
// Include files
/////////////////////////////////////////////////////////////////////////////

#include <cmios.h>
#include <pic18fregs.h>
#include <debug_msg.h>

/////////////////////////////////////////////////////////////////////////////
// Defines
/////////////////////////////////////////////////////////////////////////////
#define DEBUG 1					// 1 : activate debug traces

#define MAX_RELAYS_NB 8			//number of relays connected to DOUT module
#define MAX_RELAY_LED_NB 8		//number of relay leds connected to DOUT module
#define MAX_RELAY_BUTTONS_NB 8	//number of relay buttons connected to DIN module
#define MAX_MENU_BUTTONS_NB 4	//number of menu buttons connected to DIN module
#define MAX_FOOTSWITCHES_NB 4	//number of footswitches connected to DIN module

#define DIN_DEBOUNCE_VALUE    10    // 0..255
#define NUMBER_OF_SRIO 16 			//1...16, 1 DIN and 1 DOUT module

#define MENU_BUTTON_1 1	//Prog, Save, next
#define MENU_BUTTON_2 2	//Opts, Back, Q
#define MENU_BUTTON_3 3	//UP, +
#define MENU_BUTTON_4 4	//DOWN, -

#define MOMENTARY_PUSH_LENGTH 200  // time in ms for momentary push relays

#define Free 0
#define Radio 1
#define Toggle 0
#define Momentary 1
#define Inactive 0
#define Active 1

/////////////////////////////////////////////////////////////////////////////
// Hardware DIN/DOUT Pin Assignation
/////////////////////////////////////////////////////////////////////////////

// DOUT
// 1>8 relay leds (220R mounted on DOUT module)
const unsigned char RelayLedPin[MAX_RELAY_LED_NB] = {
	0x00, 0x01, 0x02, 0x03,
	0x04, 0x05, 0x06, 0x07 };
// 9>16 relays (220R NOT mounted on DOUT module)
const unsigned char RelayPin[MAX_RELAYS_NB] = {
	0x08, 0x09, 0x0A, 0x0B,
	0x0C, 0x0D, 0x0E, 0x0F };
// 17>20 free DOUT pins
// 21>24 Footswitches leds (220R mounted on DOUT module)
const unsigned char FootLedPin[MAX_FOOTSWITCHES_NB] = {
	0x17, 0x16, 0x15, 0x14 };
 		
// DIN
// 1>8 Buttons to command relays
const unsigned char ButtonPin[MAX_RELAY_BUTTONS_NB] = {
	0x00, 0x01, 0x02, 0x03,
	0x04, 0x05, 0x06, 0x07 };
// 9>12 Buttons for menu
const unsigned char MenuButtonPin[MAX_MENU_BUTTONS_NB] = {
	0x0B, 0x0A, 0x08, 0x09 };
// 13>16 Footswitches
const unsigned char FootButtonPin[MAX_FOOTSWITCHES_NB] = {
	0x0E, 0x0F, 0x0D, 0x0C };

/////////////////////////////////////////////////////////////////////////////
// Local variables
/////////////////////////////////////////////////////////////////////////////

// eeprom global options
unsigned char MidiChannel; 				// AllChannels=0, 1-16=MidiChannel
unsigned char CurrentPreset;			// Current and last used preset onload
unsigned char SendMidiOnButtonChange; 	// Inactive=0, Active=1
unsigned char ReloadActivePreset;		// Don't=0, Do=1
unsigned char ForceStartupPreset;		// Don't=0, Do=1
unsigned char ThisStartupPreset;		// Preset number for specific startup
unsigned char RelayType[MAX_RELAYS_NB]; 	// Toggle=0, Momentary=1
unsigned char RelayMode[MAX_RELAYS_NB]; 		// Free=0, radiogroup=1
unsigned char FootPreset[MAX_FOOTSWITCHES_NB];	// Preset number for each footswitch

// preset values
unsigned char RelayState[MAX_RELAYS_NB]; // Open/Inactive=0, Closed/Active=1

// menu handling
unsigned char LastButton;
unsigned char MenuPos;	// 0 : Default Screen
						// 1 : PROG Menu
                        // 2 : OPTS Menu
						// ...
// running variables
unsigned char TargetPreset;
unsigned char MidiIn;

/////////////////////////////////////////////////////////////////////////////
// Local user functions
/////////////////////////////////////////////////////////////////////////////

// change the output state according to the options
//---------------------------------------------------
void toggle_dout(unsigned char relay_nb)
{
	if ( RelayType[relay_nb] == Toggle )
	{
		#if DEBUG
		  DEBUG_MSG_SendHeader();
		  DEBUG_MSG_SendCString("Relay");
		  DEBUG_MSG_SendBCD3(relay_nb);
		  DEBUG_MSG_SendCString(" original state");
		  DEBUG_MSG_SendBCD3(RelayState[relay_nb]);
		  DEBUG_MSG_SendFooter();
		#endif
		
		//toggle Relay
		MIOS_DOUT_PinSet(RelayPin[relay_nb], RelayState[relay_nb] ? 0 : 1);
		//toggle Led
		MIOS_DOUT_PinSet(RelayLedPin[relay_nb], RelayState[relay_nb] ? 0 : 1);
		
		#if DEBUG
		  DEBUG_MSG_SendHeader();
		  DEBUG_MSG_SendCString("Toggled relay");
		  DEBUG_MSG_SendBCD3(relay_nb);
		  DEBUG_MSG_SendFooter();
		#endif
	}
	else if ( RelayType[relay_nb] == Momentary )
	{
		//push relay_nb
		MIOS_DOUT_PinSet1(RelayPin[relay_nb]);
		MIOS_Delay(MOMENTARY_PUSH_LENGTH);
		MIOS_DOUT_PinSet0(RelayPin[relay_nb]);
		//manage led state
		if ( RelayState[relay_nb] == Inactive )
			MIOS_DOUT_PinSet1(RelayLedPin[relay_nb]);
		else
			MIOS_DOUT_PinSet0(RelayLedPin[relay_nb]);
			
		#if DEBUG
		  DEBUG_MSG_SendHeader();
		  DEBUG_MSG_SendCString("Pushed relay");
		  DEBUG_MSG_SendBCD3(relay_nb);
		  DEBUG_MSG_SendFooter();
		#endif
	}

	//Update RelayState
	if ( RelayState[relay_nb] )
	{ RelayState[relay_nb] = 0;	}
	else
	{ RelayState[relay_nb] = 1; }
	
	#if DEBUG
	  DEBUG_MSG_SendHeader();
	  DEBUG_MSG_SendCString(" to state");
	  DEBUG_MSG_SendBCD3(RelayState[relay_nb]);
	  DEBUG_MSG_SendFooter();
	#endif
}

// act on the relay output after a change request (panel button or midi message)
//---------------------------------------------------
void DoRelay(unsigned char relay_nb)
{
  unsigned char Found = 0;
  unsigned int i;
  
  if ( RelayMode[relay_nb] == Free )
  {
	// free relay, toggle it
  	toggle_dout(relay_nb);
  }
  else if ( RelayMode[relay_nb] == Radio )
  {
  	if ( RelayState[relay_nb] == Active )
  	{
	  // Deactivate an active radio button
  	  toggle_dout(relay_nb);
  	}
  	else
  	{
  	  for ( i=0; i<MAX_RELAYS_NB; i++ )
  	  {
  	    if ( (RelayMode[i] == Radio) && (RelayState[i] == Active) )
  	    {
			// Activate a new radio button
			//désactiver led relay_i
			MIOS_DOUT_PinSet0(RelayLedPin[i]);		
			//push relay_nb
			MIOS_DOUT_PinSet1(RelayPin[relay_nb]);
			MIOS_Delay(200);
			MIOS_DOUT_PinSet0(RelayPin[relay_nb]);			
			//activer led_relay_nb
			MIOS_DOUT_PinSet1(RelayLedPin[relay_nb]);		
			Found = 1;
			//Update RelayState
			RelayState[i] = Inactive;
			RelayState[relay_nb] = Active;
		}
  	  }
  	  if ( Found == 0 )
  	  {
		// Activate an inactive radio button
  	 	toggle_dout(relay_nb);
  	  }
  	}
  }
}

// return the switch number if the button is a footswitch
// else return 0
//---------------------------------------------------
unsigned char FootButton ( unsigned char pin_number )
{
  unsigned int i;
  
  for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
  {
    if ( FootButtonPin[i] == pin_number )
    {
      return i+1;
    }
  }
  return 0;
}

// return the relay number if the button commands a relay
// else return 0
//---------------------------------------------------
unsigned char RelayButton ( unsigned char pin_number )
{
  unsigned int i;
  
  for ( i=0; i<MAX_RELAY_BUTTONS_NB; i++ )
  {
    if ( ButtonPin[i] == pin_number )
    {
      return i+1;
    }
  }
  return 0;
}

// return the button number if the button is defined as a MENU button
// else return 0
//---------------------------------------------------
unsigned char MenuButton ( unsigned char pin_number )
{
  unsigned int i;

  for ( i=0; i<MAX_MENU_BUTTONS_NB; i++ )
  {
    if ( MenuButtonPin[i] == pin_number )
    {
      return i+1;
    }
  }
  return 0;
}

// Load a test preset (use for debugging)
//---------------------------------------------------
void LoadTestPreset()
{
  unsigned int i;
  
  // TEST PRESET
  //------------------
  MidiChannel = 0;
  CurrentPreset = 1;
  SendMidiOnButtonChange = 0;
  for ( i=0; i<5; i++)
  {
    RelayType[i] = 0; //Toggle=0, Momentary=1
    RelayMode[i] = 0; //Free=0, radiogroup=1
    RelayState[i] = 0; //Open/Inactive=0, Closed/Active=1
  }
  for ( i=5; i<8; i++)
  {
    RelayType[i] = 1; //Toggle=0, Momentary=1
    RelayMode[i] = 1; //Free=0, radiogroup=1
    RelayState[i] = 0; //Open/Inactive=0, Closed/Active=1
  }
  
}

// Load Global Options from EEPROM
//---------------------------------------------------
void LoadGlobalOptions ()
{
	unsigned char eeprom_byte;
	  
	// EEPROM BYTE 0x00 : global options
	// MidiChannel					// bit0>3
	// SendMidiOnButtonChange 		// bit4
	// ReloadActivePreset			// bit5
	// ForceStartupPreset           // bit6
	// 								// bits7>8 free
	eeprom_byte = MIOS_EEPROM_Read(0x00);
	MidiChannel = eeprom_byte & 0x0F;
	SendMidiOnButtonChange = (eeprom_byte & 0x10)>>4;
	ReloadActivePreset = (eeprom_byte & 0x20)>>5;
	ForceStartupPreset = (eeprom_byte & 0x40)>>6;
									
	// EPROM BYTE 0x01 : Current Preset									
	//CurrentPreset				// bits0>7
	CurrentPreset = MIOS_EEPROM_Read(0x01);
	
	// EPROM BYTE 0x02 : RelayType[1..8]
	eeprom_byte = MIOS_EEPROM_Read(0x02);	
	RelayType[0] = eeprom_byte & 0x01;
	RelayType[1] = (eeprom_byte & 0x02)>>1;
	RelayType[2] = (eeprom_byte & 0x04)>>2;
	RelayType[3] = (eeprom_byte & 0x08)>>3;
	RelayType[4] = (eeprom_byte & 0x10)>>4;
	RelayType[5] = (eeprom_byte & 0x20)>>5;
	RelayType[6] = (eeprom_byte & 0x40)>>6;
	RelayType[7] = (eeprom_byte & 0x80)>>7;
	
	// EPROM BYTE 0x03 : RelayMode[1..8]
	eeprom_byte = MIOS_EEPROM_Read(0x03);	
	RelayMode[0] = eeprom_byte & 0x01;
	RelayMode[1] = (eeprom_byte & 0x02)>>1;
	RelayMode[2] = (eeprom_byte & 0x04)>>2;
	RelayMode[3] = (eeprom_byte & 0x08)>>3;
	RelayMode[4] = (eeprom_byte & 0x10)>>4;
	RelayMode[5] = (eeprom_byte & 0x20)>>5;
	RelayMode[6] = (eeprom_byte & 0x40)>>6;
	RelayMode[7] = (eeprom_byte & 0x80)>>7;
	
	// EPROM BYTE 0x04 : Footswitch 1 preset
	FootPreset[0] = MIOS_EEPROM_Read(0x04);	
	// EPROM BYTE 0x05 : Footswitch 2 preset
	FootPreset[1] = MIOS_EEPROM_Read(0x05);	
	// EPROM BYTE 0x06 : Footswitch 3 preset
	FootPreset[2] = MIOS_EEPROM_Read(0x06);	
	// EPROM BYTE 0x07 : Footswitch 4 preset
	FootPreset[3] = MIOS_EEPROM_Read(0x07);	

	// EPROM BYTE 0x08 : Preset for startup when selected
	ThisStartupPreset = MIOS_EEPROM_Read(0x08);	

	// EPROM BYTE 0x09 : *reserved*
	// EPROM BYTE 0x0A : *reserved*
	// EPROM BYTE 0x0B : *reserved*
	// EPROM BYTE 0x0C : *reserved*
	// EPROM BYTE 0x0D : *reserved*
	// EPROM BYTE 0x0E : *reserved*
	// EPROM BYTE 0x0F : *reserved*	
}

// Save Global Options to EEPROM
//---------------------------------------------------
void SaveGlobalOptions ()
{
	unsigned char eeprom_byte;
	
	// EEPROM BYTE 0x00 : global options
	// MidiChannel					// bit0>3
	// SendMidiOnButtonChange		// bit4
	// ReloadActivePreset			// bit5
	// ForceStartupPreset           // bit6
	// 								//bits7>8 free
	eeprom_byte = MidiChannel & 0x0F;
	eeprom_byte = eeprom_byte | SendMidiOnButtonChange<<4;
	eeprom_byte = eeprom_byte | ReloadActivePreset<<5;
	eeprom_byte = eeprom_byte | ForceStartupPreset<<6;
	MIOS_EEPROM_Write(0x00,eeprom_byte);
									
	// EPROM BYTE 0x01 : Current Preset									
	//CurrentPreset = 1;				// bits0>7
	MIOS_EEPROM_Write(0x01,CurrentPreset);
	
	// EPROM BYTE 0x02 : RelayType[1..8]
	eeprom_byte = RelayType[0];
	eeprom_byte = eeprom_byte | RelayType[1]<<1;
	eeprom_byte = eeprom_byte | RelayType[2]<<2;
	eeprom_byte = eeprom_byte | RelayType[3]<<3;
	eeprom_byte = eeprom_byte | RelayType[4]<<4;
	eeprom_byte = eeprom_byte | RelayType[5]<<5;
	eeprom_byte = eeprom_byte | RelayType[6]<<6;
	eeprom_byte = eeprom_byte | RelayType[7]<<7;
	MIOS_EEPROM_Write(0x02,eeprom_byte);
	
	// EPROM BYTE 0x03 : RelayMode[1..8]
	eeprom_byte = RelayMode[0];
	eeprom_byte = eeprom_byte | RelayMode[1]<<1;
	eeprom_byte = eeprom_byte | RelayMode[2]<<2;
	eeprom_byte = eeprom_byte | RelayMode[3]<<3;
	eeprom_byte = eeprom_byte | RelayMode[4]<<4;
	eeprom_byte = eeprom_byte | RelayMode[5]<<5;
	eeprom_byte = eeprom_byte | RelayMode[6]<<6;
	eeprom_byte = eeprom_byte | RelayMode[7]<<7;
	MIOS_EEPROM_Write(0x03,eeprom_byte);
	
	// EPROM BYTE 0x04 : Footswitch 1 preset
	eeprom_byte = FootPreset[0];
	MIOS_EEPROM_Write(0x04,eeprom_byte);	
	// EPROM BYTE 0x05 : Footswitch 2 preset
	eeprom_byte = FootPreset[1];
	MIOS_EEPROM_Write(0x05,eeprom_byte);	
	// EPROM BYTE 0x06 : Footswitch 3 preset
	eeprom_byte = FootPreset[2];
	MIOS_EEPROM_Write(0x06,eeprom_byte);	
	// EPROM BYTE 0x07 : Footswitch 4 preset
	eeprom_byte = FootPreset[3];
	MIOS_EEPROM_Write(0x07,eeprom_byte);	

	// EPROM BYTE 0x08 : Preset for startup when selected
	MIOS_EEPROM_Write(0x08,ThisStartupPreset);	

	// EPROM BYTE 0x09 : *reserved*
	// EPROM BYTE 0x0A : *reserved*
	// EPROM BYTE 0x0B : *reserved*
	// EPROM BYTE 0x0C : *reserved*
	// EPROM BYTE 0x0D : *reserved*
	// EPROM BYTE 0x0E : *reserved*
	// EPROM BYTE 0x0F : *reserved*	
}

// Set the parameter as active preset and update eeprom
// if send midi is active, a midi out message is sent
//---------------------------------------------------
void SetActivePreset ( unsigned char preset_nb )
{
#if DEBUG
  DEBUG_MSG_SendHeader();
  DEBUG_MSG_SendCString("Set Active preset");
  DEBUG_MSG_SendBCD3(preset_nb);
  DEBUG_MSG_SendFooter();
#endif
	
	// set global variable
	CurrentPreset = preset_nb;
    
	// Save to eeprom
	MIOS_EEPROM_Write(0x01,CurrentPreset);
	
	// Update display
	// print temporary message on LCD
	MIOS_LCD_Clear();
	MIOS_LCD_CursorSet(0x00 + 0);
	MIOS_LCD_PrintCString("** Change to  **");
	MIOS_LCD_CursorSet(0x40 + 0);
	MIOS_LCD_PrintCString("** Preset     **");
	MIOS_LCD_CursorSet(0x40 + 10);
	MIOS_LCD_PrintBCD3(CurrentPreset);
	MIOS_LCD_MessageStart(100);
}

// turn off all footswitch leds 
//---------------------------------------------------
void FootLedsOff ()
{
	unsigned int i;
	
	// clear all leds
	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	{
		MIOS_DOUT_PinSet(FootLedPin[i], 0);
	}
#if DEBUG
    DEBUG_MSG_SendHeader();
    DEBUG_MSG_SendCString("Footswitch Leds Off");
    DEBUG_MSG_SendFooter();
#endif
}

// activate the led corresponding to a footswitch
//---------------------------------------------------
void SetFootLed ( unsigned char led_nb )
{
	unsigned int i;
        #if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("Footswitch Led: ");
		DEBUG_MSG_SendBCD3(FootLedPin[led_nb]);
		DEBUG_MSG_SendChar(' ');
		DEBUG_MSG_SendCString(" On");
		DEBUG_MSG_SendFooter();
		#endif
	// activate the good led
	MIOS_DOUT_PinSet1(FootLedPin[led_nb]);
}

// Load a preset from EEPROM and set preset active
//---------------------------------------------------
void LoadPreset ( unsigned char preset_nb )
{
	unsigned int i;
	unsigned int ActiveRadioFound = 0;
	unsigned char eeprom_byte;
	unsigned char TargetRelayState[MAX_RELAYS_NB]; // Open/Inactive=0, Closed/Active=1

	// load preset only if necessary/allowed
	if ( CurrentPreset == preset_nb )
	{
		if(ReloadActivePreset)
		{
			#if DEBUG
			DEBUG_MSG_SendHeader();
			DEBUG_MSG_SendCString("ReLoading active preset");
			DEBUG_MSG_SendFooter();
			#endif
			//reload active preset (implicit below)
		}
		else
		{
			#if DEBUG
			DEBUG_MSG_SendHeader();
			DEBUG_MSG_SendCString("NOT ReLoading active preset");
			DEBUG_MSG_SendFooter();
			#endif
			//ignore the change request
			return;
		}
	}
	else
	{
		#if DEBUG
		  DEBUG_MSG_SendHeader();
		  DEBUG_MSG_SendCString("Loading preset ");
		  DEBUG_MSG_SendBCD3(preset_nb);
		  DEBUG_MSG_SendFooter();
		#endif
	}	

	// read preset byte from eeprom
  	// A preset is using 1 bytes for RelayState[1..8]
	// 100 presets, BYTE 0x10 ... 0x74
	
	if ( preset_nb > 0x69 )
	{ 
		#if DEBUG
		 DEBUG_MSG_SendHeader();
		 DEBUG_MSG_SendCString("Discarded loading preset ");
 		 DEBUG_MSG_SendBCD3(preset_nb);
 		 DEBUG_MSG_SendFooter();
		#endif
		return; 
	}
	
	eeprom_byte = MIOS_EEPROM_Read(preset_nb+0x10);
	TargetRelayState[0] = eeprom_byte & 0x01;
	TargetRelayState[1] = (eeprom_byte & 0x02)>>1;
	TargetRelayState[2] = (eeprom_byte & 0x04)>>2;
	TargetRelayState[3] = (eeprom_byte & 0x08)>>3;
	TargetRelayState[4] = (eeprom_byte & 0x10)>>4;
	TargetRelayState[5] = (eeprom_byte & 0x20)>>5;
	TargetRelayState[6] = (eeprom_byte & 0x40)>>6;
	TargetRelayState[7] = (eeprom_byte & 0x80)>>7;

#if DEBUG
  DEBUG_MSG_SendHeader();
  DEBUG_MSG_SendCString("Relays state byte : ");
  DEBUG_MSG_SendBCD3(eeprom_byte);
  DEBUG_MSG_SendFooter();
#endif
	
    // send midi message ?
#if DEBUG
    DEBUG_MSG_SendHeader();
    DEBUG_MSG_SendCString("Send midi ?");
    DEBUG_MSG_SendBCD1(SendMidiOnButtonChange);
    DEBUG_MSG_SendFooter();
#endif
    if (SendMidiOnButtonChange)
    {
        MIOS_MIDI_BeginStream();
        // Program change = 0xC?
        MIOS_MIDI_TxBufferPut((0xC0)+MidiChannel-1);
        MIOS_MIDI_TxBufferPut(preset_nb-1); //PC
        MIOS_MIDI_EndStream();
#if DEBUG
        DEBUG_MSG_SendHeader();
        DEBUG_MSG_SendCString(" midi message :");
        DEBUG_MSG_SendBCD3((0xC0)+MidiChannel-1);
        DEBUG_MSG_SendBCD3(preset_nb-1);
        DEBUG_MSG_SendFooter();
#endif
	}
    
	// activate footswitch led if corresponding preset
	FootLedsOff();
    for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	{
		if ( FootPreset[i] == preset_nb )
	 	{
	 		SetFootLed(i);
	 	}
	}
	
	// Update relay state
	for ( i=0; i<MAX_RELAYS_NB; i++)
	{
  		// Change free relays state
		if ( RelayMode[i] == Free )
  		{
  			MIOS_DOUT_PinSet(RelayPin[i],TargetRelayState[i]);		
  			MIOS_DOUT_PinSet(RelayLedPin[i],TargetRelayState[i]);
  			// update global variable
  			RelayState[i] = TargetRelayState[i];	
		}
		// Deal with radio grouped relays
		if (( RelayMode[i] == Radio ) && (TargetRelayState[i] == Active))
  		{
			ActiveRadioFound = 1;
			if (RelayState[i] == Active)
  			{
  				#if DEBUG
				  DEBUG_MSG_SendHeader();
				  DEBUG_MSG_SendCString("Don't push an already active radio relay");
				  DEBUG_MSG_SendBCD3(i);
				  DEBUG_MSG_SendFooter();
				#endif
  				// force led lit, but don't push relay
  				MIOS_DOUT_PinSet(RelayLedPin[i],Active);
			}
			else
			{	//push relay
	  			DoRelay(i);
			}
  		}
	}
	
	if ( ActiveRadioFound == 0 ) // No radio relay should be active
	{
		for ( i=0; i<MAX_RELAYS_NB; i++) // verify if one is active, then desactivate
		{
			if (( RelayMode[i] == Radio ) && (RelayState[i] == Active))
  			{
		  		DoRelay(i);
			}
		}	
	}
	
	SetActivePreset(preset_nb);
}

// Save a Preset to EEPROM
// starting at adress 0x10
//---------------------------------------------------
void SavePreset ( unsigned char preset_nb )
{
	unsigned char eeprom_byte;
	
	if ( preset_nb == 0 )
	{
		// ignore save to preset 0, factory
 		// print message on LCD for 2 seconds
 		MIOS_LCD_Clear();
		MIOS_LCD_CursorSet(0x00);
 		MIOS_LCD_PrintCString("Cannot Save to");
 		MIOS_LCD_CursorSet(0x40);
 		MIOS_LCD_PrintCString("Preset 0");
		MIOS_LCD_MessageStart(255);
  		return;
	}
	
	if ( preset_nb > 0x69 )
	{ 
		#if DEBUG
		 DEBUG_MSG_SendHeader();
		 DEBUG_MSG_SendCString("Discarded saving preset ");
 		 DEBUG_MSG_SendBCD3(preset_nb);
 		 DEBUG_MSG_SendFooter();
		#endif
		return; 
	}
	// EPROM BYTE 0x01 : Current Preset									
	//CurrentPreset				// bits0>7
	MIOS_EEPROM_Write(0x01,CurrentPreset);
	
	// write preset byte to eeprom
  	// A preset is using 1 bytes for RelayState[1..8]
	// 100 presets, BYTE 0x10 ... 0x74
	
	eeprom_byte = RelayState[0];
	eeprom_byte = eeprom_byte | RelayState[1]<<1;
	eeprom_byte = eeprom_byte | RelayState[2]<<2;
	eeprom_byte = eeprom_byte | RelayState[3]<<3;
	eeprom_byte = eeprom_byte | RelayState[4]<<4;
	eeprom_byte = eeprom_byte | RelayState[5]<<5;
	eeprom_byte = eeprom_byte | RelayState[6]<<6;
	eeprom_byte = eeprom_byte | RelayState[7]<<7;
	MIOS_EEPROM_Write(preset_nb+0x10,eeprom_byte);	
	
	// set global variable
	CurrentPreset = preset_nb;
	
	// print message
	MIOS_LCD_Clear();
	MIOS_LCD_CursorSet(0x00 + 0);
	MIOS_LCD_PrintCString("**  SAVED to  **");
	MIOS_LCD_CursorSet(0x40 + 0);
	MIOS_LCD_PrintCString("** Preset     **");
	MIOS_LCD_CursorSet(0x40 + 10);
	MIOS_LCD_PrintBCD3(CurrentPreset);
	MIOS_LCD_MessageStart(100);
}

// Go up one preset
//---------------------------------------------------
unsigned char Preset_Up()
{
	if ( CurrentPreset < 100 )
	{
		LoadPreset(CurrentPreset+1);
	}
	else
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("Ignored, already at highest preset");
		DEBUG_MSG_SendFooter();
		#endif
		//ignore message, already at highest preset
		return 0;
	}
	return 1;
}

// Go down one preset
//---------------------------------------------------
unsigned char Preset_Down()
{
	if ( CurrentPreset > 0 )
	{
		LoadPreset(CurrentPreset-1);
	}
	else
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("Ignored, already at lowest preset");
		DEBUG_MSG_SendFooter();
		#endif
		//ignore message, already at lowest preset
		return 0;
	}
	return 1;
}

// Reset EEPROM Memory with default values
//---------------------------------------------------
unsigned char FactoryReset ()
{
	unsigned int i;
	unsigned char eeprom_byte;
	unsigned char error = 0;
	
#if DEBUG
  DEBUG_MSG_SendHeader();
  DEBUG_MSG_SendCString("Factory Reset");
  DEBUG_MSG_SendFooter();
#endif
	// EEPROM BYTE 0x00 : global options
	// MidiChannel = 0;					// bit0>3
	// SendMidiOnButtonChange = 0;		// bit4
	// ReloadActivePreset = 0;			// bit5
	// ForceStartupPreset = 0;			// bit6
	// 									//bits7>8 free = 0
	eeprom_byte = 0x00;
	MIOS_EEPROM_Write(0x00,eeprom_byte);
									
	// EPROM BYTE 0x01 : Current Preset	
	SetActivePreset(0);								
	
	// EPROM BYTE 0x02 : RelayType[1..8]
	eeprom_byte = 0x00;	//all free
	MIOS_EEPROM_Write(0x02,eeprom_byte);
	
	// EPROM BYTE 0x03 : RelayMode[1..8]
	eeprom_byte = 0x00;	//all toggle
	MIOS_EEPROM_Write(0x03,eeprom_byte);
	
	// EPROM BYTE 0x04 : Footswitch 1 preset
	MIOS_EEPROM_Write(0x04,1);	
	// EPROM BYTE 0x05 : Footswitch 2 preset
	MIOS_EEPROM_Write(0x05,2);	
	// EPROM BYTE 0x06 : Footswitch 3 preset
	MIOS_EEPROM_Write(0x06,3);	
	// EPROM BYTE 0x07 : Footswitch 4 preset
	MIOS_EEPROM_Write(0x07,4);	

	// EPROM BYTE 0x08 : Preset for startup when selected
	MIOS_EEPROM_Write(0x07,0);	
	
	// EPROM BYTE 0x09 : *reserved*
	// EPROM BYTE 0x0A : *reserved*
	// EPROM BYTE 0x0B : *reserved*
	// EPROM BYTE 0x0C : *reserved*
	// EPROM BYTE 0x0D : *reserved*
	// EPROM BYTE 0x0E : *reserved*
	// EPROM BYTE 0x0F : *reserved*	
	for ( i = 0x08; i<0x10; i++)
	{
		MIOS_EEPROM_Write(i,0x00);
	}
	
	// A preset is using 1 bytes for RelayState[1..8]
	// 100 presets, BYTE 0x10 ... 0x74
	for ( i = 0; i<100; i++)
	{
		error |= MIOS_EEPROM_Write(i+16,0x00);	//all off
	}
	if( error ) {
   		return 0;
	}
	return 1;
	
}

// Get last preset from eeprom and load it
//---------------------------------------------------
void StartupPreset ()
{	
    CurrentPreset = 0;  // force preset 0 to allow loading at startup even
                        // with the "Don't reload active preset" option on
    if ( ForceStartupPreset )
	{
		ThisStartupPreset = MIOS_EEPROM_Read(0x08);
		LoadPreset(ThisStartupPreset);
		return;
	}
	// EPROM BYTE 0x01 : Current Preset									
	//CurrentPreset				// bits0>7
	#if DEBUG
	  DEBUG_MSG_SendHeader();
	  DEBUG_MSG_SendCString("STARTUP PRESET");
	  DEBUG_MSG_SendBCD3(CurrentPreset);
	  DEBUG_MSG_SendFooter();
	#endif
	LoadPreset(MIOS_EEPROM_Read(0x01));
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS after startup to initialize the 
// application
/////////////////////////////////////////////////////////////////////////////
void Init(void) __wparam
{
  // set shift register update frequency
  MIOS_SRIO_UpdateFrqSet(1); // ms
  // maximum number of DIN/DOUT shift registers (1..16)
  MIOS_SRIO_NumberSet(NUMBER_OF_SRIO);
  // debouncing value for DINs
  MIOS_SRIO_DebounceSet(DIN_DEBOUNCE_VALUE);

  //Init menu buttons
  LastButton = 0;
  MenuPos = 0;
  MidiIn = 0;
  
  // factory reset startup button sequence?
    
  // Load global options
  LoadGlobalOptions();
    
  // SPECIFIC
  // Using the Sansamp programmable BDDI, the first relay is active on power on
  RelayState[5]=1;
  // Led on
  MIOS_DOUT_PinSet(RelayLedPin[5], 1);
  
  // Load Last preset used or single one (see options)
  StartupPreset();
  
  // send SysEx message to MIOS Terminal
#if DEBUG
  DEBUG_MSG_SendHeader();
  DEBUG_MSG_SendCString("Application ready.");
  DEBUG_MSG_SendFooter();
#endif
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS in the mainloop when nothing else is to do
//
//      >>>>> MENU HANDLING IS HERE <<<<<
//
/////////////////////////////////////////////////////////////////////////////
void Tick(void) __wparam
{
	// MENU handling
	if ( MenuPos == 0 ) // default screen
	{ 
		switch (LastButton)
		{
			case 0 : // nothing to do
				break;
			
			case MENU_BUTTON_1 :	// enter PROG menu
				// change menu level
				MenuPos = 1;
				// print new menu
				TargetPreset = CurrentPreset;
				MIOS_LCD_Clear();
				MIOS_LCD_CursorSet(0x00 + 0);
				MIOS_LCD_PrintCString("SAVE");
				MIOS_LCD_CursorSet(0x40 + 0);
				MIOS_LCD_PrintCString("BACK");
				MIOS_LCD_CursorSet(0x00 + 6);
				MIOS_LCD_PrintCString("to preset ");
				MIOS_LCD_CursorSet(0x40 + 8);
				MIOS_LCD_PrintBCD3(TargetPreset);
				break;
			
			case MENU_BUTTON_2 :	// enter OPTS menu
				// change menu level
				MenuPos = 6;
				// print new menu
				TargetPreset = CurrentPreset;
				MIOS_LCD_Clear();
				MIOS_LCD_CursorSet(0x00 + 0);
				MIOS_LCD_PrintCString(">");
				MIOS_LCD_CursorSet(0x40 + 0);
				MIOS_LCD_PrintCString("Q");
				MIOS_LCD_CursorSet(0x00 + 1);
				MIOS_LCD_PrintCString("  Footswitch 1  ");
				MIOS_LCD_CursorSet(0x40 + 1);
				MIOS_LCD_PrintCString("  Preset        ");
				MIOS_LCD_CursorSet(0x40 + 11);
				MIOS_LCD_PrintBCD3(FootPreset[0]);
				break;

			case MENU_BUTTON_3 :	// Preset UP
				Preset_Up();
				break;

			case MENU_BUTTON_4 :	// Preset DOWN
				Preset_Down();
				break;
		}
	}
	else if ( MenuPos == 1 ) // PROG menu
	{ 
		switch (LastButton)
		{
			case 0 : // nothing to do
				break;
			
			case MENU_BUTTON_1 :	// save
				// save it
				SavePreset(TargetPreset);
                SetActivePreset(TargetPreset);
				// exit menu
				MenuPos = 0;
				break;
			
			case MENU_BUTTON_2 :	// back (without save)
				// exit menu
				MenuPos = 0;
				// show message
				MIOS_LCD_Clear();
				MIOS_LCD_CursorSet(0x00 + 0);
				MIOS_LCD_PrintCString("**   Nothing  **");
				MIOS_LCD_CursorSet(0x40 + 0);
				MIOS_LCD_PrintCString("**    Saved   **");
				MIOS_LCD_MessageStart(100);
				break;

			case MENU_BUTTON_3 :	// target value up
			case MENU_BUTTON_4 :	// target value down
                if ( (LastButton-4) == 0 ) // Down button
                {
                    if ( TargetPreset > 1) 
                    { TargetPreset--; }
                    else
                    { TargetPreset = 100; }
                }
                else if ( (LastButton-3) == 0 ) // Up button
                {
                    if ( TargetPreset < 100) 
                    { TargetPreset++; }
                    else
                    { TargetPreset = 1; }
                }
				// update display
				MIOS_LCD_CursorSet(0x40 + 8);
				MIOS_LCD_PrintBCD3(TargetPreset);
				break;
		}
	}	
	else if ( MenuPos >= 6 ) // OPTS menu
	{
		switch (LastButton)
		{
			case 0 : // nothing to do
				break;

			case MENU_BUTTON_1 :	// next
				// go to next option
				if ( MenuPos < 29 ) 
				{
					MenuPos++;
					switch (MenuPos)
					{
						case 6 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString("  Footswitch 1  ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("  Preset        ");
						MIOS_LCD_CursorSet(0x40 + 11);
						MIOS_LCD_PrintBCD3(FootPreset[0]);
						break;
						case 7 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString("  Footswitch 2  ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("  Preset        ");
						MIOS_LCD_CursorSet(0x40 + 11);
						MIOS_LCD_PrintBCD3(FootPreset[1]);
						break;
						case 8 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString("  Footswitch 3  ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("  Preset        ");
						MIOS_LCD_CursorSet(0x40 + 11);
						MIOS_LCD_PrintBCD3(FootPreset[2]);
						break;
						case 9 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString("  Footswitch 4  ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("  Preset        ");
						MIOS_LCD_CursorSet(0x40 + 11);
						MIOS_LCD_PrintBCD3(FootPreset[3]);
						break;
						case 10 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString("  MIDI channel  ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("                ");
						MIOS_LCD_CursorSet(0x40 + 7);
						MIOS_LCD_PrintBCD2(MidiChannel);
						break;
						case 11 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString(" Startup Preset ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("                ");
						if ( ThisStartupPreset == 0 )
						{
							MIOS_LCD_CursorSet(0x40 + 1);
							MIOS_LCD_PrintCString(" ** Last Used **");
						}
						else
						{	
							MIOS_LCD_CursorSet(0x40 + 7);
							MIOS_LCD_PrintBCD2(ThisStartupPreset);
						}
						break;
						case 12 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString("  Send MIDI ?   ");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("                ");
						MIOS_LCD_CursorSet(0x40 + 7);
						SendMidiOnButtonChange ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
						break;
						case 13 :
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString(" Reload Active ?");
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("                ");
						MIOS_LCD_CursorSet(0x40 + 7);
						ReloadActivePreset ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
						break;
						case 14:
						case 15:
						case 16:
						case 17:
						case 18:
						case 19:
						case 20:
						case 21:
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString(" Output   type ");
						MIOS_LCD_CursorSet(0x00 + 9);
						MIOS_LCD_PrintBCD1(MenuPos-13); //output number
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("                ");
						MIOS_LCD_CursorSet(0x40 + 3);
						RelayType[MenuPos-14] ? MIOS_LCD_PrintCString("Momentary") : MIOS_LCD_PrintCString("Toggle");
						break;
						case 22:
						case 23:
						case 24:
						case 25:
						case 26:
						case 27:
						case 28:
						case 29:
						MIOS_LCD_CursorSet(0x00 + 1);
						MIOS_LCD_PrintCString(" Output   mode ");
						MIOS_LCD_CursorSet(0x00 + 9);
						MIOS_LCD_PrintBCD1(MenuPos-21); //output number
						MIOS_LCD_CursorSet(0x40 + 1);
						MIOS_LCD_PrintCString("                ");
						MIOS_LCD_CursorSet(0x40 + 3);
						RelayMode[MenuPos-22] ? MIOS_LCD_PrintCString("Radio") : MIOS_LCD_PrintCString("Free");
						break;
					}
				}
				else
				{ 
					MenuPos=6;
					MIOS_LCD_CursorSet(0x00 + 1);
					MIOS_LCD_PrintCString("  Footswitch 1  ");
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("  Preset        ");
					MIOS_LCD_CursorSet(0x40 + 10);
					MIOS_LCD_PrintBCD3(FootPreset[0]);
				}
				break;
			
			case MENU_BUTTON_2 :	// quit (& save)
				// save global options
				SaveGlobalOptions();
				// exit menu
				MenuPos = 0;
				// show message
				MIOS_LCD_Clear();
				MIOS_LCD_CursorSet(0x00 + 0);
				MIOS_LCD_PrintCString("**   Options  **");
				MIOS_LCD_CursorSet(0x40 + 0);
				MIOS_LCD_PrintCString("**    Saved   **");
				MIOS_LCD_MessageStart(100);
				break;

			case MENU_BUTTON_3 :	// UP
			case MENU_BUTTON_4 :	// DOWN
				switch (MenuPos)
				{
					case 6 : //footswitch assignation
					case 7 :
					case 8 :
					case 9 :
					if ( (LastButton-4) == 0 ) // Down button
					{
						if ( FootPreset[MenuPos-6] > 0) 
							{ FootPreset[MenuPos-6]--; }
						else
							{ FootPreset[MenuPos-6] = 100; }
					}
					else if ( (LastButton-3) == 0 ) // Up button
					{
						if ( FootPreset[MenuPos-6] < 100) 
							{ FootPreset[MenuPos-6]++; }
						else
							{ FootPreset[MenuPos-6] = 0; }
					}
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("  Preset        ");
					MIOS_LCD_CursorSet(0x40 + 11);
					MIOS_LCD_PrintBCD3(FootPreset[MenuPos-6]);
					break;
					case 10 : // change midi channel
					if ( (LastButton-4) == 0 ) // Down button
					{
						if ( MidiChannel > 0) 
							{ MidiChannel--; }
						else
							{ MidiChannel = 16; }
					}
					else if ( (LastButton-3) == 0 ) // Up button
					{
						if ( MidiChannel < 16) 
							{ MidiChannel++; }
						else
							{ MidiChannel = 0; }
					}
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("                ");
					MIOS_LCD_CursorSet(0x40 + 7);
					if ( MidiChannel == 0 )
                    {
                        MIOS_LCD_PrintCString("All");
                    }
                    else
                    {
                        MIOS_LCD_PrintBCD2(MidiChannel);
                    }                        
					break;
					case 11 : // startup preset
					if ( (LastButton-4) == 0 ) // Down button
					{
						if ( ThisStartupPreset > 0) 
							{ ThisStartupPreset--; }
						else
							{ ThisStartupPreset = 100; }
					}
					else if ( (LastButton-3) == 0 ) // Up button
					{
						if ( ThisStartupPreset < 100) 
							{ ThisStartupPreset++; }
						else
							{ ThisStartupPreset = 0; }
					}
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("                ");
					if ( ThisStartupPreset == 0 )
					{
						MIOS_LCD_CursorSet(0x40 + 1);
                        MIOS_LCD_PrintCString(" ** Last Used **");
                        ForceStartupPreset = 0;
					}
					else
					{	
						MIOS_LCD_CursorSet(0x40 + 7);
						MIOS_LCD_PrintBCD2(ThisStartupPreset);
                        ForceStartupPreset = 1;
					}
					break;
					case 12 : // send midi on change ?
					SendMidiOnButtonChange = !SendMidiOnButtonChange;
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("                ");
					MIOS_LCD_CursorSet(0x40 + 7);
					SendMidiOnButtonChange ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
					break;
					case 13 : // reload active preset ?
					ReloadActivePreset = !ReloadActivePreset;
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("                ");
					MIOS_LCD_CursorSet(0x40 + 7);
					ReloadActivePreset ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
					break;
					case 14:
					case 15:
					case 16:
					case 17:
					case 18:
					case 19:
					case 20:
					case 21: // relay type
					RelayType[MenuPos-14]=!RelayType[MenuPos-14];
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("                ");
					MIOS_LCD_CursorSet(0x40 + 3);
					RelayType[MenuPos-14] ? MIOS_LCD_PrintCString("Momentary") : MIOS_LCD_PrintCString("Toggle");
					break;
					case 22:
					case 23:
					case 24:
					case 25:
					case 26:
					case 27:
					case 28:
					case 29: // relay mode
					RelayMode[MenuPos-22]=!RelayMode[MenuPos-22];
					MIOS_LCD_CursorSet(0x40 + 1);
					MIOS_LCD_PrintCString("                ");
					MIOS_LCD_CursorSet(0x40 + 3);
					RelayMode[MenuPos-22] ? MIOS_LCD_PrintCString("Radio") : MIOS_LCD_PrintCString("Free");
					break;
				}
				break;				
		}
			
	}
	
	// Init variable
	LastButton = 0;
	
}

/////////////////////////////////////////////////////////////////////////////
// This function is periodically called by MIOS. The frequency has to be
// initialized with MIOS_Timer_Set
/////////////////////////////////////////////////////////////////////////////
void Timer(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when the display content should be 
// initialized. Thats the case during startup and after a temporary message
// has been printed on the screen
/////////////////////////////////////////////////////////////////////////////
void DISPLAY_Init(void) __wparam
{
  MIOS_LCD_Clear();
  MIOS_LCD_CursorSet(0x00 + 0);
  MIOS_LCD_PrintCString("PROG");
  MIOS_LCD_CursorSet(0x40 + 0);
  MIOS_LCD_PrintCString("OPTS");
  MIOS_LCD_CursorSet(0x00 + 6);
  MIOS_LCD_PrintCString("Preset ");
  MIOS_LCD_CursorSet(0x40 + 8);
  MIOS_LCD_PrintBCD3(CurrentPreset);
}

/////////////////////////////////////////////////////////////////////////////
//  This function is called in the mainloop when no temporary message is shown
//  on screen. Print the realtime messages here
/////////////////////////////////////////////////////////////////////////////
void DISPLAY_Tick(void) __wparam
{
	if ( MidiIn )
	{
		// midi in indicator
		MIOS_LCD_CursorSet(0x00 + 15);
		MIOS_LCD_PrintChar('M');
		MIOS_LCD_MessageStart(40);
		MidiIn=0;
	}
}

/////////////////////////////////////////////////////////////////////////////
//  This function is called by MIOS when a complete MIDI event has been received
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
{
// to identify the Channel, just read the rightmost hexadecimal digit.
// The last 4 bits (leftmost hexadecimal digit) identifies the MIDI event type:
// 8: Note Off
// 9: Note On
// A: Polyphonic Key Pressure (Poly Aftertouch)
// B: Control Change (CC)
// C: Program Change
// D: Channel Pressure  
// Example 
// 0x90 identifies a Note On event at the first Channel
// 0x91 identifies a Note On event at the second Channel
// ...
// 0xCF identifies a Program Change event at the 16th Channel

	#if DEBUG
	DEBUG_MSG_SendHeader();
	DEBUG_MSG_SendCString("Received Midi Message : ");
	DEBUG_MSG_SendBCD3(evnt0);
	DEBUG_MSG_SendChar(' ');
	DEBUG_MSG_SendBCD3(evnt1);
	DEBUG_MSG_SendChar(' ');
	DEBUG_MSG_SendBCD3(evnt2);
	DEBUG_MSG_SendFooter();
	#endif

    // update variable to show midi activity
    MidiIn = 1;

	// verify midi channel
	if ( (MidiChannel!=0) && ((evnt0 & 0x0F) != (MidiChannel-1)) )
	{
		//ignore message
		#if DEBUG
		DEBUG_MSG_SendHeader();
	  	DEBUG_MSG_SendCString("Ignored, Bad MIDI channel");
	  	DEBUG_MSG_SendFooter();
	  	#endif
		return;
	}
	
	// verify message type
	if ( (evnt0 & 0xF0) != 0xC0 ) //Program change messages only
	{
		//ignore message, return;
		#if DEBUG
		DEBUG_MSG_SendHeader();
	  	DEBUG_MSG_SendCString("Ignored, not a PC message");
	  	DEBUG_MSG_SendFooter();
	  	#endif
	  	return;
	}
	
	// verify data range (100 presets)
	// valid program change request is between midi evnt1 0 and 99
	if ( evnt1 <= 99 ) 
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("PC");
		DEBUG_MSG_SendBCD3(evnt1);
		DEBUG_MSG_SendCString(" : Loading preset");
		DEBUG_MSG_SendFooter();
		#endif

		//do reload active preset
		LoadPreset(evnt1+1);    // preset start @ 1
	}

	// PC 101 to 108 change relay state request
	// valid midi messages are evnt1 100 and 107
	else if  (evnt1 <= 107 )
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("PC");
		DEBUG_MSG_SendBCD3(evnt1);
		DEBUG_MSG_SendCString(" : Toggle Relay");
		DEBUG_MSG_SendBCD3(evnt1-99);
		DEBUG_MSG_SendCString(" Status");
		DEBUG_MSG_SendFooter();
		#endif
		
		DoRelay(evnt1-100);     // relays start @ 0
	}
	
	// PC 109 to 110 are program up/down request
	// valid midi messages are evnt1 108 and 109
	else if ( evnt1 == 108 )
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("PC109 : Up one preset");
		DEBUG_MSG_SendCString("from");
		DEBUG_MSG_SendBCD3(CurrentPreset);
		DEBUG_MSG_SendCString("to");
		DEBUG_MSG_SendBCD3(evnt1);
		DEBUG_MSG_SendFooter();
		#endif
		
		// One preset up
		if(!Preset_Up())
		{ return;}

	}
	else if ( evnt1 == 109 )
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("PC109 : Up one preset");
		DEBUG_MSG_SendCString("from");
		DEBUG_MSG_SendBCD3(CurrentPreset);
		DEBUG_MSG_SendCString("to");
		DEBUG_MSG_SendBCD3(evnt1);
		DEBUG_MSG_SendFooter();
		#endif

		// One preset down
		if(!Preset_Down())
		{ return;}

	}
	else	
	// not supported request
	{
		//ignore message
		#if DEBUG
		DEBUG_MSG_SendHeader();
	  	DEBUG_MSG_SendCString("Ignored Midi In message: ");
	  	DEBUG_MSG_SendBCD3(evnt0);
	  	DEBUG_MSG_SendChar(' ');
	  	DEBUG_MSG_SendBCD3(evnt1);
	  	DEBUG_MSG_SendChar(' ');
	  	DEBUG_MSG_SendBCD3(evnt2);
	  	DEBUG_MSG_SendCString("PC number too high");
	  	DEBUG_MSG_SendFooter();
	  	#endif
		return;
	}
    	
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI event has been received
// which has been specified in the MIOS_MPROC_EVENT_TABLE
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI event has not been completly
// received within 2 seconds
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyTimeout(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI byte has been received
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS before the shift register are loaded
/////////////////////////////////////////////////////////////////////////////
void SR_Service_Prepare(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS after the shift register have been loaded
/////////////////////////////////////////////////////////////////////////////
void SR_Service_Finish(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when an button has been toggled
// pin_value is 1 when button released, and 0 when button pressed
/////////////////////////////////////////////////////////////////////////////
void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
{
  unsigned char number;

	// My footswitches are not momentary, so the code react to both states
	number = FootButton(pin);
	if ( number > 0)
	{
		#if DEBUG
		DEBUG_MSG_SendHeader();
		DEBUG_MSG_SendCString("Footswitch: ");
		DEBUG_MSG_SendBCD3(pin);
		DEBUG_MSG_SendChar(' ');
		DEBUG_MSG_SendCString(pin_value ? "depressed" : "pressed");
		DEBUG_MSG_SendFooter();
		#endif
		
		LoadPreset( FootPreset[number-1] );
		return;
	}

	// we only need to react on the "pressed contact" for relay buttons
    if( pin_value == 0 ) 
    {
	  #if DEBUG
	  DEBUG_MSG_SendHeader();
	  DEBUG_MSG_SendCString("Button: ");
	  DEBUG_MSG_SendBCD3(pin);
	  DEBUG_MSG_SendChar(' ');
	  DEBUG_MSG_SendCString(pin_value ? "depressed" : "pressed");
	  DEBUG_MSG_SendFooter();
	  #endif
	  
	  number = RelayButton(pin);
	  if ( number )
	  {
		// Ready to activate relay
	    DoRelay(number-1);
	    return;
	  }
	  
	  number = MenuButton(pin);
	  if(( number == MENU_BUTTON_1 ) || ( number == MENU_BUTTON_2 ) ||
	  	 ( number == MENU_BUTTON_3 ) || ( number == MENU_BUTTON_4 ))
	  {
		LastButton = number;
		return;
	  }	  

	  #if DEBUG
	  DEBUG_MSG_SendHeader();
	  DEBUG_MSG_SendCString("NOTHING TO DO IN DIN NOTIFY");
	  DEBUG_MSG_SendFooter();
	  #endif
	}

}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when an encoder has been moved
// incrementer is positive when encoder has been turned clockwise, else
// it is negative
/////////////////////////////////////////////////////////////////////////////
void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a pot has been moved
/////////////////////////////////////////////////////////////////////////////
void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
{
}
