option explicit

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrLines : arrLines = Split(file.readAll(),VbCrLf)

Dim part2 : part2 = false
Dim debug : debug = true

'dim regex : Set regex = CreateObject("VBScript.RegExp")
'regex.Global  = True
'regex.Pattern = "[A-Za-z]"
Const MAX_RED = 12
Const MAX_BLUE = 14
Const MAX_GREEN = 13

Dim i,j,k

Dim total : total = 0
Dim twotal : twotal = 0
For i = 0 to UBound(arrLines)
	Dim curLine : curLine = arrLines(i)
	Dim gameNum : gameNum = i+1

	If curLine <> "" Then
		curLine = Trim(Split(curline,":")(1))
		Dim showings : showings = Split(curLine,";")
		Dim maxRed, maxBlue, maxGreen
		maxRed = 0 : maxBlue = 0 : maxGreen = 0
		For j = 0 to UBound(showings)
			Dim curShowing : curShowing = showings(j)
			Dim blocks : blocks = Split(curShowing,",")
			For k = 0 to UBound(blocks)
				Dim curBlock : curBlock = Trim(blocks(k))
				maxRed = MaxForColor(curBlock, "red", maxRed)
				maxBlue = MaxForColor(curBlock, "blue", maxBlue)
				maxGreen = MaxForColor(curBlock, "green", maxGreen)
			Next
		Next

		DebugLine(CStr(gameNum) + ") " + CStr(maxRed) + " " + CStr(maxBlue) + " " + CStr(maxGreen) + " | " + CStr(maxRed * maxBlue * maxGreen))
		DebugLine(CStr(gameNum) + ") " + CStr(maxRed <= MAX_RED) + " " + CStr(maxBlue <= MAX_BLUE) + " " + CStr(maxGreen <= MAX_GREEN))

		If maxRed <= MAX_RED and maxBlue <= MAX_BLUE and maxGreen <= MAX_GREEN Then
			total = total + gameNum
		End If

		twotal = twotal + (maxRed * maxBlue * maxGreen)

		DebugLine(total)
		DebugLine(twotal)
	End If
Next

WriteLine total
WriteLine twotal

Function MaxForColor(prmBlock, prmColor, prmMax)
	MaxForColor = CInt(prmMax)

	If Right(prmBlock,len(prmColor)) = prmColor Then
		Dim blockCount : blockCount = CInt(Split(prmBlock," ")(0))
		If blockCount > CInt(prmMax) Then
			MaxForColor = CInt(blockCount)
		End If
	End If
End Function









Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	if debug then
		WriteLine msg
	end if
End Sub
