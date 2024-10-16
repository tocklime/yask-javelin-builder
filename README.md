# YASK javelin builder

This will compile the engine, but not all the dictionaries etc for the javelin firmware.

As such, you first need to flash a firmware from the (closed source) firmware builder at https://lim.au/. This will include the engine for whichever board you choose (I've been using the starboard). Then you get the .uf2 from this project and flash it over the top, and hopefully the whole thing works.

The firmware builder has a lot of options that can't be controlled from script, so here's my notes from the last time I did it:

## Hardware

* Select your hardware: Starboard
* [x] Show expert options

## Keyboard Emulation

* [ ] Simple [x] Advanced

### Host layout list

* Upload the 3 yaml files from this project (`uk_{ibus,win_alt,win_hex}.yaml`).
* Keyboard Protocol: default

## Options

* Space Position: Before

* don't enable first up or repeat


## Dictionaries

* Check All the built in ones

* Upload the dictionaries from https://github.com/tocklime/plover_dictionaries : 
  * [ ] jeff-numbers
  * [x] jeff-show-stroke
  * [x] user.json - be sure to promote anything in the onboard ram of the to-be-overwritten firmware.
  * [ ] jeff-phrasing
  * [x] abby-left-hand-modifiers.json
  * [x] emily-modifiers.json
  * [x] emily-symbols
  * [x] warbler-base.json
  * [x] lapwing-javelin-additions.json
  * [ ] lapwing-semi-modal-movements.json
  * [x] lapwing-commands.json
  * [x] lapwing-numbers.json
  * [x] lapwing-uk-additions.json
  * [x] lapwing-proper-nouns.json
  * [x] lapwing-base.json

* [x] Generate reverse lookup tables

## Key map

Load `layout-script.javelin-script` from this directory.

## Orthograpy

Use `american_english_words.txt` and `english-orthography.json` from this dir.
