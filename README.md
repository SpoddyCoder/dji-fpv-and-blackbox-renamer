# SpoddyCoder DJI FPV and Blackbox Renamer

A little tool to rename the video and blackbox files pulled from a sesssion.
Renames to the following format;

```
Flight_1.AIR.mp4
Flight_1.BFL
Flight_1.GOG.mp4
Flight_1.GOG.srt
```

The renamed prefix and postfix parts can be modified by editing the tool constants.
TODO: params for input dir, prefix


## Usage

1. Copy `dfab-renamer.sh` to directory containing the files
2. Run in test mode to see what would happen `./dfab-renamer.sh`
3. Run in live mode to rename the files `./dfab-renamer.sh go`


## Notes

This is bash script (Mac/Linux) - install GitBash to use it on Windows.
