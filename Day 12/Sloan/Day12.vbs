option explicit

Include "GlobalFunctions"
Include "ArrayFunctions"

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("TestInput.txt")
Dim arrSections : arrSections = Split(Trim(file.readAll()), VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true

'----------------------------------------------------------------------



'----------------------------------------------------------------------



'----------------------------------------------------------------------

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

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
