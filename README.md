# BgInfo-Helper
Quality of life improvements for Sysinternal's BgInfo

## Features
- Refresh wallpaper on resolution change
  - Including un/docking
- File format conversion
  - Workaround for black wallpaper when using a PNG

## Installation
Place `BgInfo-Helper.exe` in the same folder as `BgInfo.exe` and `BgInfo64.exe`.
If you get a *Publisher Could Not Be Verified* prompt when trying to run this, use [Sysinternal's streams](https://docs.microsoft.com/en-us/sysinternals/downloads/streams) to remove the alternate data streams.

```cmd
streams64.exe -d BgInfo-Helper.exe
```

## Usage
Run `BgInfo-Helper.exe` with parameters that will be passed to `BgInfo.exe`. Check [BgInfo's documentation here](https://docs.microsoft.com/en-us/sysinternals/downloads/bginfo).

```cmd
BgInfo-Helper.exe VDI.bgi /accepteula /timer:0 /silent
```

## Contributing
Pull requests are welcome. For major changes, please start a Discussion on what you would like to change.

## License
[MIT](LICENSE)
