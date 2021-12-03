# GTAModTools
 A collection of tools to assist with building mods and extracting game data from The GTA Trilogy: Definitive Edition

This project takes advantage of the _unintended files_ that Rockstar/GSG left in the Switch build of the Grand Theft Auto: Definitive Edition. This includes all uncompiled mission scripts, and R\*'s internal script compiler.

With the help of this project, you can easily extract a packaged Switch build (.nsp) of either of the three games in the trilogy, extract the associated Unreal PAK file, recompile mission scripts and repackage new PAK files to install as mods on the PC version of the game or on any modded console that supports game data editing.

Most of these tools can also be used with non-Switch versions of the game to create texture/asset mods that don't involve recompiling mission source code (The PC version of the games do not include the script compiler or full mission scripts).

Please Note: This repo does not contain _any_ proprietary code or other assets from Rockstar Games/Take-Two Interactive or Nintendo. It's simply a collection of open source tools that can be used to harness the data that was included with every original copy of the game sold on the Nintendo eShop and Rockstar Games Launcher. This project is intended for research purposes.

## :toolbox: Tools

* **Extract_NSP.bat** Extract a Switch NSP. _Requires keys.txt/keys.dat from an actual Nintendo Switch_

* **Extract_PAK.bat** Extract an Unreal PAK file. Accepts any PAK file from any build of either of the three games in the trilogy. Also probably works with some other Unreal Engine games.

* **CreateMod_GTAxx.bat** Configurable script to compile scripts, create a new mod archive and optionally auto-install it to your game install directory.

## :electric_plug: Preparation

Assuming you're starting from scratch with no game files and no knowledge of extracting NSP's or PAK files, here's a quick run-down on how to get started:

1. If you want to mod the source code of mission scripts and be able to recompile them into a new _main.scm_ which is used by the game, you'll need to get your hands on an NSP file for either of the three games in the trilogy. I can't help you with this. If you don't care about scripts, you can use a copy of the PC version. If you're using a PC version of the game, skip to step 5.

2. If you're using a Switch copy, you'll also need a dump of your Switch's firmware keys. This is often refered to as _keys.txt_ or _keys.dat_ and can be dumped with [Lockpick_RCM](https://github.com/shchmue/Lockpick_RCM "Lockpick_RCM on GitHub"). You can also find this file on the internet but I can't help you with that either. You'll need firmware keys for FW 13.0.0 or higher.

3. Drop your _keys.txt_/_keys.dat_ file and your game NSP file into the project folder alongside the batch scripts.

4. Drag the NSP file onto _Extract\_NSP.bat_. Provided your keys are valid it should automatically decrypt and extract the contents. You should be left with a _pakchunk0-Switch.pak_ file in your project folder once the script is finished.

5. Drag the _pakchunk0-Switch.pak_ file onto _Extract\_PAK.bat_ to extract the game data into a new folder called _staging_. Alternatively if you have the PC version you can find this PAK file in your install folder, then _Gameface\Content\Paks\gta.pak_.

6. Congratulations, you're now ready to make mods! When you run one of the CreateMod batch files, everything inside of the _staging_ folder will be packaged into your mod, so you can delete anything that you don't plan on modding now to save space. If you want to mod scripts, you'll need to keep the _Gameface\Content\OriginalData\*\Scripts\\_ folder, and the _\*.ide_, _miss2.exe_ & _gta3/gta\_vc/gta.dat_ files from _Gameface\Content\OriginalData\*\data\\_.

## :information_source: Usage

Run _CreateMod\_xx.bat_ (where xx refers to the target game) to automatically compile the game's mission scripts, package the _staging_ directory into a PAK file and optionally move it into your game's installation directory. In an ideal scenario, after running this script you should be able to launch your modded game without having to do anything else.

The _staging_ folder is where you work on your mod. Anything inside that folder will be packaged into your mod when you run the CreateMod script. For this reason, I recommend you delete anything you don't need as any files not present in your mod package will simply reference the core game PAK file. Any files in your mod which are identical to the base game are just a waste of space. It's important that you keep the same directory structure that was originally created when you extracted your PAK. Don't move existing files around into other folders or the game won't be able to use them.

Before running any of the CreateMod scripts, open them in a text editor first and take a look at the configuration section near the top. This contains some important variables which need to be set or can be altered to change the behaviour of the script. These include the ability to skip script compilation, skip PAK building, disable auto-installation and more.

## :bangbang:	Known Issues

Sadly, the script compiler for San Andreas is not currently working. It seems to be missing some necessary files that were not left in the final build of the game.

As far as I can tell from a quick assessment in Ghidra, the following C header files are missing (and by extension likely several other related files):

* Gameface\Plugins\SanAndreas\Source\SanAndreas\Private\FrontEnd\TouchInterface_SA.h
* Gameface\Plugins\GTABase\Source\GTABase\Classes\HID_Base.h
* Gameface\Plugins\SanAndreas\Source\SanAndreas\Private\FrontEnd\CommandList_SA.h

If you find a way around this roadblock please get in touch on [Twitter](https://twitter.com/ParadoxEpoch) or by submitting an issue to this repo.

## :heart: Support

If you'd like to support ongoing development of this and other open-source projects, a donation would be very much appreciated. I accept direct crypto donations via any of the addresses below or through [Coinbase Commerce](https://commerce.coinbase.com/checkout/bb4f7665-bfdc-4c22-9fc8-78299010b1c8).

**BTC:** bc1q6kqv5u2368j4l00rls5frg78wt7m6vf7a50sa7

**ETH:** 0x704fb3fD106D00e6D78880C25139141C4B24DFd7

**DOGE:** D6MZp3HMZQA6gFBhmcmYs6AjytXwQJ4bYj

**LTC:** ltc1qhqgsnzwumxm7q3u3m4rj0zcvwcvcvhqqrke07p

**XMR:** 8429Hzck9gdX43MF9NzNGjaeGdKBwjVTjgGDQfXKV6WxfSGubxuBi6mEh2nDWwXtAZUjMejV4Pamr5SfYp96QJZNEQecMqS
