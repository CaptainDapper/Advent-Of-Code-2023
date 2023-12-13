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
Dim verticalExpansion : Set verticalExpansion = NewArrayList()
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
		verticalExpansion.Add y
	End If
Next

WriteLine verticalExpansion.Count

'Horizontal Expansion
Dim horizontalExpansion : Set horizontalExpansion = NewArrayList()
For x = 0 to UBound(map(0))
	noGalaxies = True
	For y = 0 to UBound(map)
		theChar = map(y)(x)
		If theChar = "#" Then
			noGalaxies = False
		End If
	Next
	If noGalaxies = True Then
		horizontalExpansion.Add x
	End If
Next
WriteLine horizontalExpansion.Count

'Insert Expansions
Dim newMap
For y = 0 to UBound(map)
	Dim newString : newString = arrSections(y)
	For i = 0 to horizontalExpansion.Count - 1
		newString = StringInsert(newString, ".", horizontalExpansion(i) + 1 + i) '+1 cuz strings are 1-indexed
	Next
	map(y) = StringToChars(newString)
	For x = 0 to UBound(map(y))
		theChar = map(y)(x)
	Next
	ArrayPush newMap, map(y)
	If verticalExpansion.Contains(y) Then
		ArrayPush newMap, StringToChars(Replace(Space(Len(newString))," ", "."))
	End If
Next

map = newMap

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

For i = 0 to UBound(galaxiesArray)-1
	Dim gal1 : gal1 = galaxiesArray(i)
	'Dim shortestDist : shortestDist = -1
	For j = i+1 to UBound(galaxiesArray)
		If i <> j Then
			Dim gal2 : gal2 = galaxiesArray(j)
			Dim xDiff : xDiff = Abs(gal2(0) - gal1(0))
			Dim yDiff : yDiff = Abs(gal2(1) - gal1(1))
			Dim dist : dist = xDiff + yDiff
			'WriteLine dist
			answer1 = answer1 + dist
		End If
	Next
Next


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
