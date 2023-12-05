option explicit

'---------------------------------
'   "Global" Function Variables

Dim CardDictionary : Set CardDictionary = CreateObject("Scripting.Dictionary")

'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrLines : arrLines = Split(file.readAll(),VbCrLf)

Dim symbols : symbols = "#$%&*+-/=@"

Dim part2 : part2 = false
Dim debug : debug = true

Dim i,j,x,y,lol

Dim total : total = 0
Dim twotal : twotal = 0

'For i = 0 to UBound(arrLines)
'	arrLines(i) = Split(arrLines(i),"")
'Next

For i = 0 to UBound(arrLines)
	'DebugLine("------------")
	Dim curLine : curLine = arrLines(i)
	Dim gameNum : gameNum = i + 1
	Dim copyCount : copyCount = GetCopyCount(gameNum)

	If curLine <> "" Then
		Dim scratchCard : scratchCard = Split(Trim(curline),":")(1)
		Dim sections : sections = Split(Trim(scratchCard),"|")
		Dim needles : needles = ArraySort(Split(Trim(sections(0)), " "))
		Dim haystacks : haystacks = ArraySort(Split(Trim(sections(1)), " "))

		Dim winners : winners = 0
		For j = 0 to UBound(needles)
			If ArrayContains(haystacks, needles(j)) Then
				winners = winners + 1
			End If
		Next

		Call ApplyWins(gameNum, winners, copyCount)

		twotal = twotal + copyCount
		'DebugLine gameNum & ": " & copyCount & " " & winners & " | " & twotal

		If winners > 0 Then
			'DebugLine Join(needles, " ") + " | " + Join(haystacks, " ")
			Dim gameTotal : gameTotal = 2 ^ (winners - 1)
			'DebugLine gameTotal
			total = total + gameTotal
		End If
	End If
Next

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(total)
WriteLine "Part 2: " + CStr(twotal)
Function GetCopyCount(prmGameNum)
	If Not CardDictionary.Exists(prmGameNum) Then
		Call CardDictionary.Add(prmGameNum, 1)
	End If

	GetCopyCount = CardDictionary(prmGameNum)
End Function

Function SetCopyCount(prmGameNum, prmCount)
	If Not CardDictionary.Exists(prmGameNum) Then
		Call CardDictionary.Add(prmGameNum, prmCount)
	Else
		CardDictionary(prmGameNum) = prmCount
	End If
End Function

Function AddCopies(prmGameNum, prmCount)
	Dim count : count = GetCopyCount(prmGameNum)
	Call SetCopyCount(prmGameNum, count + prmCount)
End Function

Function ApplyWins(prmGameNum, prmWinsCount, prmCopyCount)
	Dim subI
	For subI = 1 to prmWinsCount
		Call AddCopies(prmGameNum + subI, prmCopyCount)
	Next
End Function

Function ArrayContains(prmArray, prmSingle)
	Dim subI
	For subI = 0 to UBound(prmArray)
		'DebugLine subI
		If prmArray(subI) = prmSingle Then
			ArrayContains = True : Exit Function
		End If
	Next

	ArrayContains = False : Exit Function
End Function

Function ArraySort(prmArray)
	Dim arrList : Set arrList = CreateObject("System.Collections.ArrayList")
	Dim subI
	For subI = 0 to UBound(prmArray)
		Do
			If prmArray(subI) = "" Then
				Exit Do
			End If
			'DebugLine TypeName(prmArray(subI)) + "|" + prmArray(subI) + "|"
			arrList.Add(CInt(prmArray(subI)))
		Loop While False
	Next

	arrList.Sort()

	Dim retArr : ReDim retArr(arrList.Count - 1)
	For subI = 0 to arrList.Count - 1
		retArr(subI) = CStr(arrList(subI))
	Next

	ArraySort = retArr
End Function









Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	if debug then
		WriteLine msg
	end if
End Sub

