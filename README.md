# gen2nblib.sh
[![License](https://img.shields.io/badge/license-GPLv3-9977bb.svg?style=plastic)](https://github.com/Obsidian-StudiosInc/gen2nblib/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/Obsidian-StudiosInc/gen2nblib/master.svg?colorA=9977bb&style=plastic)](https://travis-ci.org/Obsidian-StudiosInc/gen2nblib)
[![Build Status](https://img.shields.io/shippable/58597abb8171491100bb9d11/master.svg?colorA=9977bb&style=plastic)](https://app.shippable.com/projects/58597abb8171491100bb9d11/)

Simple script to generate Netbeans library xml files for all Java 
libraries installed on a Gentoo/Funtoo based system.

## Usage
Just execute the script to generate or re-generate. The script is simple 
and does not remove libraries removed from the system. It will update 
existing xml files, as it deletes and re-creates all on each run. Very 
crude, but functional for now.

There is no output during normal function.

```bash
./gen2nblib.sh
```
