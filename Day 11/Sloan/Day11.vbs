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

Dim map
For i = 0 To UBound(arrSections)
	If arrSections(i) <> "" Then
		ArrayPush map, StringToChars(arrSections(i))
	End If
Next

'Vertical Expansion
Dim verticalExpansion : Set verticalExpansion = NewDictionary()
Dim theChar
Dim noGalaxies
For y = 0 to UBound(map)
	noGalaxies = True
	For x = 0 to UBound(map(y))
		theChar = map(y)(x)
		If theChar = "#" Then
			noGalaxies = False
		End If
	Next
	If noGalaxies = True Then
		verticalExpansion.Add y, ""
	End If
Next

'Horizontal Expansion
Dim horizontalExpansion : Set horizontalExpansion = NewDictionary()
For x = 0 to UBound(map(0))
	noGalaxies = True
	For y = 0 to UBound(map)
		theChar = map(y)(x)
		If theChar = "#" Then
			noGalaxies = False
		End If
	Next
	If noGalaxies = True Then
		horizontalExpansion.Add x, ""
	End If
Next

Dim galaxiesArray
For y = 0 to UBound(map)
	Dim galaxyLineString : galaxyLineString = ""
	For x = 0 to UBound(map(y))
		theChar = map(y)(x)
		If theChar = "#" Then
			ArrayPush galaxiesArray, Array(x, y)
			galaxyLineString = galaxyLineString & "#"
		Else
			galaxyLineString = galaxyLineString & "."
		End If
	Next
	WriteLine galaxyLineString
Next

WriteLine UBound(galaxiesArray)
WriteLine verticalExpansion.Count
WriteLine horizontalExpansion.Count

Dim count : count = 0
For i = 0 to UBound(galaxiesArray)-1
	Dim gal1 : gal1 = galaxiesArray(i)
	'Dim shortestDist : shortestDist = -1
	For j = i+1 to UBound(galaxiesArray)
		If i <> j Then
			count = count + 1
			'WriteLine count
			Dim gal2 : gal2 = galaxiesArray(j)
			Dim xDiff : xDiff = Abs(gal2(0) - gal1(0))
			Dim yDiff : yDiff = Abs(gal2(1) - gal1(1))
			Dim dist : dist = GetDist(gal1, gal2, horizontalExpansion, verticalExpansion, 1)
			Dim dist2 : dist2 = GetDist(gal1, gal2, horizontalExpansion, verticalExpansion, 999999)
			'WriteLine dist
			answer1 = answer1 + dist
			answer2 = answer2 + dist2
		End If
	Next
	WriteLine count
Next


'----------------------------------------------------------------------

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)
' ----- Results -----
' Part 1: 9684228
' Part 2: 483844716556

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

Function GetDist(prmGal1, prmGal2, prmHorizontalExpansions, prmVerticalExpansions, prmExpansionValue)
	Dim subStep

	Dim subDist : subDist = Abs(prmGal1(0) - prmGal2(0)) + Abs(prmGal1(1) - prmGal2(1))
	Dim subI
	subStep = 1
	If prmGal1(0) > prmGal2(0) Then
		subStep = -1
	End If
	For subI = prmGal1(0) to prmGal2(0) Step subStep
		If prmHorizontalExpansions.Exists(subI) Then
			subDist = subDist + prmExpansionValue
		End If
	Next
	subStep = 1
	If prmGal1(1) > prmGal2(1) Then
		subStep = -1
	End If
	For subI = prmGal1(1) to prmGal2(1) Step subStep
		If prmVerticalExpansions.Exists(subI) Then
			subDist = subDist + prmExpansionValue
		End If
	Next
	GetDist = subDist
End Function
