option explicit

Include "ArrayFunctions"

'---------------------------------
'   "Global" Function Variables
Dim ValidSeeds

'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrSections : arrSections = Split(Trim(file.readAll()), VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true

'----------------------------------------------------------------------

Dim arrSection
For Each arrSection in arrSections
	If arrSection <> "" Then
		Dim OASIS : OASIS = Split(arrSection," ")
		answer1 = answer1 + AwakenedDifferenceEngine(OASIS)
		answer2 = answer2 + AwakenedDifferenceEngine(ArrayReverse(OASIS))
	End If
Next














WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

Function AwakenedDifferenceEngine(prmArray)
	Dim subI, diffArr, allZeroes
	allZeroes = True
	Dim lastVal : lastVal = CLng(prmArray(0))
	For subI = 1 to UBound(prmArray)
		Dim thisVal : thisVal = CLng(prmArray(subI))
		If thisVal <> 0 Then
			allZeroes = False
		End If

		ArrayPush diffArr, thisVal - lastVal
		lastVal = thisVal
	Next

	If allZeroes Then
		AwakenedDifferenceEngine = 0
		Exit Function
	End If

	AwakenedDifferenceEngine = lastVal + AwakenedDifferenceEngine(diffArr)
End Function




















Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	If debug then
		WriteLine msg
	End if
End Sub

Sub Include (prmFile)
	Dim FSO, file, fileData
	Set FSO = createObject ("Scripting.FileSystemObject")
	If Right(prmFile,4) <> ".vbs" Then
		prmFile = prmFile & ".vbs"
	End If
	Set file = FSO.openTextFile(prmFile)
	fileData = file.readAll()
	file.close
	fileData = Split(fileData, "'SINGLE SCRIPT ONLY'")(0)
	executeGlobal fileData
	Set FSO = nothing
End Sub

Function Max(prm1, prm2)
	If prm1 >= prm2 Then
		Max = prm1
		Exit Function
	End If
	Max = prm2
End Function

Function Min(prm1, prm2)
	If prm1 <= prm2 Then
		Min = prm1
		Exit Function
	End If
	Min = prm2
End Function
