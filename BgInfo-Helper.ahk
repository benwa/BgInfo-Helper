;@Ahk2Exe-SetCopyright Bennett Blodinger
;@Ahk2Exe-SetDescription Quality of life improvements for Sysinternal's BgInfo
;@Ahk2Exe-SetLanguage 0x0409
;@Ahk2Exe-SetName BgInfo-Helper
;@Ahk2Exe-SetVersion 1.0.0

;@Ahk2Exe-IgnoreBegin
#Warn
;@Ahk2Exe-IgnoreEnd
/*@Ahk2Exe-Keep
#NoTrayIcon
ListLines Off
*/
#NoEnv
#Persistent
#SingleInstance, Force

Process, Priority, , Low

#Include, %A_ScriptDir%\Lib\Gdip_All.ahk

global executable, global parameters

; Get bitness
if (A_Is64bitOS) {
	executable := "BgInfo64.exe"
} else {
	executable := "BgInfo.exe"
}

; Parse arguments
For Each, argument In A_Args {
	parameters .= (parameters <> "" ? A_Space : "") . argument
}

; Convert unsupported image formats
ConvertWallpaper(format:="bmp") {
	RegRead, currentWallpaper, HKEY_CURRENT_USER\Control Panel\Desktop, WallPaper
	SplitPath, currentWallpaper, currentWallpaper_outFileName, currentWallpaper_outDir, currentWallpaper_outExtension, currentWallpaper_outNameNoExt, currentWallpaper_outDrive
	StringUpper, currentWallpaper_outExtension, currentWallpaper_outExtension
	If (!RegExMatch(currentWallpaper_outExtension, "^(?i:BMP|JPG|GIF)$")) {
		If (pToken0 := Gdip_Startup()) {
			convertedWallpaper := A_Temp . "\" . currentWallpaper_outNameNoExt . "." . format
			pBitmap0 := Gdip_CreateBitmapFromFile(currentWallpaper)
			Gdip_SaveBitmapToFile(pBitmap0, convertedWallpaper)
			Gdip_DisposeImage(pBitmap0)
			Gdip_Shutdown(pToken0)
		}
		DllCall("SystemParametersInfo", Int, 0x14, Int, 0, Str, convertedWallpaper, Int, 3)
	}
}

; Refresh BgInfo at startup
WM_DISPLAYCHANGE(0, 0)

; Listen for resolution changes
OnMessage(0x7E, "WM_DISPLAYCHANGE")

WM_DISPLAYCHANGE(wParam, lParam) {
	ConvertWallpaper("bmp")
	Run, %executable% %parameters%
	DllCall("SetProcessWorkingSetSize", Int, -1, Int, -1, Int, -1)
}
