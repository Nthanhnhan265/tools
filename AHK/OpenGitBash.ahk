#Requires AutoHotkey v2.0

^SC029::{
path := ""
; Get current WDIR if the current app is FILE EXPLORER. 
	hwnd := WinActive("ahk_class CabinetWClass")
	if !hwnd
		hwnd := WinActive("ahk_class ExploreWClass")
	if hwnd {
		for win in ComObject("Shell.Application").Windows {
		try {
			if (win.HWND = hwnd) {
				candidate := win.Document.Folder.Self.Path
			if DirExist(candidate)
				path := candidate
				break
			}
		}
		}
		}
; Open Terminal Globally 
if (path = "")
path := EnvGet("USERPROFILE")
Run 'wt.exe -p "Git Bash" -d "' path '"'
}
