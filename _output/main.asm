;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.0 #5117 (Mar 23 2008) (Mac OS X i386)
; This file was generated Mon Feb  4 11:12:39 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f452

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _MidiChannel
	global _CurrentPreset
	global _SendMidiOnButtonChange
	global _ReloadActivePreset
	global _ForceStartupPreset
	global _ThisStartupPreset
	global _RelayType
	global _RelayMode
	global _FootPreset
	global _RelayState
	global _LastButton
	global _MenuPos
	global _TargetPreset
	global _MidiIn
	global _toggle_dout
	global _DoRelay
	global _FootButton
	global _RelayButton
	global _MenuButton
	global _LoadTestPreset
	global _LoadGlobalOptions
	global _SaveGlobalOptions
	global _SetActivePreset
	global _FootLedsOff
	global _SetFootLed
	global _LoadPreset
	global _SavePreset
	global _Preset_Up
	global _Preset_Down
	global _FactoryReset
	global _StartupPreset
	global _Init
	global _Tick
	global _Timer
	global _DISPLAY_Init
	global _DISPLAY_Tick
	global _MPROC_NotifyReceivedEvnt
	global _MPROC_NotifyFoundEvent
	global _MPROC_NotifyTimeout
	global _MPROC_NotifyReceivedByte
	global _SR_Service_Prepare
	global _SR_Service_Finish
	global _DIN_NotifyToggle
	global _ENC_NotifyChange
	global _AIN_NotifyChange
	global _RelayLedPin
	global _RelayPin
	global _FootLedPin
	global _ButtonPin
	global _MenuButtonPin
	global _FootButtonPin

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _MIOS_BOX_CFG0
	extern _MIOS_BOX_CFG1
	extern _MIOS_BOX_STAT
	extern _MIOS_PARAMETER1
	extern _MIOS_PARAMETER2
	extern _MIOS_PARAMETER3
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _LVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _LVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _MIOS_MIDI_BeginStream
	extern _MIOS_MIDI_EndStream
	extern _MIOS_MIDI_TxBufferPut
	extern _MIOS_DOUT_PinSet
	extern _MIOS_DOUT_PinSet0
	extern _MIOS_DOUT_PinSet1
	extern _MIOS_SRIO_NumberSet
	extern _MIOS_SRIO_UpdateFrqSet
	extern _MIOS_SRIO_DebounceSet
	extern _MIOS_LCD_Clear
	extern _MIOS_LCD_CursorSet
	extern _MIOS_LCD_PrintBCD1
	extern _MIOS_LCD_PrintBCD2
	extern _MIOS_LCD_PrintBCD3
	extern _MIOS_LCD_PrintChar
	extern _MIOS_LCD_MessageStart
	extern _MIOS_LCD_PrintCString
	extern _MIOS_EEPROM_Read
	extern _MIOS_EEPROM_Write
	extern _MIOS_Delay
	extern _DEBUG_MSG_SendHeader
	extern _DEBUG_MSG_SendFooter
	extern _DEBUG_MSG_SendChar
	extern _DEBUG_MSG_SendCString
	extern _DEBUG_MSG_SendBCD1
	extern _DEBUG_MSG_SendBCD3
	extern _mios_enc_pin_table
	extern _mios_mproc_event_table
	extern _MIOS_MPROC_EVENT_TABLE
	extern _MIOS_ENC_PIN_TABLE
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
TBLPTRU	equ	0xff8
TABLAT	equ	0xff5
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1

udata_main_0	udata
_RelayType	res	8

udata_main_1	udata
_RelayState	res	8

udata_main_2	udata
_RelayMode	res	8

udata_main_3	udata
_MidiChannel	res	1

udata_main_4	udata
_CurrentPreset	res	1

udata_main_5	udata
_SendMidiOnButtonChange	res	1

udata_main_6	udata
_ReloadActivePreset	res	1

udata_main_7	udata
_ForceStartupPreset	res	1

udata_main_8	udata
_ThisStartupPreset	res	1

udata_main_9	udata
_FootPreset	res	4

udata_main_10	udata
_LoadPreset_TargetRelayState_1_1	res	8

udata_main_11	udata
_LastButton	res	1

udata_main_12	udata
_MenuPos	res	1

udata_main_13	udata
_MidiIn	res	1

udata_main_14	udata
_TargetPreset	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__AIN_NotifyChange	code
_AIN_NotifyChange:
;	.line	1581; main.c	void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	1583; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ENC_NotifyChange	code
_ENC_NotifyChange:
;	.line	1574; main.c	void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	1576; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DIN_NotifyToggle	code
_DIN_NotifyToggle:
;	.line	1511; main.c	void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
;	.line	1516; main.c	number = FootButton(pin);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_FootButton
	MOVWF	r0x02
	INCF	FSR1L, F
;	.line	1517; main.c	if ( number > 0)
	MOVF	r0x02, W
	BTFSC	STATUS, 2
	BRA	_00726_DS_
;	.line	1520; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1521; main.c	DEBUG_MSG_SendCString("Footswitch: ");
	MOVLW	UPPER(__str_71)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_71)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_71)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1522; main.c	DEBUG_MSG_SendBCD3(pin);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1523; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	1524; main.c	DEBUG_MSG_SendCString(pin_value ? "depressed" : "pressed");
	MOVF	r0x01, W
	BZ	_00738_DS_
	MOVLW	LOW(__str_72)
	MOVWF	r0x03
	MOVLW	HIGH(__str_72)
	MOVWF	r0x04
	MOVLW	UPPER(__str_72)
	MOVWF	r0x05
	BRA	_00739_DS_
_00738_DS_:
	MOVLW	LOW(__str_73)
	MOVWF	r0x03
	MOVLW	HIGH(__str_73)
	MOVWF	r0x04
	MOVLW	UPPER(__str_73)
	MOVWF	r0x05
_00739_DS_:
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1525; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1528; main.c	LoadPreset( FootPreset[number-1] );
	DECF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	LOW(_FootPreset)
	ADDWF	r0x03, F
	MOVLW	HIGH(_FootPreset)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_LoadPreset
	INCF	FSR1L, F
;	.line	1529; main.c	return;
	BRA	_00736_DS_
_00726_DS_:
;	.line	1533; main.c	if( pin_value == 0 ) 
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00736_DS_
;	.line	1536; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1537; main.c	DEBUG_MSG_SendCString("Button: ");
	MOVLW	UPPER(__str_74)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_74)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_74)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1538; main.c	DEBUG_MSG_SendBCD3(pin);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1539; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	1540; main.c	DEBUG_MSG_SendCString(pin_value ? "depressed" : "pressed");
	MOVF	r0x01, W
	BZ	_00740_DS_
	MOVLW	LOW(__str_72)
	MOVWF	r0x01
	MOVLW	HIGH(__str_72)
	MOVWF	r0x03
	MOVLW	UPPER(__str_72)
	MOVWF	r0x04
	BRA	_00741_DS_
_00740_DS_:
	MOVLW	LOW(__str_73)
	MOVWF	r0x01
	MOVLW	HIGH(__str_73)
	MOVWF	r0x03
	MOVLW	UPPER(__str_73)
	MOVWF	r0x04
_00741_DS_:
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1541; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1544; main.c	number = RelayButton(pin);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_RelayButton
	MOVWF	r0x02
	INCF	FSR1L, F
;	.line	1545; main.c	if ( number )
	MOVF	r0x02, W
	BZ	_00728_DS_
;	.line	1548; main.c	DoRelay(number-1);
	DECF	r0x02, W
	MOVWF	r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_DoRelay
	INCF	FSR1L, F
;	.line	1549; main.c	return;
	BRA	_00736_DS_
_00728_DS_:
;	.line	1552; main.c	number = MenuButton(pin);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MenuButton
	MOVWF	r0x02
	INCF	FSR1L, F
;	.line	1553; main.c	if(( number == MENU_BUTTON_1 ) || ( number == MENU_BUTTON_2 ) ||
	MOVF	r0x02, W
	XORLW	0x01
	BZ	_00729_DS_
	MOVF	r0x02, W
	XORLW	0x02
	BZ	_00729_DS_
;	.line	1554; main.c	( number == MENU_BUTTON_3 ) || ( number == MENU_BUTTON_4 ))
	MOVF	r0x02, W
	XORLW	0x03
	BZ	_00729_DS_
	MOVF	r0x02, W
	XORLW	0x04
	BNZ	_00730_DS_
_00729_DS_:
;	.line	1556; main.c	LastButton = number;
	MOVFF	r0x02, _LastButton
;	.line	1557; main.c	return;
	BRA	_00736_DS_
_00730_DS_:
;	.line	1561; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1562; main.c	DEBUG_MSG_SendCString("NOTHING TO DO IN DIN NOTIFY");
	MOVLW	UPPER(__str_75)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_75)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_75)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1563; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
_00736_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Finish	code
_SR_Service_Finish:
;	.line	1505; main.c	}
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Prepare	code
_SR_Service_Prepare:
;	.line	1498; main.c	}
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedByte	code
_MPROC_NotifyReceivedByte:
;	.line	1489; main.c	void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	1491; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyTimeout	code
_MPROC_NotifyTimeout:
;	.line	1484; main.c	}
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyFoundEvent	code
_MPROC_NotifyFoundEvent:
;	.line	1474; main.c	void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	1476; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedEvnt	code
_MPROC_NotifyReceivedEvnt:
;	.line	1327; main.c	void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
	MOVLW	0x03
	MOVFF	PLUSW2, r0x02
;	.line	1344; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1345; main.c	DEBUG_MSG_SendCString("Received Midi Message : ");
	MOVLW	UPPER(__str_59)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_59)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_59)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1346; main.c	DEBUG_MSG_SendBCD3(evnt0);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1347; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	1348; main.c	DEBUG_MSG_SendBCD3(evnt1);
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1349; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	1350; main.c	DEBUG_MSG_SendBCD3(evnt2);
	MOVF	r0x02, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1351; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1355; main.c	MidiIn = 1;
	MOVLW	0x01
	BANKSEL	_MidiIn
	MOVWF	_MidiIn, B
	BANKSEL	_MidiChannel
;	.line	1358; main.c	if ( (MidiChannel!=0) && ((evnt0 & 0x0F) != (MidiChannel-1)) )
	MOVF	_MidiChannel, W, B
	BZ	_00658_DS_
	MOVLW	0x0f
	ANDWF	r0x00, W
	MOVWF	r0x03
	MOVFF	_MidiChannel, r0x04
	CLRF	r0x05
	MOVLW	0xff
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	CLRF	r0x06
	MOVF	r0x03, W
	XORWF	r0x04, W
	BNZ	_00691_DS_
	MOVF	r0x06, W
	XORWF	r0x05, W
	BZ	_00658_DS_
_00691_DS_:
;	.line	1362; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1363; main.c	DEBUG_MSG_SendCString("Ignored, Bad MIDI channel");
	MOVLW	UPPER(__str_60)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_60)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_60)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1364; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1366; main.c	return;
	BRA	_00678_DS_
_00658_DS_:
;	.line	1370; main.c	if ( (evnt0 & 0xF0) != 0xC0 ) //Program change messages only
	MOVLW	0xf0
	ANDWF	r0x00, W
	MOVWF	r0x03
	MOVF	r0x03, W
	XORLW	0xc0
	BZ	_00661_DS_
;	.line	1374; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1375; main.c	DEBUG_MSG_SendCString("Ignored, not a PC message");
	MOVLW	UPPER(__str_61)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_61)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_61)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1376; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1378; main.c	return;
	BRA	_00678_DS_
_00661_DS_:
;	.line	1383; main.c	if ( evnt1 <= 99 ) 
	MOVLW	0x64
	SUBWF	r0x01, W
	BC	_00676_DS_
;	.line	1386; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1387; main.c	DEBUG_MSG_SendCString("PC");
	MOVLW	UPPER(__str_62)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_62)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_62)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1388; main.c	DEBUG_MSG_SendBCD3(evnt1);
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1389; main.c	DEBUG_MSG_SendCString(" : Loading preset");
	MOVLW	UPPER(__str_63)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_63)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_63)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1390; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1394; main.c	LoadPreset(evnt1+1);    // preset start @ 1
	INCF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_LoadPreset
	INCF	FSR1L, F
	BRA	_00678_DS_
_00676_DS_:
;	.line	1399; main.c	else if  (evnt1 <= 107 )
	MOVLW	0x6c
	SUBWF	r0x01, W
	BC	_00673_DS_
;	.line	1402; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1403; main.c	DEBUG_MSG_SendCString("PC");
	MOVLW	UPPER(__str_62)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_62)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_62)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1404; main.c	DEBUG_MSG_SendBCD3(evnt1);
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1405; main.c	DEBUG_MSG_SendCString(" : Toggle Relay");
	MOVLW	UPPER(__str_64)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_64)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_64)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1406; main.c	DEBUG_MSG_SendBCD3(evnt1-99);
	MOVLW	0x9d
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1407; main.c	DEBUG_MSG_SendCString(" Status");
	MOVLW	UPPER(__str_65)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_65)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_65)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1408; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1411; main.c	DoRelay(evnt1-100);     // relays start @ 0
	MOVLW	0x9c
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_DoRelay
	INCF	FSR1L, F
	BRA	_00678_DS_
_00673_DS_:
;	.line	1416; main.c	else if ( evnt1 == 108 )
	MOVF	r0x01, W
	XORLW	0x6c
	BNZ	_00670_DS_
;	.line	1419; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1420; main.c	DEBUG_MSG_SendCString("PC109 : Up one preset");
	MOVLW	UPPER(__str_66)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_66)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_66)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1421; main.c	DEBUG_MSG_SendCString("from");
	MOVLW	UPPER(__str_67)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_67)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_67)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_CurrentPreset
;	.line	1422; main.c	DEBUG_MSG_SendBCD3(CurrentPreset);
	MOVF	_CurrentPreset, W, B
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1423; main.c	DEBUG_MSG_SendCString("to");
	MOVLW	UPPER(__str_68)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_68)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_68)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1424; main.c	DEBUG_MSG_SendBCD3(evnt1);
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1425; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1429; main.c	if(!Preset_Up())
	CALL	_Preset_Up
	MOVWF	r0x03
	MOVF	r0x03, W
	BTFSS	STATUS, 2
	BRA	_00678_DS_
;	.line	1430; main.c	{ return;}
	BRA	_00678_DS_
_00670_DS_:
;	.line	1433; main.c	else if ( evnt1 == 109 )
	MOVF	r0x01, W
	XORLW	0x6d
	BNZ	_00667_DS_
;	.line	1436; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1437; main.c	DEBUG_MSG_SendCString("PC109 : Up one preset");
	MOVLW	UPPER(__str_66)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_66)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_66)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1438; main.c	DEBUG_MSG_SendCString("from");
	MOVLW	UPPER(__str_67)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_67)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_67)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_CurrentPreset
;	.line	1439; main.c	DEBUG_MSG_SendBCD3(CurrentPreset);
	MOVF	_CurrentPreset, W, B
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1440; main.c	DEBUG_MSG_SendCString("to");
	MOVLW	UPPER(__str_68)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_68)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_68)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1441; main.c	DEBUG_MSG_SendBCD3(evnt1);
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1442; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	1446; main.c	if(!Preset_Down())
	CALL	_Preset_Down
	MOVWF	r0x03
	MOVF	r0x03, W
	BNZ	_00678_DS_
;	.line	1447; main.c	{ return;}
	BRA	_00678_DS_
_00667_DS_:
;	.line	1455; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	1456; main.c	DEBUG_MSG_SendCString("Ignored Midi In message: ");
	MOVLW	UPPER(__str_69)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_69)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_69)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1457; main.c	DEBUG_MSG_SendBCD3(evnt0);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1458; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	1459; main.c	DEBUG_MSG_SendBCD3(evnt1);
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1460; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	1461; main.c	DEBUG_MSG_SendBCD3(evnt2);
	MOVF	r0x02, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	1462; main.c	DEBUG_MSG_SendCString("PC number too high");
	MOVLW	UPPER(__str_70)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_70)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_70)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1463; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
_00678_DS_:
;	.line	1465; main.c	return;
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Tick	code
_DISPLAY_Tick:
	BANKSEL	_MidiIn
;	.line	1314; main.c	if ( MidiIn )
	MOVF	_MidiIn, W, B
	BZ	_00652_DS_
;	.line	1317; main.c	MIOS_LCD_CursorSet(0x00 + 15);
	MOVLW	0x0f
	CALL	_MIOS_LCD_CursorSet
;	.line	1318; main.c	MIOS_LCD_PrintChar('M');
	MOVLW	0x4d
	CALL	_MIOS_LCD_PrintChar
;	.line	1319; main.c	MIOS_LCD_MessageStart(40);
	MOVLW	0x28
	CALL	_MIOS_LCD_MessageStart
	BANKSEL	_MidiIn
;	.line	1320; main.c	MidiIn=0;
	CLRF	_MidiIn, B
_00652_DS_:
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Init	code
_DISPLAY_Init:
;	.line	1297; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	1298; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	1299; main.c	MIOS_LCD_PrintCString("PROG");
	MOVLW	UPPER(__str_56)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_56)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_56)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1300; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	1301; main.c	MIOS_LCD_PrintCString("OPTS");
	MOVLW	UPPER(__str_57)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_57)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_57)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1302; main.c	MIOS_LCD_CursorSet(0x00 + 6);
	MOVLW	0x06
	CALL	_MIOS_LCD_CursorSet
;	.line	1303; main.c	MIOS_LCD_PrintCString("Preset ");
	MOVLW	UPPER(__str_58)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_58)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_58)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1304; main.c	MIOS_LCD_CursorSet(0x40 + 8);
	MOVLW	0x48
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_CurrentPreset
;	.line	1305; main.c	MIOS_LCD_PrintBCD3(CurrentPreset);
	MOVF	_CurrentPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
	RETURN	

; ; Starting pCode block
S_main__Timer	code
_Timer:
;	.line	1288; main.c	}
	RETURN	

; ; Starting pCode block
S_main__Tick	code
_Tick:
;	.line	895; main.c	void Tick(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	BANKSEL	_MenuPos
;	.line	898; main.c	if ( MenuPos == 0 ) // default screen
	MOVF	_MenuPos, W, B
	BTFSS	STATUS, 2
	BRA	_00562_DS_
;	.line	900; main.c	switch (LastButton)
	MOVLW	0x05
	BANKSEL	_LastButton
	SUBWF	_LastButton, W, B
	BTFSC	STATUS, 0
	GOTO	_00563_DS_
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
; removed redundant BANKSEL
	RLCF	_LastButton, W, B
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00621_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00621_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00621_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00621_DS_:
	GOTO	_00432_DS_
	GOTO	_00433_DS_
	GOTO	_00434_DS_
	GOTO	_00435_DS_
	GOTO	_00436_DS_
_00432_DS_:
;	.line	903; main.c	break;
	GOTO	_00563_DS_
_00433_DS_:
;	.line	907; main.c	MenuPos = 1;
	MOVLW	0x01
	BANKSEL	_MenuPos
	MOVWF	_MenuPos, B
;	.line	909; main.c	TargetPreset = CurrentPreset;
	MOVFF	_CurrentPreset, _TargetPreset
;	.line	910; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	911; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	912; main.c	MIOS_LCD_PrintCString("SAVE");
	MOVLW	UPPER(__str_28)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_28)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_28)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	913; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	914; main.c	MIOS_LCD_PrintCString("BACK");
	MOVLW	UPPER(__str_29)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_29)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_29)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	915; main.c	MIOS_LCD_CursorSet(0x00 + 6);
	MOVLW	0x06
	CALL	_MIOS_LCD_CursorSet
;	.line	916; main.c	MIOS_LCD_PrintCString("to preset ");
	MOVLW	UPPER(__str_30)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_30)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_30)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	917; main.c	MIOS_LCD_CursorSet(0x40 + 8);
	MOVLW	0x48
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_TargetPreset
;	.line	918; main.c	MIOS_LCD_PrintBCD3(TargetPreset);
	MOVF	_TargetPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	919; main.c	break;
	GOTO	_00563_DS_
_00434_DS_:
;	.line	923; main.c	MenuPos = 6;
	MOVLW	0x06
	BANKSEL	_MenuPos
	MOVWF	_MenuPos, B
;	.line	925; main.c	TargetPreset = CurrentPreset;
	MOVFF	_CurrentPreset, _TargetPreset
;	.line	926; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	927; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	928; main.c	MIOS_LCD_PrintCString(">");
	MOVLW	UPPER(__str_31)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_31)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_31)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	929; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	930; main.c	MIOS_LCD_PrintCString("Q");
	MOVLW	UPPER(__str_32)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_32)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_32)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	931; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	932; main.c	MIOS_LCD_PrintCString("  Footswitch 1  ");
	MOVLW	UPPER(__str_33)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_33)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_33)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	933; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	934; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	935; main.c	MIOS_LCD_CursorSet(0x40 + 11);
	MOVLW	0x4b
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_FootPreset
;	.line	936; main.c	MIOS_LCD_PrintBCD3(FootPreset[0]);
	MOVF	_FootPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	937; main.c	break;
	GOTO	_00563_DS_
_00435_DS_:
;	.line	940; main.c	Preset_Up();
	CALL	_Preset_Up
;	.line	941; main.c	break;
	GOTO	_00563_DS_
_00436_DS_:
;	.line	944; main.c	Preset_Down();
	CALL	_Preset_Down
;	.line	946; main.c	}
	GOTO	_00563_DS_
_00562_DS_:
	BANKSEL	_MenuPos
;	.line	948; main.c	else if ( MenuPos == 1 ) // PROG menu
	MOVF	_MenuPos, W, B
	XORLW	0x01
	BZ	_00623_DS_
	BRA	_00559_DS_
_00623_DS_:
;	.line	950; main.c	switch (LastButton)
	MOVLW	0x05
	BANKSEL	_LastButton
	SUBWF	_LastButton, W, B
	BTFSC	STATUS, 0
	GOTO	_00563_DS_
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
; removed redundant BANKSEL
	RLCF	_LastButton, W, B
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00625_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00625_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00625_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00625_DS_:
	GOTO	_00438_DS_
	GOTO	_00439_DS_
	GOTO	_00440_DS_
	GOTO	_00442_DS_
	GOTO	_00442_DS_
_00438_DS_:
;	.line	953; main.c	break;
	GOTO	_00563_DS_
_00439_DS_:
	BANKSEL	_TargetPreset
;	.line	957; main.c	SavePreset(TargetPreset);
	MOVF	_TargetPreset, W, B
	MOVWF	POSTDEC1
	CALL	_SavePreset
	INCF	FSR1L, F
	BANKSEL	_TargetPreset
;	.line	958; main.c	SetActivePreset(TargetPreset);
	MOVF	_TargetPreset, W, B
	MOVWF	POSTDEC1
	CALL	_SetActivePreset
	INCF	FSR1L, F
	BANKSEL	_MenuPos
;	.line	960; main.c	MenuPos = 0;
	CLRF	_MenuPos, B
;	.line	961; main.c	break;
	GOTO	_00563_DS_
_00440_DS_:
	BANKSEL	_MenuPos
;	.line	965; main.c	MenuPos = 0;
	CLRF	_MenuPos, B
;	.line	967; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	968; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	969; main.c	MIOS_LCD_PrintCString("**   Nothing  **");
	MOVLW	UPPER(__str_35)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_35)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_35)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	970; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	971; main.c	MIOS_LCD_PrintCString("**    Saved   **");
	MOVLW	UPPER(__str_36)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_36)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_36)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	972; main.c	MIOS_LCD_MessageStart(100);
	MOVLW	0x64
	CALL	_MIOS_LCD_MessageStart
;	.line	973; main.c	break;
	GOTO	_00563_DS_
_00442_DS_:
;	.line	977; main.c	if ( (LastButton-4) == 0 ) // Down button
	MOVFF	_LastButton, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	ADDLW	0xfc
	MOVWF	r0x02
	MOVLW	0xff
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	IORWF	r0x03, W
	BNZ	_00452_DS_
;	.line	979; main.c	if ( TargetPreset > 1) 
	MOVLW	0x02
	BANKSEL	_TargetPreset
	SUBWF	_TargetPreset, W, B
	BNC	_00444_DS_
; removed redundant BANKSEL
;	.line	980; main.c	{ TargetPreset--; }
	DECF	_TargetPreset, F, B
	BRA	_00453_DS_
_00444_DS_:
;	.line	982; main.c	{ TargetPreset = 100; }
	MOVLW	0x64
	BANKSEL	_TargetPreset
	MOVWF	_TargetPreset, B
	BRA	_00453_DS_
_00452_DS_:
;	.line	984; main.c	else if ( (LastButton-3) == 0 ) // Up button
	MOVLW	0xfd
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00453_DS_
;	.line	986; main.c	if ( TargetPreset < 100) 
	MOVLW	0x64
	BANKSEL	_TargetPreset
	SUBWF	_TargetPreset, W, B
	BC	_00447_DS_
; removed redundant BANKSEL
;	.line	987; main.c	{ TargetPreset++; }
	INCF	_TargetPreset, F, B
	BRA	_00453_DS_
_00447_DS_:
;	.line	989; main.c	{ TargetPreset = 1; }
	MOVLW	0x01
	BANKSEL	_TargetPreset
	MOVWF	_TargetPreset, B
_00453_DS_:
;	.line	992; main.c	MIOS_LCD_CursorSet(0x40 + 8);
	MOVLW	0x48
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_TargetPreset
;	.line	993; main.c	MIOS_LCD_PrintBCD3(TargetPreset);
	MOVF	_TargetPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	995; main.c	}
	GOTO	_00563_DS_
_00559_DS_:
;	.line	997; main.c	else if ( MenuPos >= 6 ) // OPTS menu
	MOVLW	0x06
	BANKSEL	_MenuPos
	SUBWF	_MenuPos, W, B
	BTG	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	GOTO	_00563_DS_
;	.line	999; main.c	switch (LastButton)
	MOVLW	0x05
	BANKSEL	_LastButton
	SUBWF	_LastButton, W, B
	BTFSC	STATUS, 0
	GOTO	_00563_DS_
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
; removed redundant BANKSEL
	RLCF	_LastButton, W, B
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00631_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00631_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00631_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00631_DS_:
	GOTO	_00455_DS_
	GOTO	_00456_DS_
	GOTO	_00488_DS_
	GOTO	_00490_DS_
	GOTO	_00490_DS_
_00455_DS_:
;	.line	1002; main.c	break;
	GOTO	_00563_DS_
_00456_DS_:
;	.line	1006; main.c	if ( MenuPos < 29 ) 
	MOVLW	0x1d
	BANKSEL	_MenuPos
	SUBWF	_MenuPos, W, B
	BTFSC	STATUS, 0
	GOTO	_00486_DS_
; removed redundant BANKSEL
;	.line	1008; main.c	MenuPos++;
	INCF	_MenuPos, F, B
;	.line	1009; main.c	switch (MenuPos)
	MOVLW	0x06
; removed redundant BANKSEL
	SUBWF	_MenuPos, W, B
	BTFSS	STATUS, 0
	GOTO	_00563_DS_
	MOVLW	0x1e
; removed redundant BANKSEL
	SUBWF	_MenuPos, W, B
	BTFSC	STATUS, 0
	GOTO	_00563_DS_
	MOVLW	0xfa
; removed redundant BANKSEL
	ADDWF	_MenuPos, W, B
	MOVWF	r0x01
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
	RLCF	r0x01, W
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00635_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00635_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00635_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00635_DS_:
	GOTO	_00457_DS_
	GOTO	_00458_DS_
	GOTO	_00459_DS_
	GOTO	_00460_DS_
	GOTO	_00461_DS_
	GOTO	_00462_DS_
	GOTO	_00466_DS_
	GOTO	_00467_DS_
	GOTO	_00472_DS_
	GOTO	_00472_DS_
	GOTO	_00472_DS_
	GOTO	_00472_DS_
	GOTO	_00472_DS_
	GOTO	_00473_DS_
	GOTO	_00474_DS_
	GOTO	_00475_DS_
	GOTO	_00480_DS_
	GOTO	_00480_DS_
	GOTO	_00480_DS_
	GOTO	_00480_DS_
	GOTO	_00480_DS_
	GOTO	_00481_DS_
	GOTO	_00482_DS_
	GOTO	_00483_DS_
_00457_DS_:
;	.line	1012; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1013; main.c	MIOS_LCD_PrintCString("  Footswitch 1  ");
	MOVLW	UPPER(__str_33)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_33)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_33)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1014; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1015; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1016; main.c	MIOS_LCD_CursorSet(0x40 + 11);
	MOVLW	0x4b
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_FootPreset
;	.line	1017; main.c	MIOS_LCD_PrintBCD3(FootPreset[0]);
	MOVF	_FootPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	1018; main.c	break;
	GOTO	_00563_DS_
_00458_DS_:
;	.line	1020; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1021; main.c	MIOS_LCD_PrintCString("  Footswitch 2  ");
	MOVLW	UPPER(__str_37)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_37)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_37)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1022; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1023; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1024; main.c	MIOS_LCD_CursorSet(0x40 + 11);
	MOVLW	0x4b
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	(_FootPreset + 1)
;	.line	1025; main.c	MIOS_LCD_PrintBCD3(FootPreset[1]);
	MOVF	(_FootPreset + 1), W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	1026; main.c	break;
	GOTO	_00563_DS_
_00459_DS_:
;	.line	1028; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1029; main.c	MIOS_LCD_PrintCString("  Footswitch 3  ");
	MOVLW	UPPER(__str_38)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_38)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_38)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1030; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1031; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1032; main.c	MIOS_LCD_CursorSet(0x40 + 11);
	MOVLW	0x4b
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	(_FootPreset + 2)
;	.line	1033; main.c	MIOS_LCD_PrintBCD3(FootPreset[2]);
	MOVF	(_FootPreset + 2), W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	1034; main.c	break;
	GOTO	_00563_DS_
_00460_DS_:
;	.line	1036; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1037; main.c	MIOS_LCD_PrintCString("  Footswitch 4  ");
	MOVLW	UPPER(__str_39)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_39)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_39)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1038; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1039; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1040; main.c	MIOS_LCD_CursorSet(0x40 + 11);
	MOVLW	0x4b
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	(_FootPreset + 3)
;	.line	1041; main.c	MIOS_LCD_PrintBCD3(FootPreset[3]);
	MOVF	(_FootPreset + 3), W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	1042; main.c	break;
	GOTO	_00563_DS_
_00461_DS_:
;	.line	1044; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1045; main.c	MIOS_LCD_PrintCString("  MIDI channel  ");
	MOVLW	UPPER(__str_40)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_40)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_40)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1046; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1047; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1048; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_MidiChannel
;	.line	1049; main.c	MIOS_LCD_PrintBCD2(MidiChannel);
	MOVF	_MidiChannel, W, B
	CALL	_MIOS_LCD_PrintBCD2
;	.line	1050; main.c	break;
	GOTO	_00563_DS_
_00462_DS_:
;	.line	1052; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1053; main.c	MIOS_LCD_PrintCString(" Startup Preset ");
	MOVLW	UPPER(__str_42)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_42)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_42)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1054; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1055; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_ThisStartupPreset
;	.line	1056; main.c	if ( ThisStartupPreset == 0 )
	MOVF	_ThisStartupPreset, W, B
	BNZ	_00464_DS_
;	.line	1058; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1059; main.c	MIOS_LCD_PrintCString(" ** Last Used **");
	MOVLW	UPPER(__str_43)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_43)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_43)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	GOTO	_00563_DS_
_00464_DS_:
;	.line	1063; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_ThisStartupPreset
;	.line	1064; main.c	MIOS_LCD_PrintBCD2(ThisStartupPreset);
	MOVF	_ThisStartupPreset, W, B
	CALL	_MIOS_LCD_PrintBCD2
;	.line	1066; main.c	break;
	GOTO	_00563_DS_
_00466_DS_:
;	.line	1068; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1069; main.c	MIOS_LCD_PrintCString("  Send MIDI ?   ");
	MOVLW	UPPER(__str_44)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_44)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_44)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1070; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1071; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1072; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_SendMidiOnButtonChange
;	.line	1073; main.c	SendMidiOnButtonChange ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
	MOVF	_SendMidiOnButtonChange, W, B
	BZ	_00566_DS_
	MOVLW	UPPER(__str_45)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_45)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_45)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	GOTO	_00563_DS_
_00566_DS_:
	MOVLW	UPPER(__str_46)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_46)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_46)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1074; main.c	break;
	GOTO	_00563_DS_
_00467_DS_:
;	.line	1076; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1077; main.c	MIOS_LCD_PrintCString(" Reload Active ?");
	MOVLW	UPPER(__str_47)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_47)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_47)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1078; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1079; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1080; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_ReloadActivePreset
;	.line	1081; main.c	ReloadActivePreset ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
	MOVF	_ReloadActivePreset, W, B
	BZ	_00568_DS_
	MOVLW	UPPER(__str_45)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_45)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_45)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	GOTO	_00563_DS_
_00568_DS_:
	MOVLW	UPPER(__str_46)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_46)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_46)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1082; main.c	break;
	GOTO	_00563_DS_
_00472_DS_:
_00473_DS_:
_00474_DS_:
_00475_DS_:
;	.line	1091; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1092; main.c	MIOS_LCD_PrintCString(" Output   type ");
	MOVLW	UPPER(__str_48)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_48)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_48)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1093; main.c	MIOS_LCD_CursorSet(0x00 + 9);
	MOVLW	0x09
	CALL	_MIOS_LCD_CursorSet
;	.line	1094; main.c	MIOS_LCD_PrintBCD1(MenuPos-13); //output number
	MOVLW	0xf3
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x01
	MOVF	r0x01, W
	CALL	_MIOS_LCD_PrintBCD1
;	.line	1095; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1096; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1097; main.c	MIOS_LCD_CursorSet(0x40 + 3);
	MOVLW	0x43
	CALL	_MIOS_LCD_CursorSet
;	.line	1098; main.c	RelayType[MenuPos-14] ? MIOS_LCD_PrintCString("Momentary") : MIOS_LCD_PrintCString("Toggle");
	MOVLW	0xf2
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_RelayType)
	ADDWF	r0x01, F
	MOVLW	HIGH(_RelayType)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	BZ	_00570_DS_
	MOVLW	UPPER(__str_49)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_49)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_49)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	GOTO	_00563_DS_
_00570_DS_:
	MOVLW	UPPER(__str_50)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_50)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_50)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1099; main.c	break;
	GOTO	_00563_DS_
_00480_DS_:
_00481_DS_:
_00482_DS_:
_00483_DS_:
;	.line	1108; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1109; main.c	MIOS_LCD_PrintCString(" Output   mode ");
	MOVLW	UPPER(__str_51)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_51)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_51)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1110; main.c	MIOS_LCD_CursorSet(0x00 + 9);
	MOVLW	0x09
	CALL	_MIOS_LCD_CursorSet
;	.line	1111; main.c	MIOS_LCD_PrintBCD1(MenuPos-21); //output number
	MOVLW	0xeb
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x01
	MOVF	r0x01, W
	CALL	_MIOS_LCD_PrintBCD1
;	.line	1112; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1113; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1114; main.c	MIOS_LCD_CursorSet(0x40 + 3);
	MOVLW	0x43
	CALL	_MIOS_LCD_CursorSet
;	.line	1115; main.c	RelayMode[MenuPos-22] ? MIOS_LCD_PrintCString("Radio") : MIOS_LCD_PrintCString("Free");
	MOVLW	0xea
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x01, F
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	BZ	_00572_DS_
	MOVLW	UPPER(__str_52)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_52)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_52)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	GOTO	_00563_DS_
_00572_DS_:
	MOVLW	UPPER(__str_53)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_53)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_53)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1117; main.c	}
	GOTO	_00563_DS_
_00486_DS_:
;	.line	1121; main.c	MenuPos=6;
	MOVLW	0x06
	BANKSEL	_MenuPos
	MOVWF	_MenuPos, B
;	.line	1122; main.c	MIOS_LCD_CursorSet(0x00 + 1);
	MOVLW	0x01
	CALL	_MIOS_LCD_CursorSet
;	.line	1123; main.c	MIOS_LCD_PrintCString("  Footswitch 1  ");
	MOVLW	UPPER(__str_33)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_33)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_33)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1124; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1125; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1126; main.c	MIOS_LCD_CursorSet(0x40 + 10);
	MOVLW	0x4a
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_FootPreset
;	.line	1127; main.c	MIOS_LCD_PrintBCD3(FootPreset[0]);
	MOVF	_FootPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	1129; main.c	break;
	GOTO	_00563_DS_
_00488_DS_:
;	.line	1133; main.c	SaveGlobalOptions();
	CALL	_SaveGlobalOptions
	BANKSEL	_MenuPos
;	.line	1135; main.c	MenuPos = 0;
	CLRF	_MenuPos, B
;	.line	1137; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	1138; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	1139; main.c	MIOS_LCD_PrintCString("**   Options  **");
	MOVLW	UPPER(__str_54)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_54)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_54)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1140; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	1141; main.c	MIOS_LCD_PrintCString("**    Saved   **");
	MOVLW	UPPER(__str_36)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_36)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_36)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1142; main.c	MIOS_LCD_MessageStart(100);
	MOVLW	0x64
	CALL	_MIOS_LCD_MessageStart
;	.line	1143; main.c	break;
	GOTO	_00563_DS_
_00490_DS_:
;	.line	1147; main.c	switch (MenuPos)
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	GOTO	_00563_DS_
	MOVLW	0x1e
	BANKSEL	_MenuPos
	SUBWF	_MenuPos, W, B
	BTFSC	STATUS, 0
	GOTO	_00563_DS_
	MOVLW	0xfa
; removed redundant BANKSEL
	ADDWF	_MenuPos, W, B
	MOVWF	r0x00
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
	RLCF	r0x00, W
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00637_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00637_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00637_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00637_DS_:
	GOTO	_00494_DS_
	GOTO	_00494_DS_
	GOTO	_00494_DS_
	GOTO	_00494_DS_
	GOTO	_00506_DS_
	GOTO	_00521_DS_
	GOTO	_00536_DS_
	GOTO	_00537_DS_
	GOTO	_00542_DS_
	GOTO	_00542_DS_
	GOTO	_00542_DS_
	GOTO	_00542_DS_
	GOTO	_00542_DS_
	GOTO	_00543_DS_
	GOTO	_00544_DS_
	GOTO	_00545_DS_
	GOTO	_00550_DS_
	GOTO	_00550_DS_
	GOTO	_00550_DS_
	GOTO	_00550_DS_
	GOTO	_00550_DS_
	GOTO	_00551_DS_
	GOTO	_00552_DS_
	GOTO	_00553_DS_
_00494_DS_:
;	.line	1153; main.c	if ( (LastButton-4) == 0 ) // Down button
	MOVFF	_LastButton, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	ADDLW	0xfc
	MOVWF	r0x03
	MOVLW	0xff
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVF	r0x03, W
	IORWF	r0x04, W
	BNZ	_00504_DS_
;	.line	1155; main.c	if ( FootPreset[MenuPos-6] > 0) 
	MOVLW	LOW(_FootPreset)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_FootPreset)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	BZ	_00496_DS_
;	.line	1156; main.c	{ FootPreset[MenuPos-6]--; }
	DECF	r0x05, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	r0x05, INDF0
	BRA	_00505_DS_
_00496_DS_:
;	.line	1158; main.c	{ FootPreset[MenuPos-6] = 100; }
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x64
	MOVWF	INDF0
	BRA	_00505_DS_
_00504_DS_:
;	.line	1160; main.c	else if ( (LastButton-3) == 0 ) // Up button
	MOVLW	0xfd
	ADDWF	r0x01, F
	BTFSS	STATUS, 0
	DECF	r0x02, F
	MOVF	r0x01, W
	IORWF	r0x02, W
	BNZ	_00505_DS_
;	.line	1162; main.c	if ( FootPreset[MenuPos-6] < 100) 
	CLRF	r0x01
	MOVLW	LOW(_FootPreset)
	ADDWF	r0x00, F
	MOVLW	HIGH(_FootPreset)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	MOVLW	0x64
	SUBWF	r0x02, W
	BC	_00499_DS_
;	.line	1163; main.c	{ FootPreset[MenuPos-6]++; }
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
	BRA	_00505_DS_
_00499_DS_:
;	.line	1165; main.c	{ FootPreset[MenuPos-6] = 0; }
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
_00505_DS_:
;	.line	1167; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1168; main.c	MIOS_LCD_PrintCString("  Preset        ");
	MOVLW	UPPER(__str_34)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_34)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_34)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1169; main.c	MIOS_LCD_CursorSet(0x40 + 11);
	MOVLW	0x4b
	CALL	_MIOS_LCD_CursorSet
;	.line	1170; main.c	MIOS_LCD_PrintBCD3(FootPreset[MenuPos-6]);
	MOVLW	0xfa
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	LOW(_FootPreset)
	ADDWF	r0x00, F
	MOVLW	HIGH(_FootPreset)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
;	.line	1171; main.c	break;
	BRA	_00563_DS_
_00506_DS_:
;	.line	1173; main.c	if ( (LastButton-4) == 0 ) // Down button
	MOVFF	_LastButton, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	ADDLW	0xfc
	MOVWF	r0x02
	MOVLW	0xff
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	IORWF	r0x03, W
	BNZ	_00516_DS_
	BANKSEL	_MidiChannel
;	.line	1175; main.c	if ( MidiChannel > 0) 
	MOVF	_MidiChannel, W, B
	BZ	_00508_DS_
; removed redundant BANKSEL
;	.line	1176; main.c	{ MidiChannel--; }
	DECF	_MidiChannel, F, B
	BRA	_00517_DS_
_00508_DS_:
;	.line	1178; main.c	{ MidiChannel = 16; }
	MOVLW	0x10
	BANKSEL	_MidiChannel
	MOVWF	_MidiChannel, B
	BRA	_00517_DS_
_00516_DS_:
;	.line	1180; main.c	else if ( (LastButton-3) == 0 ) // Up button
	MOVLW	0xfd
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00517_DS_
;	.line	1182; main.c	if ( MidiChannel < 16) 
	MOVLW	0x10
	BANKSEL	_MidiChannel
	SUBWF	_MidiChannel, W, B
	BC	_00511_DS_
; removed redundant BANKSEL
;	.line	1183; main.c	{ MidiChannel++; }
	INCF	_MidiChannel, F, B
	BRA	_00517_DS_
_00511_DS_:
	BANKSEL	_MidiChannel
;	.line	1185; main.c	{ MidiChannel = 0; }
	CLRF	_MidiChannel, B
_00517_DS_:
;	.line	1187; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1188; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1189; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_MidiChannel
;	.line	1190; main.c	if ( MidiChannel == 0 )
	MOVF	_MidiChannel, W, B
	BNZ	_00519_DS_
;	.line	1192; main.c	MIOS_LCD_PrintCString("All");
	MOVLW	UPPER(__str_55)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_55)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_55)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00563_DS_
_00519_DS_:
	BANKSEL	_MidiChannel
;	.line	1196; main.c	MIOS_LCD_PrintBCD2(MidiChannel);
	MOVF	_MidiChannel, W, B
	CALL	_MIOS_LCD_PrintBCD2
;	.line	1198; main.c	break;
	BRA	_00563_DS_
_00521_DS_:
;	.line	1200; main.c	if ( (LastButton-4) == 0 ) // Down button
	MOVFF	_LastButton, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	ADDLW	0xfc
	MOVWF	r0x02
	MOVLW	0xff
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	IORWF	r0x03, W
	BNZ	_00531_DS_
	BANKSEL	_ThisStartupPreset
;	.line	1202; main.c	if ( ThisStartupPreset > 0) 
	MOVF	_ThisStartupPreset, W, B
	BZ	_00523_DS_
; removed redundant BANKSEL
;	.line	1203; main.c	{ ThisStartupPreset--; }
	DECF	_ThisStartupPreset, F, B
	BRA	_00532_DS_
_00523_DS_:
;	.line	1205; main.c	{ ThisStartupPreset = 100; }
	MOVLW	0x64
	BANKSEL	_ThisStartupPreset
	MOVWF	_ThisStartupPreset, B
	BRA	_00532_DS_
_00531_DS_:
;	.line	1207; main.c	else if ( (LastButton-3) == 0 ) // Up button
	MOVLW	0xfd
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00532_DS_
;	.line	1209; main.c	if ( ThisStartupPreset < 100) 
	MOVLW	0x64
	BANKSEL	_ThisStartupPreset
	SUBWF	_ThisStartupPreset, W, B
	BC	_00526_DS_
; removed redundant BANKSEL
;	.line	1210; main.c	{ ThisStartupPreset++; }
	INCF	_ThisStartupPreset, F, B
	BRA	_00532_DS_
_00526_DS_:
	BANKSEL	_ThisStartupPreset
;	.line	1212; main.c	{ ThisStartupPreset = 0; }
	CLRF	_ThisStartupPreset, B
_00532_DS_:
;	.line	1214; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1215; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_ThisStartupPreset
;	.line	1216; main.c	if ( ThisStartupPreset == 0 )
	MOVF	_ThisStartupPreset, W, B
	BNZ	_00534_DS_
;	.line	1218; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1219; main.c	MIOS_LCD_PrintCString(" ** Last Used **");
	MOVLW	UPPER(__str_43)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_43)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_43)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_ForceStartupPreset
;	.line	1220; main.c	ForceStartupPreset = 0;
	CLRF	_ForceStartupPreset, B
	BRA	_00563_DS_
_00534_DS_:
;	.line	1224; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_ThisStartupPreset
;	.line	1225; main.c	MIOS_LCD_PrintBCD2(ThisStartupPreset);
	MOVF	_ThisStartupPreset, W, B
	CALL	_MIOS_LCD_PrintBCD2
;	.line	1226; main.c	ForceStartupPreset = 1;
	MOVLW	0x01
	BANKSEL	_ForceStartupPreset
	MOVWF	_ForceStartupPreset, B
;	.line	1228; main.c	break;
	BRA	_00563_DS_
_00536_DS_:
	BANKSEL	_SendMidiOnButtonChange
;	.line	1230; main.c	SendMidiOnButtonChange = !SendMidiOnButtonChange;
	MOVF	_SendMidiOnButtonChange, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
; removed redundant BANKSEL
	CLRF	_SendMidiOnButtonChange, B
	RLCF	_SendMidiOnButtonChange, F, B
;	.line	1231; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1232; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1233; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_SendMidiOnButtonChange
;	.line	1234; main.c	SendMidiOnButtonChange ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
	MOVF	_SendMidiOnButtonChange, W, B
	BZ	_00574_DS_
	MOVLW	UPPER(__str_45)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_45)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_45)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00563_DS_
_00574_DS_:
	MOVLW	UPPER(__str_46)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_46)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_46)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1235; main.c	break;
	BRA	_00563_DS_
_00537_DS_:
	BANKSEL	_ReloadActivePreset
;	.line	1237; main.c	ReloadActivePreset = !ReloadActivePreset;
	MOVF	_ReloadActivePreset, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
; removed redundant BANKSEL
	CLRF	_ReloadActivePreset, B
	RLCF	_ReloadActivePreset, F, B
;	.line	1238; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1239; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1240; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_ReloadActivePreset
;	.line	1241; main.c	ReloadActivePreset ? MIOS_LCD_PrintCString("Yes") : MIOS_LCD_PrintCString("No");
	MOVF	_ReloadActivePreset, W, B
	BZ	_00576_DS_
	MOVLW	UPPER(__str_45)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_45)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_45)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00563_DS_
_00576_DS_:
	MOVLW	UPPER(__str_46)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_46)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_46)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1242; main.c	break;
	BRA	_00563_DS_
_00542_DS_:
_00543_DS_:
_00544_DS_:
_00545_DS_:
;	.line	1251; main.c	RelayType[MenuPos-14]=!RelayType[MenuPos-14];
	MOVLW	0xf2
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	LOW(_RelayType)
	ADDWF	r0x00, F
	MOVLW	HIGH(_RelayType)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x02
	RLCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
;	.line	1252; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1253; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1254; main.c	MIOS_LCD_CursorSet(0x40 + 3);
	MOVLW	0x43
	CALL	_MIOS_LCD_CursorSet
;	.line	1255; main.c	RelayType[MenuPos-14] ? MIOS_LCD_PrintCString("Momentary") : MIOS_LCD_PrintCString("Toggle");
	MOVLW	0xf2
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	LOW(_RelayType)
	ADDWF	r0x00, F
	MOVLW	HIGH(_RelayType)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BZ	_00578_DS_
	MOVLW	UPPER(__str_49)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_49)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_49)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00563_DS_
_00578_DS_:
	MOVLW	UPPER(__str_50)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_50)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_50)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1256; main.c	break;
	BRA	_00563_DS_
_00550_DS_:
_00551_DS_:
_00552_DS_:
_00553_DS_:
;	.line	1265; main.c	RelayMode[MenuPos-22]=!RelayMode[MenuPos-22];
	MOVLW	0xea
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x00, F
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x02
	RLCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
;	.line	1266; main.c	MIOS_LCD_CursorSet(0x40 + 1);
	MOVLW	0x41
	CALL	_MIOS_LCD_CursorSet
;	.line	1267; main.c	MIOS_LCD_PrintCString("                ");
	MOVLW	UPPER(__str_41)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_41)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_41)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	1268; main.c	MIOS_LCD_CursorSet(0x40 + 3);
	MOVLW	0x43
	CALL	_MIOS_LCD_CursorSet
;	.line	1269; main.c	RelayMode[MenuPos-22] ? MIOS_LCD_PrintCString("Radio") : MIOS_LCD_PrintCString("Free");
	MOVLW	0xea
	BANKSEL	_MenuPos
	ADDWF	_MenuPos, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x00, F
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BZ	_00580_DS_
	MOVLW	UPPER(__str_52)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_52)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_52)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00563_DS_
_00580_DS_:
	MOVLW	UPPER(__str_53)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_53)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_53)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
_00563_DS_:
	BANKSEL	_LastButton
;	.line	1278; main.c	LastButton = 0;
	CLRF	_LastButton, B
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__Init	code
_Init:
;	.line	855; main.c	void Init(void) __wparam
	MOVFF	r0x00, POSTDEC1
;	.line	858; main.c	MIOS_SRIO_UpdateFrqSet(1); // ms
	MOVLW	0x01
	CALL	_MIOS_SRIO_UpdateFrqSet
;	.line	860; main.c	MIOS_SRIO_NumberSet(NUMBER_OF_SRIO);
	MOVLW	0x10
	CALL	_MIOS_SRIO_NumberSet
;	.line	862; main.c	MIOS_SRIO_DebounceSet(DIN_DEBOUNCE_VALUE);
	MOVLW	0x0a
	CALL	_MIOS_SRIO_DebounceSet
	BANKSEL	_LastButton
;	.line	865; main.c	LastButton = 0;
	CLRF	_LastButton, B
	BANKSEL	_MenuPos
;	.line	866; main.c	MenuPos = 0;
	CLRF	_MenuPos, B
	BANKSEL	_MidiIn
;	.line	867; main.c	MidiIn = 0;
	CLRF	_MidiIn, B
;	.line	870; main.c	LoadGlobalOptions();
	CALL	_LoadGlobalOptions
;	.line	874; main.c	RelayState[5]=1;
	MOVLW	0x01
	BANKSEL	(_RelayState + 5)
	MOVWF	(_RelayState + 5), B
;	.line	876; main.c	MIOS_DOUT_PinSet(RelayLedPin[5], 1);
	MOVLW	LOW(_RelayLedPin + 5)
	MOVWF	TBLPTRL
	MOVLW	HIGH(_RelayLedPin + 5)
	MOVWF	TBLPTRH
	MOVLW	UPPER(_RelayLedPin + 5)
	MOVWF	TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	879; main.c	StartupPreset();
	CALL	_StartupPreset
;	.line	883; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	884; main.c	DEBUG_MSG_SendCString("Application ready.");
	MOVLW	UPPER(__str_27)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_27)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_27)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	885; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__StartupPreset	code
_StartupPreset:
;	.line	830; main.c	void StartupPreset ()
	MOVFF	r0x00, POSTDEC1
	BANKSEL	_CurrentPreset
;	.line	832; main.c	CurrentPreset = 0;  // force preset 0 to allow loading at startup even
	CLRF	_CurrentPreset, B
	BANKSEL	_ForceStartupPreset
;	.line	834; main.c	if ( ForceStartupPreset )
	MOVF	_ForceStartupPreset, W, B
	BZ	_00422_DS_
;	.line	836; main.c	ThisStartupPreset = MIOS_EEPROM_Read(0x08);
	MOVLW	0x08
	CALL	_MIOS_EEPROM_Read
	BANKSEL	_ThisStartupPreset
	MOVWF	_ThisStartupPreset, B
;	.line	837; main.c	LoadPreset(ThisStartupPreset);
	MOVF	_ThisStartupPreset, W, B
	MOVWF	POSTDEC1
	CALL	_LoadPreset
	INCF	FSR1L, F
;	.line	838; main.c	return;
	BRA	_00423_DS_
_00422_DS_:
;	.line	843; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	844; main.c	DEBUG_MSG_SendCString("STARTUP PRESET");
	MOVLW	UPPER(__str_26)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_26)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_26)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_CurrentPreset
;	.line	845; main.c	DEBUG_MSG_SendBCD3(CurrentPreset);
	MOVF	_CurrentPreset, W, B
	CALL	_DEBUG_MSG_SendBCD3
;	.line	846; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	848; main.c	LoadPreset(MIOS_EEPROM_Read(0x01));
	MOVLW	0x01
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LoadPreset
	INCF	FSR1L, F
_00423_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__FactoryReset	code
_FactoryReset:
;	.line	760; main.c	unsigned char FactoryReset ()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	764; main.c	unsigned char error = 0;
	CLRF	r0x00
;	.line	767; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	768; main.c	DEBUG_MSG_SendCString("Factory Reset");
	MOVLW	UPPER(__str_25)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_25)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_25)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	769; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	778; main.c	MIOS_EEPROM_Write(0x00,eeprom_byte);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	781; main.c	SetActivePreset(0);								
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_SetActivePreset
	INCF	FSR1L, F
;	.line	785; main.c	MIOS_EEPROM_Write(0x02,eeprom_byte);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	789; main.c	MIOS_EEPROM_Write(0x03,eeprom_byte);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	792; main.c	MIOS_EEPROM_Write(0x04,1);	
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x04
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	794; main.c	MIOS_EEPROM_Write(0x05,2);	
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	0x05
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	796; main.c	MIOS_EEPROM_Write(0x06,3);	
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0x06
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	798; main.c	MIOS_EEPROM_Write(0x07,4);	
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVLW	0x07
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	801; main.c	MIOS_EEPROM_Write(0x07,0);	
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x07
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	810; main.c	for ( i = 0x08; i<0x10; i++)
	MOVLW	0x08
	MOVWF	r0x01
	CLRF	r0x02
_00398_DS_:
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00415_DS_
	MOVLW	0x10
	SUBWF	r0x01, W
_00415_DS_:
	BC	_00401_DS_
;	.line	812; main.c	MIOS_EEPROM_Write(i,0x00);
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	810; main.c	for ( i = 0x08; i<0x10; i++)
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00398_DS_
_00401_DS_:
;	.line	817; main.c	for ( i = 0; i<100; i++)
	CLRF	r0x01
	CLRF	r0x02
_00402_DS_:
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00416_DS_
	MOVLW	0x64
	SUBWF	r0x01, W
_00416_DS_:
	BC	_00405_DS_
;	.line	819; main.c	error |= MIOS_EEPROM_Write(i+16,0x00);	//all off
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVLW	0x10
	ADDWF	r0x03, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	CALL	_MIOS_EEPROM_Write
	MOVWF	r0x03
	INCF	FSR1L, F
	MOVF	r0x03, W
	IORWF	r0x00, F
;	.line	817; main.c	for ( i = 0; i<100; i++)
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00402_DS_
_00405_DS_:
;	.line	821; main.c	if( error ) {
	MOVF	r0x00, W
	BZ	_00397_DS_
;	.line	822; main.c	return 0;
	CLRF	WREG
	BRA	_00406_DS_
_00397_DS_:
;	.line	824; main.c	return 1;
	MOVLW	0x01
_00406_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__Preset_Down	code
_Preset_Down:
;	.line	739; main.c	unsigned char Preset_Down()
	MOVFF	r0x00, POSTDEC1
	BANKSEL	_CurrentPreset
;	.line	741; main.c	if ( CurrentPreset > 0 )
	MOVF	_CurrentPreset, W, B
	BZ	_00389_DS_
; removed redundant BANKSEL
;	.line	743; main.c	LoadPreset(CurrentPreset-1);
	DECF	_CurrentPreset, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LoadPreset
	INCF	FSR1L, F
	BRA	_00390_DS_
_00389_DS_:
;	.line	748; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	749; main.c	DEBUG_MSG_SendCString("Ignored, already at lowest preset");
	MOVLW	UPPER(__str_24)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_24)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_24)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	750; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	753; main.c	return 0;
	CLRF	WREG
	BRA	_00391_DS_
_00390_DS_:
;	.line	755; main.c	return 1;
	MOVLW	0x01
_00391_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__Preset_Up	code
_Preset_Up:
;	.line	718; main.c	unsigned char Preset_Up()
	MOVFF	r0x00, POSTDEC1
;	.line	720; main.c	if ( CurrentPreset < 100 )
	MOVLW	0x64
	BANKSEL	_CurrentPreset
	SUBWF	_CurrentPreset, W, B
	BC	_00381_DS_
; removed redundant BANKSEL
;	.line	722; main.c	LoadPreset(CurrentPreset+1);
	INCF	_CurrentPreset, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LoadPreset
	INCF	FSR1L, F
	BRA	_00382_DS_
_00381_DS_:
;	.line	727; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	728; main.c	DEBUG_MSG_SendCString("Ignored, already at highest preset");
	MOVLW	UPPER(__str_23)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_23)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_23)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	729; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	732; main.c	return 0;
	CLRF	WREG
	BRA	_00383_DS_
_00382_DS_:
;	.line	734; main.c	return 1;
	MOVLW	0x01
_00383_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__SavePreset	code
_SavePreset:
;	.line	657; main.c	void SavePreset ( unsigned char preset_nb )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	661; main.c	if ( preset_nb == 0 )
	MOVF	r0x00, W
	BNZ	_00372_DS_
;	.line	665; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	666; main.c	MIOS_LCD_CursorSet(0x00);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	667; main.c	MIOS_LCD_PrintCString("Cannot Save to");
	MOVLW	UPPER(__str_19)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_19)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_19)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	668; main.c	MIOS_LCD_CursorSet(0x40);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	669; main.c	MIOS_LCD_PrintCString("Preset 0");
	MOVLW	UPPER(__str_20)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_20)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_20)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	670; main.c	MIOS_LCD_MessageStart(255);
	MOVLW	0xff
	CALL	_MIOS_LCD_MessageStart
;	.line	671; main.c	return;
	BRA	_00375_DS_
_00372_DS_:
;	.line	674; main.c	if ( preset_nb > 0x69 )
	MOVLW	0x6a
	SUBWF	r0x00, W
	BNC	_00374_DS_
;	.line	677; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	678; main.c	DEBUG_MSG_SendCString("Discarded saving preset ");
	MOVLW	UPPER(__str_21)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_21)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_21)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	679; main.c	DEBUG_MSG_SendBCD3(preset_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	680; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	682; main.c	return; 
	BRA	_00375_DS_
_00374_DS_:
	BANKSEL	_CurrentPreset
;	.line	686; main.c	MIOS_EEPROM_Write(0x01,CurrentPreset);
	MOVF	_CurrentPreset, W, B
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	692; main.c	eeprom_byte = RelayState[0];
	MOVFF	_RelayState, r0x01
	BANKSEL	(_RelayState + 1)
;	.line	693; main.c	eeprom_byte = eeprom_byte | RelayState[1]<<1;
	RLNCF	(_RelayState + 1), W, B
	ANDLW	0xfe
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
; removed redundant BANKSEL
;	.line	694; main.c	eeprom_byte = eeprom_byte | RelayState[2]<<2;
	RLNCF	(_RelayState + 2), W, B
	RLNCF	WREG, W
	ANDLW	0xfc
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
; removed redundant BANKSEL
;	.line	695; main.c	eeprom_byte = eeprom_byte | RelayState[3]<<3;
	SWAPF	(_RelayState + 3), W, B
	RRNCF	WREG, W
	ANDLW	0xf8
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
; removed redundant BANKSEL
;	.line	696; main.c	eeprom_byte = eeprom_byte | RelayState[4]<<4;
	SWAPF	(_RelayState + 4), W, B
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
; removed redundant BANKSEL
;	.line	697; main.c	eeprom_byte = eeprom_byte | RelayState[5]<<5;
	SWAPF	(_RelayState + 5), W, B
	RLNCF	WREG, W
	ANDLW	0xe0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
; removed redundant BANKSEL
;	.line	698; main.c	eeprom_byte = eeprom_byte | RelayState[6]<<6;
	RRNCF	(_RelayState + 6), W, B
	RRNCF	WREG, W
	ANDLW	0xc0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
; removed redundant BANKSEL
;	.line	699; main.c	eeprom_byte = eeprom_byte | RelayState[7]<<7;
	RRNCF	(_RelayState + 7), W, B
	ANDLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
;	.line	700; main.c	MIOS_EEPROM_Write(preset_nb+0x10,eeprom_byte);	
	MOVLW	0x10
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	703; main.c	CurrentPreset = preset_nb;
	MOVFF	r0x00, _CurrentPreset
;	.line	706; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	707; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	708; main.c	MIOS_LCD_PrintCString("**  SAVED to  **");
	MOVLW	UPPER(__str_22)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_22)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_22)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	709; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	710; main.c	MIOS_LCD_PrintCString("** Preset     **");
	MOVLW	UPPER(__str_7)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_7)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_7)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	711; main.c	MIOS_LCD_CursorSet(0x40 + 10);
	MOVLW	0x4a
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_CurrentPreset
;	.line	712; main.c	MIOS_LCD_PrintBCD3(CurrentPreset);
	MOVF	_CurrentPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	713; main.c	MIOS_LCD_MessageStart(100);
	MOVLW	0x64
	CALL	_MIOS_LCD_MessageStart
_00375_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__LoadPreset	code
_LoadPreset:
;	.line	502; main.c	void LoadPreset ( unsigned char preset_nb )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	505; main.c	unsigned int ActiveRadioFound = 0;
	CLRF	r0x01
	CLRF	r0x02
	BANKSEL	_CurrentPreset
;	.line	510; main.c	if ( CurrentPreset == preset_nb )
	MOVF	_CurrentPreset, W, B
	XORWF	r0x00, W
	BNZ	_00285_DS_
_00342_DS_:
	BANKSEL	_ReloadActivePreset
;	.line	512; main.c	if(ReloadActivePreset)
	MOVF	_ReloadActivePreset, W, B
	BZ	_00282_DS_
;	.line	515; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	516; main.c	DEBUG_MSG_SendCString("ReLoading active preset");
	MOVLW	UPPER(__str_11)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_11)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_11)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	517; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
	BRA	_00286_DS_
_00282_DS_:
;	.line	524; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	525; main.c	DEBUG_MSG_SendCString("NOT ReLoading active preset");
	MOVLW	UPPER(__str_12)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_12)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_12)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	526; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	529; main.c	return;
	BRA	_00318_DS_
_00285_DS_:
;	.line	535; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	536; main.c	DEBUG_MSG_SendCString("Loading preset ");
	MOVLW	UPPER(__str_13)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_13)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_13)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	537; main.c	DEBUG_MSG_SendBCD3(preset_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	538; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
_00286_DS_:
;	.line	546; main.c	if ( preset_nb > 0x69 )
	MOVLW	0x6a
	SUBWF	r0x00, W
	BNC	_00288_DS_
;	.line	549; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	550; main.c	DEBUG_MSG_SendCString("Discarded loading preset ");
	MOVLW	UPPER(__str_14)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_14)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_14)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	551; main.c	DEBUG_MSG_SendBCD3(preset_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	552; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	554; main.c	return; 
	BRA	_00318_DS_
_00288_DS_:
;	.line	557; main.c	eeprom_byte = MIOS_EEPROM_Read(preset_nb+0x10);
	MOVLW	0x10
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVF	r0x03, W
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x03
;	.line	558; main.c	TargetRelayState[0] = eeprom_byte & 0x01;
	MOVLW	0x01
	ANDWF	r0x03, W
	MOVWF	r0x04
	MOVF	r0x04, W
	BANKSEL	_LoadPreset_TargetRelayState_1_1
	MOVWF	_LoadPreset_TargetRelayState_1_1, B
;	.line	559; main.c	TargetRelayState[1] = (eeprom_byte & 0x02)>>1;
	MOVLW	0x02
	ANDWF	r0x03, W
	MOVWF	r0x04
	RRNCF	r0x04, W
	ANDLW	0x7f
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 1), B
;	.line	560; main.c	TargetRelayState[2] = (eeprom_byte & 0x04)>>2;
	MOVLW	0x04
	ANDWF	r0x03, W
	MOVWF	r0x04
	RRNCF	r0x04, W
	RRNCF	WREG, W
	ANDLW	0x3f
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 2), B
;	.line	561; main.c	TargetRelayState[3] = (eeprom_byte & 0x08)>>3;
	MOVLW	0x08
	ANDWF	r0x03, W
	MOVWF	r0x04
	SWAPF	r0x04, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 3), B
;	.line	562; main.c	TargetRelayState[4] = (eeprom_byte & 0x10)>>4;
	MOVLW	0x10
	ANDWF	r0x03, W
	MOVWF	r0x04
	SWAPF	r0x04, W
	ANDLW	0x0f
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 4), B
;	.line	563; main.c	TargetRelayState[5] = (eeprom_byte & 0x20)>>5;
	MOVLW	0x20
	ANDWF	r0x03, W
	MOVWF	r0x04
	SWAPF	r0x04, W
	RRNCF	WREG, W
	ANDLW	0x07
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 5), B
;	.line	564; main.c	TargetRelayState[6] = (eeprom_byte & 0x40)>>6;
	MOVLW	0x40
	ANDWF	r0x03, W
	MOVWF	r0x04
	RLNCF	r0x04, W
	RLNCF	WREG, W
	ANDLW	0x03
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 6), B
;	.line	565; main.c	TargetRelayState[7] = (eeprom_byte & 0x80)>>7;
	MOVLW	0x80
	ANDWF	r0x03, W
	MOVWF	r0x04
	RLNCF	r0x04, W
	ANDLW	0x01
	MOVWF	r0x04
	MOVF	r0x04, W
; removed redundant BANKSEL
	MOVWF	(_LoadPreset_TargetRelayState_1_1 + 7), B
;	.line	568; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	569; main.c	DEBUG_MSG_SendCString("Relays state byte : ");
	MOVLW	UPPER(__str_15)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_15)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_15)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	570; main.c	DEBUG_MSG_SendBCD3(eeprom_byte);
	MOVF	r0x03, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	571; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	576; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	577; main.c	DEBUG_MSG_SendCString("Send midi ?");
	MOVLW	UPPER(__str_16)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_16)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_16)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_SendMidiOnButtonChange
;	.line	578; main.c	DEBUG_MSG_SendBCD1(SendMidiOnButtonChange);
	MOVF	_SendMidiOnButtonChange, W, B
	CALL	_DEBUG_MSG_SendBCD1
;	.line	579; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
	BANKSEL	_SendMidiOnButtonChange
;	.line	581; main.c	if (SendMidiOnButtonChange)
	MOVF	_SendMidiOnButtonChange, W, B
	BZ	_00329_DS_
;	.line	583; main.c	MIOS_MIDI_BeginStream();
	CALL	_MIOS_MIDI_BeginStream
;	.line	585; main.c	MIOS_MIDI_TxBufferPut((0xC0)+MidiChannel-1);
	MOVLW	0xbf
	BANKSEL	_MidiChannel
	ADDWF	_MidiChannel, W, B
	MOVWF	r0x03
	MOVF	r0x03, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	586; main.c	MIOS_MIDI_TxBufferPut(preset_nb-1); //PC
	DECF	r0x00, W
	MOVWF	r0x03
	MOVF	r0x03, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	587; main.c	MIOS_MIDI_EndStream();
	CALL	_MIOS_MIDI_EndStream
;	.line	589; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	590; main.c	DEBUG_MSG_SendCString(" midi message :");
	MOVLW	UPPER(__str_17)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_17)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_17)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	591; main.c	DEBUG_MSG_SendBCD3((0xC0)+MidiChannel-1);
	MOVLW	0xbf
	BANKSEL	_MidiChannel
	ADDWF	_MidiChannel, W, B
	MOVWF	r0x04
	MOVF	r0x04, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	592; main.c	DEBUG_MSG_SendBCD3(preset_nb-1);
	MOVF	r0x03, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	593; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
_00329_DS_:
;	.line	598; main.c	for ( i=0; i<MAX_RELAYS_NB; i++)
	CLRF	r0x03
	CLRF	r0x04
_00306_DS_:
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00352_DS_
	MOVLW	0x08
	SUBWF	r0x03, W
_00352_DS_:
	BTFSC	STATUS, 0
	BRA	_00309_DS_
;	.line	601; main.c	if ( RelayMode[i] == Free )
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	BTFSS	STATUS, 2
	BRA	_00292_DS_
;	.line	603; main.c	MIOS_DOUT_PinSet(RelayPin[i],TargetRelayState[i]);		
	MOVLW	LOW(_RelayPin)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayPin)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	UPPER(_RelayPin)
	ADDWFC	r0x07, F
	MOVFF	r0x05, TBLPTRL
	MOVFF	r0x06, TBLPTRH
	MOVFF	r0x07, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
	MOVLW	LOW(_LoadPreset_TargetRelayState_1_1)
	ADDWF	r0x03, W
	MOVWF	r0x06
	MOVLW	HIGH(_LoadPreset_TargetRelayState_1_1)
	ADDWFC	r0x04, W
	MOVWF	r0x07
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	604; main.c	MIOS_DOUT_PinSet(RelayLedPin[i],TargetRelayState[i]);
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x04, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x09, F
	MOVFF	r0x05, TBLPTRL
	MOVFF	r0x08, TBLPTRH
	MOVFF	r0x09, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	606; main.c	RelayState[i] = TargetRelayState[i];	
	MOVLW	LOW(_RelayState)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x04, W
	MOVWF	r0x08
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x06, INDF0
_00292_DS_:
;	.line	609; main.c	if (( RelayMode[i] == Radio ) && (TargetRelayState[i] == Active))
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	XORLW	0x01
	BZ	_00354_DS_
	BRA	_00308_DS_
_00354_DS_:
	MOVLW	LOW(_LoadPreset_TargetRelayState_1_1)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_LoadPreset_TargetRelayState_1_1)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	XORLW	0x01
	BZ	_00356_DS_
	BRA	_00308_DS_
_00356_DS_:
;	.line	611; main.c	ActiveRadioFound = 1;
	MOVLW	0x01
	MOVWF	r0x01
	CLRF	r0x02
;	.line	612; main.c	if (RelayState[i] == Active)
	MOVLW	LOW(_RelayState)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	XORLW	0x01
	BNZ	_00294_DS_
;	.line	615; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	616; main.c	DEBUG_MSG_SendCString("Don't push an already active radio relay");
	MOVLW	UPPER(__str_18)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_18)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_18)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	617; main.c	DEBUG_MSG_SendBCD3(i);
	MOVF	r0x03, W
	MOVWF	r0x05
	MOVF	r0x05, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	618; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	621; main.c	MIOS_DOUT_PinSet(RelayLedPin[i],Active);
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x07, F
	MOVFF	r0x05, TBLPTRL
	MOVFF	r0x06, TBLPTRH
	MOVFF	r0x07, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
	BRA	_00308_DS_
_00294_DS_:
;	.line	625; main.c	DoRelay(i);
	MOVF	r0x03, W
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_DoRelay
	INCF	FSR1L, F
_00308_DS_:
;	.line	598; main.c	for ( i=0; i<MAX_RELAYS_NB; i++)
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BRA	_00306_DS_
_00309_DS_:
;	.line	630; main.c	if ( ActiveRadioFound == 0 ) // No radio relay should be active
	MOVF	r0x01, W
	IORWF	r0x02, W
	BNZ	_00303_DS_
;	.line	632; main.c	for ( i=0; i<MAX_RELAYS_NB; i++) // verify if one is active, then desactivate
	CLRF	r0x01
	CLRF	r0x02
_00310_DS_:
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00359_DS_
	MOVLW	0x08
	SUBWF	r0x01, W
_00359_DS_:
	BC	_00303_DS_
;	.line	634; main.c	if (( RelayMode[i] == Radio ) && (RelayState[i] == Active))
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	XORLW	0x01
	BNZ	_00312_DS_
	MOVLW	LOW(_RelayState)
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	XORLW	0x01
	BNZ	_00312_DS_
;	.line	636; main.c	DoRelay(i);
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_DoRelay
	INCF	FSR1L, F
_00312_DS_:
;	.line	632; main.c	for ( i=0; i<MAX_RELAYS_NB; i++) // verify if one is active, then desactivate
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00310_DS_
_00303_DS_:
;	.line	642; main.c	FootLedsOff();
	CALL	_FootLedsOff
;	.line	643; main.c	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	CLRF	r0x01
	CLRF	r0x02
_00314_DS_:
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00364_DS_
	MOVLW	0x04
	SUBWF	r0x01, W
_00364_DS_:
	BC	_00317_DS_
;	.line	645; main.c	if ( FootPreset[i] == preset_nb )
	MOVLW	LOW(_FootPreset)
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	HIGH(_FootPreset)
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	XORWF	r0x00, W
	BNZ	_00316_DS_
;	.line	647; main.c	SetFootLed(i);
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_SetFootLed
	INCF	FSR1L, F
_00316_DS_:
;	.line	643; main.c	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00314_DS_
_00317_DS_:
;	.line	651; main.c	SetActivePreset(preset_nb);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SetActivePreset
	INCF	FSR1L, F
_00318_DS_:
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SetFootLed	code
_SetFootLed:
;	.line	485; main.c	void SetFootLed ( unsigned char led_nb )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	489; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	490; main.c	DEBUG_MSG_SendCString("Footswitch Led: ");
	MOVLW	UPPER(__str_9)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_9)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_9)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	491; main.c	DEBUG_MSG_SendBCD3(FootLedPin[led_nb]);
	MOVLW	LOW(_FootLedPin)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_FootLedPin)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_FootLedPin)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	492; main.c	DEBUG_MSG_SendChar(' ');
	MOVLW	0x20
	CALL	_DEBUG_MSG_SendChar
;	.line	493; main.c	DEBUG_MSG_SendCString(" On");
	MOVLW	UPPER(__str_10)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_10)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_10)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	494; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	497; main.c	MIOS_DOUT_PinSet1(FootLedPin[led_nb]);
	CLRF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_FootLedPin)
	ADDWF	r0x00, F
	MOVLW	HIGH(_FootLedPin)
	ADDWFC	r0x01, F
	MOVLW	UPPER(_FootLedPin)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	MOVF	r0x00, W
	CALL	_MIOS_DOUT_PinSet1
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__FootLedsOff	code
_FootLedsOff:
;	.line	467; main.c	void FootLedsOff ()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
;	.line	472; main.c	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	CLRF	r0x00
	CLRF	r0x01
_00263_DS_:
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00272_DS_
	MOVLW	0x04
	SUBWF	r0x00, W
_00272_DS_:
	BC	_00266_DS_
;	.line	474; main.c	MIOS_DOUT_PinSet(FootLedPin[i], 0);
	MOVLW	LOW(_FootLedPin)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_FootLedPin)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	UPPER(_FootLedPin)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	472; main.c	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00263_DS_
_00266_DS_:
;	.line	477; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	478; main.c	DEBUG_MSG_SendCString("Footswitch Leds Off");
	MOVLW	UPPER(__str_8)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_8)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_8)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	479; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__SetActivePreset	code
_SetActivePreset:
;	.line	437; main.c	void SetActivePreset ( unsigned char preset_nb )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	440; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	441; main.c	DEBUG_MSG_SendCString("Set Active preset");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	442; main.c	DEBUG_MSG_SendBCD3(preset_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	443; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	447; main.c	CurrentPreset = preset_nb;
	MOVFF	r0x00, _CurrentPreset
	BANKSEL	_CurrentPreset
;	.line	450; main.c	MIOS_EEPROM_Write(0x01,CurrentPreset);
	MOVF	_CurrentPreset, W, B
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	454; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	455; main.c	MIOS_LCD_CursorSet(0x00 + 0);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	456; main.c	MIOS_LCD_PrintCString("** Change to  **");
	MOVLW	UPPER(__str_6)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_6)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_6)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	457; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	458; main.c	MIOS_LCD_PrintCString("** Preset     **");
	MOVLW	UPPER(__str_7)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_7)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_7)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	459; main.c	MIOS_LCD_CursorSet(0x40 + 10);
	MOVLW	0x4a
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_CurrentPreset
;	.line	460; main.c	MIOS_LCD_PrintBCD3(CurrentPreset);
	MOVF	_CurrentPreset, W, B
	CALL	_MIOS_LCD_PrintBCD3
;	.line	461; main.c	MIOS_LCD_MessageStart(100);
	MOVLW	0x64
	CALL	_MIOS_LCD_MessageStart
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SaveGlobalOptions	code
_SaveGlobalOptions:
;	.line	367; main.c	void SaveGlobalOptions ()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	377; main.c	eeprom_byte = MidiChannel & 0x0F;
	MOVLW	0x0f
	BANKSEL	_MidiChannel
	ANDWF	_MidiChannel, W, B
	MOVWF	r0x00
	BANKSEL	_SendMidiOnButtonChange
;	.line	378; main.c	eeprom_byte = eeprom_byte | SendMidiOnButtonChange<<4;
	SWAPF	_SendMidiOnButtonChange, W, B
	ANDLW	0xf0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
	BANKSEL	_ReloadActivePreset
;	.line	379; main.c	eeprom_byte = eeprom_byte | ReloadActivePreset<<5;
	SWAPF	_ReloadActivePreset, W, B
	RLNCF	WREG, W
	ANDLW	0xe0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
	BANKSEL	_ForceStartupPreset
;	.line	380; main.c	eeprom_byte = eeprom_byte | ForceStartupPreset<<6;
	RRNCF	_ForceStartupPreset, W, B
	RRNCF	WREG, W
	ANDLW	0xc0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
;	.line	381; main.c	MIOS_EEPROM_Write(0x00,eeprom_byte);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
	BANKSEL	_CurrentPreset
;	.line	385; main.c	MIOS_EEPROM_Write(0x01,CurrentPreset);
	MOVF	_CurrentPreset, W, B
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	388; main.c	eeprom_byte = RelayType[0];
	MOVFF	_RelayType, r0x00
	BANKSEL	(_RelayType + 1)
;	.line	389; main.c	eeprom_byte = eeprom_byte | RelayType[1]<<1;
	RLNCF	(_RelayType + 1), W, B
	ANDLW	0xfe
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	390; main.c	eeprom_byte = eeprom_byte | RelayType[2]<<2;
	RLNCF	(_RelayType + 2), W, B
	RLNCF	WREG, W
	ANDLW	0xfc
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	391; main.c	eeprom_byte = eeprom_byte | RelayType[3]<<3;
	SWAPF	(_RelayType + 3), W, B
	RRNCF	WREG, W
	ANDLW	0xf8
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	392; main.c	eeprom_byte = eeprom_byte | RelayType[4]<<4;
	SWAPF	(_RelayType + 4), W, B
	ANDLW	0xf0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	393; main.c	eeprom_byte = eeprom_byte | RelayType[5]<<5;
	SWAPF	(_RelayType + 5), W, B
	RLNCF	WREG, W
	ANDLW	0xe0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	394; main.c	eeprom_byte = eeprom_byte | RelayType[6]<<6;
	RRNCF	(_RelayType + 6), W, B
	RRNCF	WREG, W
	ANDLW	0xc0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	395; main.c	eeprom_byte = eeprom_byte | RelayType[7]<<7;
	RRNCF	(_RelayType + 7), W, B
	ANDLW	0x80
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
;	.line	396; main.c	MIOS_EEPROM_Write(0x02,eeprom_byte);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	399; main.c	eeprom_byte = RelayMode[0];
	MOVFF	_RelayMode, r0x00
	BANKSEL	(_RelayMode + 1)
;	.line	400; main.c	eeprom_byte = eeprom_byte | RelayMode[1]<<1;
	RLNCF	(_RelayMode + 1), W, B
	ANDLW	0xfe
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	401; main.c	eeprom_byte = eeprom_byte | RelayMode[2]<<2;
	RLNCF	(_RelayMode + 2), W, B
	RLNCF	WREG, W
	ANDLW	0xfc
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	402; main.c	eeprom_byte = eeprom_byte | RelayMode[3]<<3;
	SWAPF	(_RelayMode + 3), W, B
	RRNCF	WREG, W
	ANDLW	0xf8
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	403; main.c	eeprom_byte = eeprom_byte | RelayMode[4]<<4;
	SWAPF	(_RelayMode + 4), W, B
	ANDLW	0xf0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	404; main.c	eeprom_byte = eeprom_byte | RelayMode[5]<<5;
	SWAPF	(_RelayMode + 5), W, B
	RLNCF	WREG, W
	ANDLW	0xe0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	405; main.c	eeprom_byte = eeprom_byte | RelayMode[6]<<6;
	RRNCF	(_RelayMode + 6), W, B
	RRNCF	WREG, W
	ANDLW	0xc0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
; removed redundant BANKSEL
;	.line	406; main.c	eeprom_byte = eeprom_byte | RelayMode[7]<<7;
	RRNCF	(_RelayMode + 7), W, B
	ANDLW	0x80
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, F
;	.line	407; main.c	MIOS_EEPROM_Write(0x03,eeprom_byte);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	410; main.c	eeprom_byte = FootPreset[0];
	MOVFF	_FootPreset, r0x00
;	.line	411; main.c	MIOS_EEPROM_Write(0x04,eeprom_byte);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x04
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	413; main.c	eeprom_byte = FootPreset[1];
	MOVFF	(_FootPreset + 1), r0x00
;	.line	414; main.c	MIOS_EEPROM_Write(0x05,eeprom_byte);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x05
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	416; main.c	eeprom_byte = FootPreset[2];
	MOVFF	(_FootPreset + 2), r0x00
;	.line	417; main.c	MIOS_EEPROM_Write(0x06,eeprom_byte);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x06
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
;	.line	419; main.c	eeprom_byte = FootPreset[3];
	MOVFF	(_FootPreset + 3), r0x00
;	.line	420; main.c	MIOS_EEPROM_Write(0x07,eeprom_byte);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x07
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
	BANKSEL	_ThisStartupPreset
;	.line	423; main.c	MIOS_EEPROM_Write(0x08,ThisStartupPreset);	
	MOVF	_ThisStartupPreset, W, B
	MOVWF	POSTDEC1
	MOVLW	0x08
	CALL	_MIOS_EEPROM_Write
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__LoadGlobalOptions	code
_LoadGlobalOptions:
;	.line	302; main.c	void LoadGlobalOptions ()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	312; main.c	eeprom_byte = MIOS_EEPROM_Read(0x00);
	MOVLW	0x00
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
;	.line	313; main.c	MidiChannel = eeprom_byte & 0x0F;
	MOVLW	0x0f
	ANDWF	r0x00, W
	BANKSEL	_MidiChannel
	MOVWF	_MidiChannel, B
;	.line	314; main.c	SendMidiOnButtonChange = (eeprom_byte & 0x10)>>4;
	MOVLW	0x10
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	ANDLW	0x0f
	BANKSEL	_SendMidiOnButtonChange
	MOVWF	_SendMidiOnButtonChange, B
;	.line	315; main.c	ReloadActivePreset = (eeprom_byte & 0x20)>>5;
	MOVLW	0x20
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	RRNCF	WREG, W
	ANDLW	0x07
	BANKSEL	_ReloadActivePreset
	MOVWF	_ReloadActivePreset, B
;	.line	316; main.c	ForceStartupPreset = (eeprom_byte & 0x40)>>6;
	MOVLW	0x40
	ANDWF	r0x00, W
	MOVWF	r0x01
	RLNCF	r0x01, W
	RLNCF	WREG, W
	ANDLW	0x03
	BANKSEL	_ForceStartupPreset
	MOVWF	_ForceStartupPreset, B
;	.line	320; main.c	CurrentPreset = MIOS_EEPROM_Read(0x01);
	MOVLW	0x01
	CALL	_MIOS_EEPROM_Read
	BANKSEL	_CurrentPreset
	MOVWF	_CurrentPreset, B
;	.line	323; main.c	eeprom_byte = MIOS_EEPROM_Read(0x02);	
	MOVLW	0x02
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
;	.line	324; main.c	RelayType[0] = eeprom_byte & 0x01;
	MOVLW	0x01
	ANDWF	r0x00, W
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	_RelayType
	MOVWF	_RelayType, B
;	.line	325; main.c	RelayType[1] = (eeprom_byte & 0x02)>>1;
	MOVLW	0x02
	ANDWF	r0x00, W
	MOVWF	r0x01
	RRNCF	r0x01, W
	ANDLW	0x7f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 1), B
;	.line	326; main.c	RelayType[2] = (eeprom_byte & 0x04)>>2;
	MOVLW	0x04
	ANDWF	r0x00, W
	MOVWF	r0x01
	RRNCF	r0x01, W
	RRNCF	WREG, W
	ANDLW	0x3f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 2), B
;	.line	327; main.c	RelayType[3] = (eeprom_byte & 0x08)>>3;
	MOVLW	0x08
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 3), B
;	.line	328; main.c	RelayType[4] = (eeprom_byte & 0x10)>>4;
	MOVLW	0x10
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 4), B
;	.line	329; main.c	RelayType[5] = (eeprom_byte & 0x20)>>5;
	MOVLW	0x20
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	RRNCF	WREG, W
	ANDLW	0x07
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 5), B
;	.line	330; main.c	RelayType[6] = (eeprom_byte & 0x40)>>6;
	MOVLW	0x40
	ANDWF	r0x00, W
	MOVWF	r0x01
	RLNCF	r0x01, W
	RLNCF	WREG, W
	ANDLW	0x03
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 6), B
;	.line	331; main.c	RelayType[7] = (eeprom_byte & 0x80)>>7;
	MOVLW	0x80
	ANDWF	r0x00, W
	MOVWF	r0x01
	RLNCF	r0x01, W
	ANDLW	0x01
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayType + 7), B
;	.line	334; main.c	eeprom_byte = MIOS_EEPROM_Read(0x03);	
	MOVLW	0x03
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
;	.line	335; main.c	RelayMode[0] = eeprom_byte & 0x01;
	MOVLW	0x01
	ANDWF	r0x00, W
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	_RelayMode
	MOVWF	_RelayMode, B
;	.line	336; main.c	RelayMode[1] = (eeprom_byte & 0x02)>>1;
	MOVLW	0x02
	ANDWF	r0x00, W
	MOVWF	r0x01
	RRNCF	r0x01, W
	ANDLW	0x7f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 1), B
;	.line	337; main.c	RelayMode[2] = (eeprom_byte & 0x04)>>2;
	MOVLW	0x04
	ANDWF	r0x00, W
	MOVWF	r0x01
	RRNCF	r0x01, W
	RRNCF	WREG, W
	ANDLW	0x3f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 2), B
;	.line	338; main.c	RelayMode[3] = (eeprom_byte & 0x08)>>3;
	MOVLW	0x08
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 3), B
;	.line	339; main.c	RelayMode[4] = (eeprom_byte & 0x10)>>4;
	MOVLW	0x10
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 4), B
;	.line	340; main.c	RelayMode[5] = (eeprom_byte & 0x20)>>5;
	MOVLW	0x20
	ANDWF	r0x00, W
	MOVWF	r0x01
	SWAPF	r0x01, W
	RRNCF	WREG, W
	ANDLW	0x07
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 5), B
;	.line	341; main.c	RelayMode[6] = (eeprom_byte & 0x40)>>6;
	MOVLW	0x40
	ANDWF	r0x00, W
	MOVWF	r0x01
	RLNCF	r0x01, W
	RLNCF	WREG, W
	ANDLW	0x03
	MOVWF	r0x01
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 6), B
;	.line	342; main.c	RelayMode[7] = (eeprom_byte & 0x80)>>7;
	MOVLW	0x80
	ANDWF	r0x00, F
	RLNCF	r0x00, W
	ANDLW	0x01
	MOVWF	r0x00
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_RelayMode + 7), B
;	.line	345; main.c	FootPreset[0] = MIOS_EEPROM_Read(0x04);	
	MOVLW	0x04
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	_FootPreset
	MOVWF	_FootPreset, B
;	.line	347; main.c	FootPreset[1] = MIOS_EEPROM_Read(0x05);	
	MOVLW	0x05
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_FootPreset + 1)
	MOVWF	(_FootPreset + 1), B
;	.line	349; main.c	FootPreset[2] = MIOS_EEPROM_Read(0x06);	
	MOVLW	0x06
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_FootPreset + 2)
	MOVWF	(_FootPreset + 2), B
;	.line	351; main.c	FootPreset[3] = MIOS_EEPROM_Read(0x07);	
	MOVLW	0x07
	CALL	_MIOS_EEPROM_Read
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_FootPreset + 3)
	MOVWF	(_FootPreset + 3), B
;	.line	354; main.c	ThisStartupPreset = MIOS_EEPROM_Read(0x08);	
	MOVLW	0x08
	CALL	_MIOS_EEPROM_Read
	BANKSEL	_ThisStartupPreset
	MOVWF	_ThisStartupPreset, B
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__LoadTestPreset	code
_LoadTestPreset:
;	.line	276; main.c	void LoadTestPreset()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	BANKSEL	_MidiChannel
;	.line	282; main.c	MidiChannel = 0;
	CLRF	_MidiChannel, B
;	.line	283; main.c	CurrentPreset = 1;
	MOVLW	0x01
	BANKSEL	_CurrentPreset
	MOVWF	_CurrentPreset, B
	BANKSEL	_SendMidiOnButtonChange
;	.line	284; main.c	SendMidiOnButtonChange = 0;
	CLRF	_SendMidiOnButtonChange, B
;	.line	285; main.c	for ( i=0; i<5; i++)
	CLRF	r0x00
	CLRF	r0x01
_00229_DS_:
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00245_DS_
	MOVLW	0x05
	SUBWF	r0x00, W
_00245_DS_:
	BC	_00232_DS_
;	.line	287; main.c	RelayType[i] = 0; //Toggle=0, Momentary=1
	MOVLW	LOW(_RelayType)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_RelayType)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	288; main.c	RelayMode[i] = 0; //Free=0, radiogroup=1
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	289; main.c	RelayState[i] = 0; //Open/Inactive=0, Closed/Active=1
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	285; main.c	for ( i=0; i<5; i++)
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00229_DS_
_00232_DS_:
;	.line	291; main.c	for ( i=5; i<8; i++)
	MOVLW	0x05
	MOVWF	r0x00
	CLRF	r0x01
_00233_DS_:
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00246_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
_00246_DS_:
	BC	_00237_DS_
;	.line	293; main.c	RelayType[i] = 1; //Toggle=0, Momentary=1
	MOVLW	LOW(_RelayType)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_RelayType)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x01
	MOVWF	INDF0
;	.line	294; main.c	RelayMode[i] = 1; //Free=0, radiogroup=1
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x01
	MOVWF	INDF0
;	.line	295; main.c	RelayState[i] = 0; //Open/Inactive=0, Closed/Active=1
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	291; main.c	for ( i=5; i<8; i++)
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00233_DS_
_00237_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__MenuButton	code
_MenuButton:
;	.line	260; main.c	unsigned char MenuButton ( unsigned char pin_number )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	264; main.c	for ( i=0; i<MAX_MENU_BUTTONS_NB; i++ )
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00213_DS_:
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00222_DS_
	MOVLW	0x04
	SUBWF	r0x03, W
_00222_DS_:
	BC	_00216_DS_
;	.line	266; main.c	if ( MenuButtonPin[i] == pin_number )
	MOVLW	LOW(_MenuButtonPin)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_MenuButtonPin)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	UPPER(_MenuButtonPin)
	ADDWFC	r0x07, F
	MOVFF	r0x05, TBLPTRL
	MOVFF	r0x06, TBLPTRH
	MOVFF	r0x07, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
	MOVF	r0x05, W
	XORWF	r0x00, W
	BNZ	_00215_DS_
;	.line	268; main.c	return i+1;
	MOVF	r0x01, W
	MOVWF	r0x05
	INCF	r0x05, F
	MOVF	r0x05, W
	BRA	_00217_DS_
_00215_DS_:
;	.line	264; main.c	for ( i=0; i<MAX_MENU_BUTTONS_NB; i++ )
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	MOVFF	r0x03, r0x01
	MOVFF	r0x04, r0x02
	BRA	_00213_DS_
_00216_DS_:
;	.line	271; main.c	return 0;
	CLRF	WREG
_00217_DS_:
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__RelayButton	code
_RelayButton:
;	.line	243; main.c	unsigned char RelayButton ( unsigned char pin_number )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	247; main.c	for ( i=0; i<MAX_RELAY_BUTTONS_NB; i++ )
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00195_DS_:
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00204_DS_
	MOVLW	0x08
	SUBWF	r0x03, W
_00204_DS_:
	BC	_00198_DS_
;	.line	249; main.c	if ( ButtonPin[i] == pin_number )
	MOVLW	LOW(_ButtonPin)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_ButtonPin)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	UPPER(_ButtonPin)
	ADDWFC	r0x07, F
	MOVFF	r0x05, TBLPTRL
	MOVFF	r0x06, TBLPTRH
	MOVFF	r0x07, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
	MOVF	r0x05, W
	XORWF	r0x00, W
	BNZ	_00197_DS_
;	.line	251; main.c	return i+1;
	MOVF	r0x01, W
	MOVWF	r0x05
	INCF	r0x05, F
	MOVF	r0x05, W
	BRA	_00199_DS_
_00197_DS_:
;	.line	247; main.c	for ( i=0; i<MAX_RELAY_BUTTONS_NB; i++ )
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	MOVFF	r0x03, r0x01
	MOVFF	r0x04, r0x02
	BRA	_00195_DS_
_00198_DS_:
;	.line	254; main.c	return 0;
	CLRF	WREG
_00199_DS_:
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__FootButton	code
_FootButton:
;	.line	226; main.c	unsigned char FootButton ( unsigned char pin_number )
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	230; main.c	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00177_DS_:
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00186_DS_
	MOVLW	0x04
	SUBWF	r0x03, W
_00186_DS_:
	BC	_00180_DS_
;	.line	232; main.c	if ( FootButtonPin[i] == pin_number )
	MOVLW	LOW(_FootButtonPin)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_FootButtonPin)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	UPPER(_FootButtonPin)
	ADDWFC	r0x07, F
	MOVFF	r0x05, TBLPTRL
	MOVFF	r0x06, TBLPTRH
	MOVFF	r0x07, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
	MOVF	r0x05, W
	XORWF	r0x00, W
	BNZ	_00179_DS_
;	.line	234; main.c	return i+1;
	MOVF	r0x01, W
	MOVWF	r0x05
	INCF	r0x05, F
	MOVF	r0x05, W
	BRA	_00181_DS_
_00179_DS_:
;	.line	230; main.c	for ( i=0; i<MAX_FOOTSWITCHES_NB; i++ )
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	MOVFF	r0x03, r0x01
	MOVFF	r0x04, r0x02
	BRA	_00177_DS_
_00180_DS_:
;	.line	237; main.c	return 0;
	CLRF	WREG
_00181_DS_:
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DoRelay	code
_DoRelay:
;	.line	176; main.c	void DoRelay(unsigned char relay_nb)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	178; main.c	unsigned char Found = 0;
	CLRF	r0x01
;	.line	181; main.c	if ( RelayMode[relay_nb] == Free )
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	BNZ	_00145_DS_
;	.line	184; main.c	toggle_dout(relay_nb);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_toggle_dout
	INCF	FSR1L, F
	BRA	_00151_DS_
_00145_DS_:
;	.line	186; main.c	else if ( RelayMode[relay_nb] == Radio )
	MOVF	r0x02, W
	XORLW	0x01
	BZ	_00163_DS_
	BRA	_00151_DS_
_00163_DS_:
;	.line	188; main.c	if ( RelayState[relay_nb] == Active )
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00159_DS_
;	.line	191; main.c	toggle_dout(relay_nb);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_toggle_dout
	INCF	FSR1L, F
	BRA	_00151_DS_
_00159_DS_:
;	.line	195; main.c	for ( i=0; i<MAX_RELAYS_NB; i++ )
	CLRF	r0x02
	CLRF	r0x03
_00147_DS_:
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00166_DS_
	MOVLW	0x08
	SUBWF	r0x02, W
_00166_DS_:
	BTFSC	STATUS, 0
	BRA	_00150_DS_
;	.line	197; main.c	if ( (RelayMode[i] == Radio) && (RelayState[i] == Active) )
	MOVLW	LOW(_RelayMode)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_RelayMode)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BZ	_00168_DS_
	BRA	_00149_DS_
_00168_DS_:
	MOVLW	LOW(_RelayState)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BZ	_00170_DS_
	BRA	_00149_DS_
_00170_DS_:
;	.line	201; main.c	MIOS_DOUT_PinSet0(RelayLedPin[i]);		
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	CALL	_MIOS_DOUT_PinSet0
;	.line	203; main.c	MIOS_DOUT_PinSet1(RelayPin[relay_nb]);
	MOVLW	LOW(_RelayPin)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_RelayPin)
	ADDWFC	r0x05, F
	CLRF	r0x06
	MOVLW	UPPER(_RelayPin)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	CALL	_MIOS_DOUT_PinSet1
;	.line	204; main.c	MIOS_Delay(200);
	MOVLW	0xc8
	CALL	_MIOS_Delay
;	.line	205; main.c	MIOS_DOUT_PinSet0(RelayPin[relay_nb]);			
	MOVLW	LOW(_RelayPin)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_RelayPin)
	ADDWFC	r0x05, F
	CLRF	r0x06
	MOVLW	UPPER(_RelayPin)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	CALL	_MIOS_DOUT_PinSet0
;	.line	207; main.c	MIOS_DOUT_PinSet1(RelayLedPin[relay_nb]);		
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x05, F
	CLRF	r0x06
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	CALL	_MIOS_DOUT_PinSet1
;	.line	208; main.c	Found = 1;
	MOVLW	0x01
	MOVWF	r0x01
;	.line	210; main.c	RelayState[i] = Inactive;
	MOVLW	LOW(_RelayState)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	211; main.c	RelayState[relay_nb] = Active;
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x01
	MOVWF	INDF0
_00149_DS_:
;	.line	195; main.c	for ( i=0; i<MAX_RELAYS_NB; i++ )
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	BRA	_00147_DS_
_00150_DS_:
;	.line	214; main.c	if ( Found == 0 )
	MOVF	r0x01, W
	BNZ	_00151_DS_
;	.line	217; main.c	toggle_dout(relay_nb);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_toggle_dout
	INCF	FSR1L, F
_00151_DS_:
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__toggle_dout	code
_toggle_dout:
;	.line	115; main.c	void toggle_dout(unsigned char relay_nb)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	117; main.c	if ( RelayType[relay_nb] == Toggle )
	MOVLW	LOW(_RelayType)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayType)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00111_DS_
;	.line	120; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	121; main.c	DEBUG_MSG_SendCString("Relay");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	122; main.c	DEBUG_MSG_SendBCD3(relay_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	123; main.c	DEBUG_MSG_SendCString(" original state");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	124; main.c	DEBUG_MSG_SendBCD3(RelayState[relay_nb]);
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	125; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
;	.line	129; main.c	MIOS_DOUT_PinSet(RelayPin[relay_nb], RelayState[relay_nb] ? 0 : 1);
	MOVLW	LOW(_RelayPin)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_RelayPin)
	ADDWFC	r0x03, F
	CLRF	r0x04
	MOVLW	UPPER(_RelayPin)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	BZ	_00118_DS_
	CLRF	r0x03
	BRA	_00119_DS_
_00118_DS_:
	MOVLW	0x01
	MOVWF	r0x03
_00119_DS_:
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	131; main.c	MIOS_DOUT_PinSet(RelayLedPin[relay_nb], RelayState[relay_nb] ? 0 : 1);
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x03, F
	CLRF	r0x04
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	BZ	_00120_DS_
	CLRF	r0x03
	BRA	_00121_DS_
_00120_DS_:
	MOVLW	0x01
	MOVWF	r0x03
_00121_DS_:
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	134; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	135; main.c	DEBUG_MSG_SendCString("Toggled relay");
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	136; main.c	DEBUG_MSG_SendBCD3(relay_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	137; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
	BRA	_00112_DS_
_00111_DS_:
;	.line	140; main.c	else if ( RelayType[relay_nb] == Momentary )
	MOVF	r0x01, W
	XORLW	0x01
	BZ	_00129_DS_
	BRA	_00112_DS_
_00129_DS_:
;	.line	143; main.c	MIOS_DOUT_PinSet1(RelayPin[relay_nb]);
	MOVLW	LOW(_RelayPin)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayPin)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_RelayPin)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	CALL	_MIOS_DOUT_PinSet1
;	.line	144; main.c	MIOS_Delay(MOMENTARY_PUSH_LENGTH);
	MOVLW	0xc8
	CALL	_MIOS_Delay
;	.line	145; main.c	MIOS_DOUT_PinSet0(RelayPin[relay_nb]);
	MOVLW	LOW(_RelayPin)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayPin)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_RelayPin)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	CALL	_MIOS_DOUT_PinSet0
;	.line	147; main.c	if ( RelayState[relay_nb] == Inactive )
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	BNZ	_00106_DS_
;	.line	148; main.c	MIOS_DOUT_PinSet1(RelayLedPin[relay_nb]);
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	CALL	_MIOS_DOUT_PinSet1
	BRA	_00107_DS_
_00106_DS_:
;	.line	150; main.c	MIOS_DOUT_PinSet0(RelayLedPin[relay_nb]);
	MOVLW	LOW(_RelayLedPin)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayLedPin)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_RelayLedPin)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	CALL	_MIOS_DOUT_PinSet0
_00107_DS_:
;	.line	153; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	154; main.c	DEBUG_MSG_SendCString("Pushed relay");
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	155; main.c	DEBUG_MSG_SendBCD3(relay_nb);
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	156; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
_00112_DS_:
;	.line	161; main.c	if ( RelayState[relay_nb] )
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	BZ	_00114_DS_
;	.line	162; main.c	{ RelayState[relay_nb] = 0;	}
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BRA	_00115_DS_
_00114_DS_:
;	.line	164; main.c	{ RelayState[relay_nb] = 1; }
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x01
	MOVWF	INDF0
_00115_DS_:
;	.line	167; main.c	DEBUG_MSG_SendHeader();
	CALL	_DEBUG_MSG_SendHeader
;	.line	168; main.c	DEBUG_MSG_SendCString(" to state");
	MOVLW	UPPER(__str_4)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_4)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_4)
	CALL	_DEBUG_MSG_SendCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	169; main.c	DEBUG_MSG_SendBCD3(RelayState[relay_nb]);
	CLRF	r0x01
	MOVLW	LOW(_RelayState)
	ADDWF	r0x00, F
	MOVLW	HIGH(_RelayState)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	CALL	_DEBUG_MSG_SendBCD3
;	.line	170; main.c	DEBUG_MSG_SendFooter();
	CALL	_DEBUG_MSG_SendFooter
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block for Ival
	code
_RelayLedPin:
	DB	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
; ; Starting pCode block for Ival
_RelayPin:
	DB	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
; ; Starting pCode block for Ival
_FootLedPin:
	DB	0x17, 0x16, 0x15, 0x14
; ; Starting pCode block for Ival
_ButtonPin:
	DB	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
; ; Starting pCode block for Ival
_MenuButtonPin:
	DB	0x0b, 0x0a, 0x08, 0x09
; ; Starting pCode block for Ival
_FootButtonPin:
	DB	0x0e, 0x0f, 0x0d, 0x0c
; ; Starting pCode block
__str_0:
	DB	0x52, 0x65, 0x6c, 0x61, 0x79, 0x00
; ; Starting pCode block
__str_1:
	DB	0x20, 0x6f, 0x72, 0x69, 0x67, 0x69, 0x6e, 0x61, 0x6c, 0x20, 0x73, 0x74
	DB	0x61, 0x74, 0x65, 0x00
; ; Starting pCode block
__str_2:
	DB	0x54, 0x6f, 0x67, 0x67, 0x6c, 0x65, 0x64, 0x20, 0x72, 0x65, 0x6c, 0x61
	DB	0x79, 0x00
; ; Starting pCode block
__str_3:
	DB	0x50, 0x75, 0x73, 0x68, 0x65, 0x64, 0x20, 0x72, 0x65, 0x6c, 0x61, 0x79
	DB	0x00
; ; Starting pCode block
__str_4:
	DB	0x20, 0x74, 0x6f, 0x20, 0x73, 0x74, 0x61, 0x74, 0x65, 0x00
; ; Starting pCode block
__str_5:
	DB	0x53, 0x65, 0x74, 0x20, 0x41, 0x63, 0x74, 0x69, 0x76, 0x65, 0x20, 0x70
	DB	0x72, 0x65, 0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_6:
	DB	0x2a, 0x2a, 0x20, 0x43, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x74, 0x6f
	DB	0x20, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_7:
	DB	0x2a, 0x2a, 0x20, 0x50, 0x72, 0x65, 0x73, 0x65, 0x74, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_8:
	DB	0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68, 0x20, 0x4c
	DB	0x65, 0x64, 0x73, 0x20, 0x4f, 0x66, 0x66, 0x00
; ; Starting pCode block
__str_9:
	DB	0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68, 0x20, 0x4c
	DB	0x65, 0x64, 0x3a, 0x20, 0x00
; ; Starting pCode block
__str_10:
	DB	0x20, 0x4f, 0x6e, 0x00
; ; Starting pCode block
__str_11:
	DB	0x52, 0x65, 0x4c, 0x6f, 0x61, 0x64, 0x69, 0x6e, 0x67, 0x20, 0x61, 0x63
	DB	0x74, 0x69, 0x76, 0x65, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_12:
	DB	0x4e, 0x4f, 0x54, 0x20, 0x52, 0x65, 0x4c, 0x6f, 0x61, 0x64, 0x69, 0x6e
	DB	0x67, 0x20, 0x61, 0x63, 0x74, 0x69, 0x76, 0x65, 0x20, 0x70, 0x72, 0x65
	DB	0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_13:
	DB	0x4c, 0x6f, 0x61, 0x64, 0x69, 0x6e, 0x67, 0x20, 0x70, 0x72, 0x65, 0x73
	DB	0x65, 0x74, 0x20, 0x00
; ; Starting pCode block
__str_14:
	DB	0x44, 0x69, 0x73, 0x63, 0x61, 0x72, 0x64, 0x65, 0x64, 0x20, 0x6c, 0x6f
	DB	0x61, 0x64, 0x69, 0x6e, 0x67, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74
	DB	0x20, 0x00
; ; Starting pCode block
__str_15:
	DB	0x52, 0x65, 0x6c, 0x61, 0x79, 0x73, 0x20, 0x73, 0x74, 0x61, 0x74, 0x65
	DB	0x20, 0x62, 0x79, 0x74, 0x65, 0x20, 0x3a, 0x20, 0x00
; ; Starting pCode block
__str_16:
	DB	0x53, 0x65, 0x6e, 0x64, 0x20, 0x6d, 0x69, 0x64, 0x69, 0x20, 0x3f, 0x00
; ; Starting pCode block
__str_17:
	DB	0x20, 0x6d, 0x69, 0x64, 0x69, 0x20, 0x6d, 0x65, 0x73, 0x73, 0x61, 0x67
	DB	0x65, 0x20, 0x3a, 0x00
; ; Starting pCode block
__str_18:
	DB	0x44, 0x6f, 0x6e, 0x27, 0x74, 0x20, 0x70, 0x75, 0x73, 0x68, 0x20, 0x61
	DB	0x6e, 0x20, 0x61, 0x6c, 0x72, 0x65, 0x61, 0x64, 0x79, 0x20, 0x61, 0x63
	DB	0x74, 0x69, 0x76, 0x65, 0x20, 0x72, 0x61, 0x64, 0x69, 0x6f, 0x20, 0x72
	DB	0x65, 0x6c, 0x61, 0x79, 0x00
; ; Starting pCode block
__str_19:
	DB	0x43, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x53, 0x61, 0x76, 0x65, 0x20
	DB	0x74, 0x6f, 0x00
; ; Starting pCode block
__str_20:
	DB	0x50, 0x72, 0x65, 0x73, 0x65, 0x74, 0x20, 0x30, 0x00
; ; Starting pCode block
__str_21:
	DB	0x44, 0x69, 0x73, 0x63, 0x61, 0x72, 0x64, 0x65, 0x64, 0x20, 0x73, 0x61
	DB	0x76, 0x69, 0x6e, 0x67, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74, 0x20
	DB	0x00
; ; Starting pCode block
__str_22:
	DB	0x2a, 0x2a, 0x20, 0x20, 0x53, 0x41, 0x56, 0x45, 0x44, 0x20, 0x74, 0x6f
	DB	0x20, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_23:
	DB	0x49, 0x67, 0x6e, 0x6f, 0x72, 0x65, 0x64, 0x2c, 0x20, 0x61, 0x6c, 0x72
	DB	0x65, 0x61, 0x64, 0x79, 0x20, 0x61, 0x74, 0x20, 0x68, 0x69, 0x67, 0x68
	DB	0x65, 0x73, 0x74, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_24:
	DB	0x49, 0x67, 0x6e, 0x6f, 0x72, 0x65, 0x64, 0x2c, 0x20, 0x61, 0x6c, 0x72
	DB	0x65, 0x61, 0x64, 0x79, 0x20, 0x61, 0x74, 0x20, 0x6c, 0x6f, 0x77, 0x65
	DB	0x73, 0x74, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_25:
	DB	0x46, 0x61, 0x63, 0x74, 0x6f, 0x72, 0x79, 0x20, 0x52, 0x65, 0x73, 0x65
	DB	0x74, 0x00
; ; Starting pCode block
__str_26:
	DB	0x53, 0x54, 0x41, 0x52, 0x54, 0x55, 0x50, 0x20, 0x50, 0x52, 0x45, 0x53
	DB	0x45, 0x54, 0x00
; ; Starting pCode block
__str_27:
	DB	0x41, 0x70, 0x70, 0x6c, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20
	DB	0x72, 0x65, 0x61, 0x64, 0x79, 0x2e, 0x00
; ; Starting pCode block
__str_28:
	DB	0x53, 0x41, 0x56, 0x45, 0x00
; ; Starting pCode block
__str_29:
	DB	0x42, 0x41, 0x43, 0x4b, 0x00
; ; Starting pCode block
__str_30:
	DB	0x74, 0x6f, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74, 0x20, 0x00
; ; Starting pCode block
__str_31:
	DB	0x3e, 0x00
; ; Starting pCode block
__str_32:
	DB	0x51, 0x00
; ; Starting pCode block
__str_33:
	DB	0x20, 0x20, 0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68
	DB	0x20, 0x31, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_34:
	DB	0x20, 0x20, 0x50, 0x72, 0x65, 0x73, 0x65, 0x74, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_35:
	DB	0x2a, 0x2a, 0x20, 0x20, 0x20, 0x4e, 0x6f, 0x74, 0x68, 0x69, 0x6e, 0x67
	DB	0x20, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_36:
	DB	0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x53, 0x61, 0x76, 0x65, 0x64, 0x20
	DB	0x20, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_37:
	DB	0x20, 0x20, 0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68
	DB	0x20, 0x32, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_38:
	DB	0x20, 0x20, 0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68
	DB	0x20, 0x33, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_39:
	DB	0x20, 0x20, 0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68
	DB	0x20, 0x34, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_40:
	DB	0x20, 0x20, 0x4d, 0x49, 0x44, 0x49, 0x20, 0x63, 0x68, 0x61, 0x6e, 0x6e
	DB	0x65, 0x6c, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_41:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_42:
	DB	0x20, 0x53, 0x74, 0x61, 0x72, 0x74, 0x75, 0x70, 0x20, 0x50, 0x72, 0x65
	DB	0x73, 0x65, 0x74, 0x20, 0x00
; ; Starting pCode block
__str_43:
	DB	0x20, 0x2a, 0x2a, 0x20, 0x4c, 0x61, 0x73, 0x74, 0x20, 0x55, 0x73, 0x65
	DB	0x64, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_44:
	DB	0x20, 0x20, 0x53, 0x65, 0x6e, 0x64, 0x20, 0x4d, 0x49, 0x44, 0x49, 0x20
	DB	0x3f, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_45:
	DB	0x59, 0x65, 0x73, 0x00
; ; Starting pCode block
__str_46:
	DB	0x4e, 0x6f, 0x00
; ; Starting pCode block
__str_47:
	DB	0x20, 0x52, 0x65, 0x6c, 0x6f, 0x61, 0x64, 0x20, 0x41, 0x63, 0x74, 0x69
	DB	0x76, 0x65, 0x20, 0x3f, 0x00
; ; Starting pCode block
__str_48:
	DB	0x20, 0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x20, 0x20, 0x74, 0x79
	DB	0x70, 0x65, 0x20, 0x00
; ; Starting pCode block
__str_49:
	DB	0x4d, 0x6f, 0x6d, 0x65, 0x6e, 0x74, 0x61, 0x72, 0x79, 0x00
; ; Starting pCode block
__str_50:
	DB	0x54, 0x6f, 0x67, 0x67, 0x6c, 0x65, 0x00
; ; Starting pCode block
__str_51:
	DB	0x20, 0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x20, 0x20, 0x6d, 0x6f
	DB	0x64, 0x65, 0x20, 0x00
; ; Starting pCode block
__str_52:
	DB	0x52, 0x61, 0x64, 0x69, 0x6f, 0x00
; ; Starting pCode block
__str_53:
	DB	0x46, 0x72, 0x65, 0x65, 0x00
; ; Starting pCode block
__str_54:
	DB	0x2a, 0x2a, 0x20, 0x20, 0x20, 0x4f, 0x70, 0x74, 0x69, 0x6f, 0x6e, 0x73
	DB	0x20, 0x20, 0x2a, 0x2a, 0x00
; ; Starting pCode block
__str_55:
	DB	0x41, 0x6c, 0x6c, 0x00
; ; Starting pCode block
__str_56:
	DB	0x50, 0x52, 0x4f, 0x47, 0x00
; ; Starting pCode block
__str_57:
	DB	0x4f, 0x50, 0x54, 0x53, 0x00
; ; Starting pCode block
__str_58:
	DB	0x50, 0x72, 0x65, 0x73, 0x65, 0x74, 0x20, 0x00
; ; Starting pCode block
__str_59:
	DB	0x52, 0x65, 0x63, 0x65, 0x69, 0x76, 0x65, 0x64, 0x20, 0x4d, 0x69, 0x64
	DB	0x69, 0x20, 0x4d, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65, 0x20, 0x3a, 0x20
	DB	0x00
; ; Starting pCode block
__str_60:
	DB	0x49, 0x67, 0x6e, 0x6f, 0x72, 0x65, 0x64, 0x2c, 0x20, 0x42, 0x61, 0x64
	DB	0x20, 0x4d, 0x49, 0x44, 0x49, 0x20, 0x63, 0x68, 0x61, 0x6e, 0x6e, 0x65
	DB	0x6c, 0x00
; ; Starting pCode block
__str_61:
	DB	0x49, 0x67, 0x6e, 0x6f, 0x72, 0x65, 0x64, 0x2c, 0x20, 0x6e, 0x6f, 0x74
	DB	0x20, 0x61, 0x20, 0x50, 0x43, 0x20, 0x6d, 0x65, 0x73, 0x73, 0x61, 0x67
	DB	0x65, 0x00
; ; Starting pCode block
__str_62:
	DB	0x50, 0x43, 0x00
; ; Starting pCode block
__str_63:
	DB	0x20, 0x3a, 0x20, 0x4c, 0x6f, 0x61, 0x64, 0x69, 0x6e, 0x67, 0x20, 0x70
	DB	0x72, 0x65, 0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_64:
	DB	0x20, 0x3a, 0x20, 0x54, 0x6f, 0x67, 0x67, 0x6c, 0x65, 0x20, 0x52, 0x65
	DB	0x6c, 0x61, 0x79, 0x00
; ; Starting pCode block
__str_65:
	DB	0x20, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x00
; ; Starting pCode block
__str_66:
	DB	0x50, 0x43, 0x31, 0x30, 0x39, 0x20, 0x3a, 0x20, 0x55, 0x70, 0x20, 0x6f
	DB	0x6e, 0x65, 0x20, 0x70, 0x72, 0x65, 0x73, 0x65, 0x74, 0x00
; ; Starting pCode block
__str_67:
	DB	0x66, 0x72, 0x6f, 0x6d, 0x00
; ; Starting pCode block
__str_68:
	DB	0x74, 0x6f, 0x00
; ; Starting pCode block
__str_69:
	DB	0x49, 0x67, 0x6e, 0x6f, 0x72, 0x65, 0x64, 0x20, 0x4d, 0x69, 0x64, 0x69
	DB	0x20, 0x49, 0x6e, 0x20, 0x6d, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65, 0x3a
	DB	0x20, 0x00
; ; Starting pCode block
__str_70:
	DB	0x50, 0x43, 0x20, 0x6e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x20, 0x74, 0x6f
	DB	0x6f, 0x20, 0x68, 0x69, 0x67, 0x68, 0x00
; ; Starting pCode block
__str_71:
	DB	0x46, 0x6f, 0x6f, 0x74, 0x73, 0x77, 0x69, 0x74, 0x63, 0x68, 0x3a, 0x20
	DB	0x00
; ; Starting pCode block
__str_72:
	DB	0x64, 0x65, 0x70, 0x72, 0x65, 0x73, 0x73, 0x65, 0x64, 0x00
; ; Starting pCode block
__str_73:
	DB	0x70, 0x72, 0x65, 0x73, 0x73, 0x65, 0x64, 0x00
; ; Starting pCode block
__str_74:
	DB	0x42, 0x75, 0x74, 0x74, 0x6f, 0x6e, 0x3a, 0x20, 0x00
; ; Starting pCode block
__str_75:
	DB	0x4e, 0x4f, 0x54, 0x48, 0x49, 0x4e, 0x47, 0x20, 0x54, 0x4f, 0x20, 0x44
	DB	0x4f, 0x20, 0x49, 0x4e, 0x20, 0x44, 0x49, 0x4e, 0x20, 0x4e, 0x4f, 0x54
	DB	0x49, 0x46, 0x59, 0x00


; Statistics:
; code size:	10182 (0x27c6) bytes ( 7.77%)
;           	 5091 (0x13e3) words
; udata size:	   46 (0x002e) bytes ( 3.59%)
; access size:	   10 (0x000a) bytes


	end
