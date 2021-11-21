# DFAB-Renamer

DFAB-Renamer is a simple little tool to rename the DJI FPV goggles video + subtitles, air unit video and blackbox files pulled from a sesssion.

Renames to the following format;

```
Flight_1.AIR.mp4
Flight_1.AIR.BFL
Flight_1.GOG.mp4
Flight_1.GOG.srt
```

## Usage

Copy `dfab-renamer.sh` to the directory containing the files and double click it to run.
It will do a dry-run first and allow you to confirm before renaming the files.

## Notes

* The renamed prefix and postfix parts can be modified by editing the constants at the top of the tool.
* If you find this tool useful and wish it did something else too, let me me know.
* Pull requests welcome.