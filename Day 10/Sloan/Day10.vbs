option explicit

Include "GlobalFunctions"
Include "ArrayFunctions"

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrSections : arrSections = Split(Trim(file.readAll()), VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true

'----------------------------------------------------------------------

Const N = 1
Const E = 2
Const W = 4
Const S = 8

Dim map
For i = 0 To UBound(arrSections)
	If arrSections(i) <> "" Then
		ArrayPush map, StringToChars(arrSections(i))
	End If
Next

Dim startX, startY
Dim pipe1, pipe2
Set pipe1 = Nothing
' Dim pipe1X, pipe1Y, pipe1Next
' Dim pipe2X, pipe2Y, pipe2Next
For i = 0 To UBound(map)
	For j = 0 to UBound(map(i))
		If map(i)(j) = "S" Then
			startX = j
			startY = i

			'North; needs to check for South connection
			Call CheckNeighborPipes(i-1, j, 8)
			Call CheckNeighborPipes(i+1, j, 1)
			'West; needs to check for East connection
			Call CheckNeighborPipes(i, j-1, 2)
			Call CheckNeighborPipes(i, j+1, 4)
		End If
	Next
Next

WriteLine startY + 1 & " " & startX + 1
WriteLine pipe1.ToString()
WriteLine pipe2.ToString()

Do
	pipe1.TakeAStep()
	pipe2.TakeAStep()

	WriteLine pipe1.ToString()
	WriteLine pipe2.ToString()
Loop While Not (pipe1.X = pipe2.X And pipe1.Y = pipe2.Y)

answer1 = pipe1.Distance




















Class Pipe
	Private mMap
	Private mX, mY, mNext, mValue, mStep

	Public Property Get Distance()
		Distance = mStep
	End Property

	Public Property Get X()
		X = mX
	End Property

	Public Property Get Y()
		Y = mY
	End Property

	Public Default Function Initialize(ByRef prmMap, prmX, prmY, prmNext, prmValue, prmStep)
		mMap = prmMap
		mX = prmX
		mY = prmY
		mNext = prmNext
		mValue = prmValue
		mStep = prmStep

		Set Initialize = Me
	End Function

	Public Function ToString()
		ToString = "(" & mY + 1 & "," & mX + 1 & ") " & mStep & " {'" & mValue & "' => " & mNext & "}"
	End Function

	Public Sub TakeAStep()
		Dim nextX, nextY
		nextX = mX
		nextY = mY
		Select Case mNext
			Case N : nextY = nextY - 1
			Case E : nextX = nextX + 1
			Case W : nextX = nextX - 1
			Case S : nextY = nextY + 1
		End Select

		mX = nextX
		mY = nextY

		mValue = mMap(mY)(mX)
		'If we travel East, and the NEXT pipe connects W to N,
		'   we get the opposite of our travel and XOR it our.
		'   So: E => W, and NW XOR W = N!    -QED
		mNext = GetPipeFlags(mValue) Xor GetOpposite(mNext)
		mStep = mStep + 1
	End Sub
End Class

Function CheckNeighborPipes(prmY, prmX, prmFlagVal)
	Dim thisFlags : thisFlags = GetPipeFlags(map(prmY)(prmX))
	If (thisFlags And prmFlagVal) > 0 Then
		If Not pipe1 Is Nothing Then
			Set pipe2 = pipe1
		End If
		Set pipe1 = (New Pipe)(map, prmX, prmY, thisFlags Xor prmFlagVal, map(prmY)(prmX), 1)
	End If
End Function

Function GetOpposite(prmFlag)
	Select Case prmFlag
		Case N : GetOpposite = S
		Case E : GetOpposite = W
		Case W : GetOpposite = E
		Case S : GetOpposite = N
	End Select
End Function

Function GetPipeFlags(prmChar)
	'NEWS
	'1248
	Select Case prmChar
		Case "|"
			GetPipeFlags = N or S
		Case "-"
			GetPipeFlags = E or W
		Case "L"
			GetPipeFlags = N or E
		Case "J"
			GetPipeFlags = N or W
		Case "7"
			GetPipeFlags = W or S
		Case "F"
			GetPipeFlags = E or S
		Case "."
			GetPipeFlags = 0
		Case "S"
			GetPipeFlags = 0
	End Select
End Function


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
