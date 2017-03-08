# switchboot
A simple .bat file to switch booting system for USB disk (by moving files to/from the root folder of the disk)

## Usage
- Put this file under the root directory of the usb disk.
- Put each booting system under a folder named by an `{ID}` (which will be used later). 
- Create a `{ID}.txt` file under folder `{ID}`, which contains the names of all the files and folders under folder `{ID}`. You can use the following command under folder {ID}. Example is provided (`UBUNTU.txt`).
```
dir /B > {ID}.txt
```
- Create a `systemlist.txt` file under the root directory, with each line being {ID}:{DESCRIPTION}. Example is provided (`systemlist.txt`).
- You can hide these folders and files if you don't want to see them every day.
- (Optional) Any system with an `{ID}` starting with "WINDOWS" will be considered windows system and a "Legacy" option will appear in the switch menu if you have a `{ID}Legacy.txt` under folder `{ID}`. This txt file should not contain the `efi` folder of windows setup disk. In this case, the usb disk would not boot into EFI mode.
