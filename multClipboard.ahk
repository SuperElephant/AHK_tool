;mulClipboard.ahk
;
;------------------------------------------------------------
;@author Chaos 
;@date 2017/12
;------------------------------------------------------------
;It can save the clipboard up to 9 
;press ctrl+[number] you can paste the old things you copy by ctrl+c
;press ctrl+0 the history will be cleaned 
~^c::
	i = 9
	loop {
		lI := i-1 
		akey%i% := akey%lI%
		i:=i-1

	} Until i = 0
	akey1 := Clipboard
	Return

^1::sendInput {raw}%akey1%
^2::sendInput {raw}%akey2%
^3::sendInput {raw}%akey3%
^4::sendInput {raw}%akey4%
^5::sendInput {raw}%akey5%
^6::sendInput {raw}%akey6%
^7::sendInput {raw}%akey7%
^8::sendInput {raw}%akey8%
^9::sendInput {raw}%akey9%
^0::
	loop,9{
		akey%A_Index% = 
	}
	return