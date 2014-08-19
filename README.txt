
PedalSwitcher

===============================================================================
Copyright (C) 2013  Raphaël Mouneyres (rmouneyres@gmail.com)
Licensed for personal non-commercial use only.
All other rights reserved.
===============================================================================

A precompiled binary is already part of this package:
   o project.hex (can be loaded into MIOS Studio)

Following tools are required to recompile the code:
   o SDCC
   o gputils

The details are described under
   http://www.midibox.org/dokuwiki/application_development

===============================================================================

Required hardware:
   o one MBHP_CORE module
   o one MBHP_DIN module
   o one MBHP_DOUT module
	Warning : 220R resistors must not be mounted on relay outputs
   o one 2x16 LCD display

===============================================================================

PedalSwitcher is aimed at building a relay switcher as used by many guitarists
and bassists using many effect pedals.

With the current version it has following features :
- Midi In/out/through
- LCD display
- 8 relays either switched or momentary 
- 4 menu buttons, 8 relay butttons with LED indicator
- 100 user presets
- 4 programmable quick access buttons (recall preset) with LED indicator
- grouping (radio mode) of relay buttons

MIDI CONTROL :
 PC00 : all relays off
 PC01…100 : recall preset 1..99
 PC101…108 : toggle relay 1…8
 PC109…110 : UP/DOWN preset

When a MIDI Program Change is received, the app automatically switches to the
new preset, without saving the current preset.

===============================================================================

Developper Notes :

see comments in main.c

// EEPROM BYTE 0x00 : global options
 // MidiChannel	// bit0>3
 // SendMidiOnButtonChange // bit4
 // ReloadActivePreset // bit5
 // ForceStartupPreset // bit6
 // // bits7>8 free
// EPROM BYTE 0x01 : Current Preset
// EPROM BYTE 0x02 : RelayType[1..8]
// EPROM BYTE 0x03 : RelayMode[1..8]
// EPROM BYTE 0x04 : Footswitch 1 preset
// EPROM BYTE 0x05 : Footswitch 2 preset
// EPROM BYTE 0x06 : Footswitch 3 preset
// EPROM BYTE 0x07 : Footswitch 4 preset
// EPROM BYTE 0x08 : Preset for startup when selected
// EPROM BYTE 0x09 : *reserved*
// EPROM BYTE 0x0A : *reserved*
// EPROM BYTE 0x0B : *reserved*
// EPROM BYTE 0x0C : *reserved*
// EPROM BYTE 0x0D : *reserved*
// EPROM BYTE 0x0E : *reserved*
// EPROM BYTE 0x0F : *reserved*	

// EPROM BYTE 0x10 ... 0x74 : 	// 100 user presets
