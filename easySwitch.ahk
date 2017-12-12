
;------------------------------------------------------------
;initialize the program
selected := false
startTime = 
SysGet, mainM, Monitor
SysGet, monitorCount, MonitorCount

if(monitorCount>9){
	;not support more then 9 monitor 
	return
}
	
;distribute key for each monitor (accroding to the position)
;test pass
Loop, %monitorCount%{
            
	SysGet, m, Monitor, %A_Index%
	;MsgBox, %mTop%, %mBottom%. %mLeft%, %mRight%.
	temp := distributeKey() 
	key%temp% := A_Index 
	
	;MsgBox, %temp%
}
return


#If key1 != 0
#Numpad1:: pressKey(1)
#If key2 != 0
#Numpad2:: pressKey(2)
#If key3 != 0
#Numpad3:: pressKey(3)
#If key4 != 0
#Numpad4:: pressKey(4)
#If key5 != 0
#Numpad5:: pressKey(5)
#If key6 != 0
#Numpad6:: pressKey(6)
#If key7 != 0
#Numpad7:: pressKey(7)
#If key8 != 0
#Numpad8:: pressKey(8)
#If key9 != 0
#Numpad9:: pressKey(9)

pressKey(key){
	global preserent
	global selected 
	global targetWinId
	global allId
	global from
	global to
	
	if (!selected){
		from := key%key%
		WinGet, allId, list
		Loop, %allId%{
			;this_id := allId%A_Index%
			if(isInMonitor(from, allId%A_Index%)){
				targetWinId := allId%A_Index%
				selected := true
				startTime := A_TickCount
				
				KeyWait, Numpad%key% ,L
				return
			}
		}
		MsgBox, No windows in monitor %monitor% finded
	}else{
		to := key%key%
		if(notLate(startTime)){
			current := WinActive("A")
			SysGet, tar, Monitor,%to%
			SysGet, ori, Monitor,%from%
			WinGetPos,ox,oy,ow,oh,ahk_id %targetWinId%
			
			W := ow/(oriRight-oriLeft)*(tarRight-tarLeft)
			H := oh/(oriBottom-oriTop)*(tarBottom-tarTop)
			
			X:= tarLeft+(ox-oriLeft)/(oriRight-oriLeft)*(tarRight-tarLeft)
			Y:= tarTop+(oy-oriTop)/(oriBottom-oriTop)*(tarBottom-tarTop)
			
			WinMove,ahk_id %targetWinId%,,X,Y,W,H
			;WinMaximize
			WinActivate,%current%
		}
		selected := false
		targetWinId = 
	}
}

notLate(startTime){
	return true   ;debug
	if (A_TickCount - startTime < 500){
		return true
	}else{
		return false
	}
}
	

isInMonitor(monitor, wId){
	WinGetTitle,title,ahk_id %wId%
	WinGetPos, X,Y,,,ahk_id %wId%
	SysGet, ori, Monitor,%monitor%
	if(title && X<=oriRight && X>=oriLeft && Y>=oriTop && Y<=oriBottom){
		;MsgBox,0,Notice, Win %title% finded,0.5
		return true
	}
	return false
}

distributeKey(){
	global mTop, mBottom, mLeft, mRight, mainMRight, mainMBottom
	if (mTop = 0 && mLeft = 0){
		return 5
	}else{
		if (mBottom <= 0 ){
			if (mRight<=0){
				return 7
			}else{
				if(mLeft >= mainMRight){
					return 9
				}else{
					return 8
				}
			}
		}else{
			if (mTop >= mainMBottom){
				if (mRight<=0)
					return 1
				if(mLeft >= mainMRight){
					return 34
				}else{
					return 2
				}
			}else{
				if (mRight<=0){
					return 4
				}else{
					return 6
				}
			}

			
		}
	}
	return error
}

~#1 Up::Send #{Space}

~^~ ::