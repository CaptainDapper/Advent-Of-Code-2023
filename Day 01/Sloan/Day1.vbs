dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
dim file : Set file = FSO.OpenTextFile("Input.txt")
dim arrLines : arrLines = Split(file.readAll(),VbCrLf)

Dim part2 : part2 = true
Dim debug : debug = true

dim regex : Set regex = CreateObject("VBScript.RegExp")
regex.Global  = True
regex.Pattern = "[A-Za-z]"

dim total : total = 0
For i = 0 to UBound(arrLines)
	dim curLine : curLine = arrLines(i)

	If part2 Then
		dim oldLine
		Do
			oldLine = curLine
			curLine = Replace(curLine,"one","o1e")
			curLine = Replace(curLine,"two","t2o")
			curLine = Replace(curLine,"three","t3e")
			curLine = Replace(curLine,"four","f4r")
			curLine = Replace(curLine,"five","f5e")
			curLine = Replace(curLine,"six","s6x")
			curLine = Replace(curLine,"seven","s7n")
			curLine = Replace(curLine,"eight","e8t")
			curLine = Replace(curLine,"nine","n9e")
		Loop While curLine <> oldLine

		DebugLine arrLines(i) + " => " + curLine + " => " + regex.Replace(curLine, "")
	End If

	curLine = regex.Replace(curLine, "")
	'DebugLine curLine

	If Len(curLine) >= 0 Then
		total = total + CInt(Left(curLine,1) + Right(curLine,1))
	End If
Next

WriteLine total

Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	if debug then
		WriteLine msg
	end if
End Sub
