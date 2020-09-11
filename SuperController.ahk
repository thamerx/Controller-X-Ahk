#SingleInstance force
; Stripped down and modified version of xinput.h
XINPUT_GAMEPAD_DPAD_UP          := 0x0001
XINPUT_GAMEPAD_DPAD_DOWN        := 0x0002
XINPUT_GAMEPAD_DPAD_LEFT        := 0x0004
XINPUT_GAMEPAD_DPAD_RIGHT       := 0x0008
XINPUT_GAMEPAD_START            := 0x0010
XINPUT_GAMEPAD_BACK             := 0x0020
XINPUT_GAMEPAD_LEFT_THUMB       := 0x0040
XINPUT_GAMEPAD_RIGHT_THUMB      := 0x0080
XINPUT_GAMEPAD_LEFT_SHOULDER    := 0x0100
XINPUT_GAMEPAD_RIGHT_SHOULDER   := 0x0200
XINPUT_GAMEPAD_GUIDE            := 0x0400 ; Undocumented
XINPUT_GAMEPAD_A                := 0x1000
XINPUT_GAMEPAD_B                := 0x2000
XINPUT_GAMEPAD_X                := 0x4000
XINPUT_GAMEPAD_Y                := 0x8000

XUSER_MAX_COUNT                 := 4 ; userIndex starts at 0, not 1 like I orginally assumed
ERROR_DEVICE_NOT_CONNECTED      := 1167

dll := "ccc1_3.dll"
xLib := initController()
userIndex := 0
areAltShiftdown := false ;;;
guide_meter := 0 ;;;
wasDownOnce := true ;;;;
mouseControl := false ;;;
timerIsActive := false ;;;

; starting the loooooooooooooooooop;
			Loop
			{
back := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_BACK,xLib) ; Get the state of the Guide button
xbutton := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_X,xLib) ; Get the state of the Guide button
ykey := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_Y,xLib) ; Get the state of the Guide button
akey := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_A,xLib) ; Get the state of the Guide button
bkey := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_B,xLib) ; Get the state of the Guide button
starrt := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_START,xLib) ; Get the state of the Guide button
lshould := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_LEFT_SHOULDER,xLib) ; Get the state of the Guide button
rshould := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_RIGHT_SHOULDER,xLib) ; Get the state of the Guide button
dbadUP := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_DPAD_UP,xLib) ; Get the state of the Guide button
dbadLeft := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_DPAD_LEFT,xLib) ; Get the state of the Guide button
dbadRight := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_DPAD_RIGHT,xLib) ; Get the state of the Guide button
dbadDown := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_DPAD_DOWN,xLib) ; Get the state of the Guide button
Guide := XInputGetStateEx(userIndex,XINPUT_GAMEPAD_GUIDE,xLib) ; Get the state of the Guide button


leftTrigger := XInputGetStateExTr("left",userIndex,xLib)
rightTrigger := XInputGetStateExTr("right",userIndex,xLib)

; KB AUDIO CONTROL

	LAltIsDown := GetKeyState("LALT", "P")
	LShiftIsDown := GetKeyState("LSHIFT", "P")
	QIsDown := GetKeyState("q", "P")
	SIsDown := GetKeyState("s", "P")
	AIsDown := GetKeyState("a", "P")	
	XIsDown := GetKeyState("x", "P")	 
	1IsDown := GetKeyState("1", "P")
	2IsDown := GetKeyState("2", "P")
	3IsDown := GetKeyState("3", "P")

	
	
	if (LAltIsDown)
	{
		if (QIsDown)
		{
			SoundSet, +0.6
			if(LShiftIsDown)
			{
				SoundSet, +1.5
			}
		}
		if (SIsDown)
		{	
			SoundSet, -0.6
			if(LShiftIsDown)
			{
				SoundSet, -1.5
			}
		}
		if (XIsDown)
		{	
			SoundSet, -0.6
			if(LShiftIsDown)
			{
				SoundSet, -1.5
			}
		}
		if (AIsDown)
		{	
			SoundSet, +0.6
			if(LShiftIsDown)
			{
				SoundSet, +1.5
			}
		}
		if (1IsDown)
		{	
			Send {Media_Prev}
			
		}
		if (2IsDown)
		{	
			Send {Media_Play_Pause}
			
		}
		if (3IsDown)
		{	
			Send {Media_next}
			
		}		
	}

;------Chrome seek control with controller

			; checking if gopher is running to avoid dual actions
			Process, Exist,  Gopher.exe 
			gohperIsRunning := ErrorLevel
			
			browseractive := false
			SetTitleMatchMode, 2
			if WinActive("‎ahk_exe chrome.exe")
			{
				browseractive := true
			}
			
			if WinActive("ahk_exe firefox.exe")
			{
				browseractive := true
			}
			;browseractive := (WinActive("ahk_exe chrome.exe")) or (WinActive("ahk_exe firefox.exe"))
	if browseractive and !(gohperIsRunning) and (back != -1)
		{


			
			if (dbadLeft)
			{
				send, {Left} 
				sleep 100
				;msgbox helloonce
				
			}
			
			if (dbadRight)
			{
				send, {Right} 
				sleep 100
				;msgbox helloonce
			}
			if (dbadUP)
			{
				Send, {SHIFTDOWN}{.}{SHIFTUP}
				sleep 400
				;msgbox helloonce
			}
			if (dbadDown)
			{
				Send, {SHIFTDOWN}{,}{SHIFTUP}
				sleep 400
				;msgbox helloonce
			}
			if (bkey)
			{
				Send, {f}
				sleep 400
				;msgbox helloonce
			}
			if (akey)
			{
				
				
					
						{
					
						Send, {space}
						;msgbox %ErrorLevel%
						}
						sleep 250
				
			}
		
		}


;-------------
		; AUDIO DAMN CONTROL BY MEH
	if (back != -1) ;CHECKING IF CONTROLLER CONNECTED
	{
	   if (back && ykey) = 1
		{	
		
			if (lshould)
			{
				Send {Media_Prev}
				sleep 140
				}
			if (rshould)
		{
			Send {Media_next}
			sleep 140
			}
			if (dbadUP)
		{
			Send {Media_Play_Pause}
			sleep 140
			}
		
		SoundSet, +(rightTrigger-leftTrigger)/65280		
			
			}
;-------------
		; win - tab menu	
		;;if (back && starrt) = 1
		;;{
			;;Send, {LWINDOWN}{TAB}{LWINUP}
			;;Sleep 1000
			;;}		
			
		
;-------------
		; alt-tab menu	
		if (back && starrt) = 1
		{
			;Send, {ALTDOWN}{TAB}
			 
			 if (lshould) = 1 {
			 
			 send, {ALTDOWN}{SHIFTDOWN}{TAB} 
			 areAltShiftdown := true
			 
			 }
			 
			 if (rshould) = 1 {
			 send, {ALTDOWN}{TAB} 
			 areAltShiftdown := true
			 }
			  if (xbutton && areAltShiftdown) = 1 {
			 send, {delete} 
			 

			 }
			 
			 
			 

			 sleep 120
				
		}else if (areAltShiftdown) = true
			{
											
								
				 send, {ALTUP} 
				 sleep 5
				 send, {SHIFTUP}
				 sleep 5 
				 ;;send, {enter}
				 areAltShiftdown := false
						
				
				;msgbox	hello
			}
		
			 
		;------------------------------
		if (Guide) = 1
		{
			guide_meter := guide_meter+51
			
			if (guide_meter) = 102  && wasDownOnce
			{
				SetTimer, resetGuideTimerPls, Off
				timerIsActive := false
				guide_meter := 0
				wasDownOnce := false


				
				SetTimer, startMouseControl, -5
				;msgbox hello + %guide_meter%
			}
			if !(timerIsActive)
				{
					SetTimer, resetGuideTimerPls, -500 ; timer needs to be negative 
					timerIsActive := true
				}
				
			 sleep 100
		}else if (guide_meter) > 0
			{
				wasDownOnce := true
				 ;msgbox helloonce
			}

		
		
		
			


	}

	Sleep 10 ;loop sleeper
}
;end of the loooooooooooooooooooop;

;------------sort of a timed function-----------------------
			resetGuideTimerPls:
			guide_meter := 0
			wasDownOnce := false
			timerIsActive := false
			return
;----------------launchMouseControl--------------------
			startMouseControl:
			
			if (mouseControl) = false {
			Process, Exist,  Gopher.exe
			gohperIsRunning := ErrorLevel
			if !(gohperIsRunning)
			{
						run, "%A_WorkingDir%\Gopher.exe",, Hide 
				

						;msgbox hello
			}
			SetTimer, drawMouseControlGUI, -5 ; calls to draw mouse overlay
			mouseControl := true
			;msgbox opened
			}else {
			Process, Close  , Gopher.exe
			Gui Destroy ;destroy mouse GUI
			mouseControl := false
			;msgbox closed
			}
			sleep 150
			return
;----------------draw mouse control GUI-------------------
			drawMouseControlGUI:
				Gui, +AlwaysOnTop +Disabled -SysMenu +Owner  ; +Owner avoids a taskbar button.
				Gui, Color, EEAA99
				Gui -Caption
				Gui, Add, Text,, MouseActive.
				
				;Gui, Show, NoActivate, Mouse is active  ; NoActivate avoids deactivating the currently active window.
				Gui, Show, x0 y0 AutoSize, active  ; Resize the window to match the picture size.

			return
-------------------------------

initController(dll = "xinput1_3.dll"){
   if (!xLib := DllCall("LoadLibrary", "str", dll)){
       Msgbox ERROR: Unable to load %dll%!
       ExitApp
   }
   return xLib
}

XInputGetStateEx(userIndex,button,byRef xLib){
   global ERROR_DEVICE_NOT_CONNECTED

   VarSetCapacity(XINPUT_STATE, 16, 0)
   xAddress := DllCall("GetProcAddress", "Uint", xLib, "Uint", 100)
   xResult := DllCall(xAddress, "Uint", userIndex, "Ptr", &XINPUT_STATE) ; assuming this dllcall is XInputGetStateEx

   if (xResult == ERROR_DEVICE_NOT_CONNECTED)
      return -1
   wButtons := NumGet(XINPUT_STATE, 4, "UShort")

   return (wButtons & button)?1:0
}




XInputGetStateExTr(trigger,userIndex,byRef xLib){
    global ERROR_DEVICE_NOT_CONNECTED

    VarSetCapacity(XINPUT_STATE, 16, 0)
    xAddress := DllCall("GetProcAddress", "Uint", xLib, "Uint", 100)
    xResult := DllCall(xAddress, "Uint", userIndex, "Ptr", &XINPUT_STATE, "Char", leftTrigger, "Char", rightTrigger) ; assuming this dllcall is XInputGetStateEx

    if (xResult == ERROR_DEVICE_NOT_CONNECTED)
        return -1
	
	if (trigger = "left")
		triggerResult := NumGet(XINPUT_STATE, 5, "UShort")
    else if (trigger = "right")
		triggerResult := NumGet(XINPUT_STATE, 6, "UShort")

    return triggerResult
}