option explicit

'---------------------------------
'   "Global" Function Variables


'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrSections : arrSections = Split(file.readAll(),VbCrLf & VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true

Dim seeds : seeds = ArrayCast_StrToCur(ArraySort(Split(Split(arrSections(0),":")(1)," ")))
Dim seedToSoil : seedToSoil = MakeList(ArraySort(Split(Split(arrSections(1),":")(1),VbCrLf)))
Dim soilToFert : soilToFert = MakeList(ArraySort(Split(Split(arrSections(2),":")(1),VbCrLf)))
Dim fertToAgua : fertToAgua = MakeList(ArraySort(Split(Split(arrSections(3),":")(1),VbCrLf)))
Dim aguaToLite : aguaToLite = MakeList(ArraySort(Split(Split(arrSections(4),":")(1),VbCrLf)))
Dim liteToTemp : liteToTemp = MakeList(ArraySort(Split(Split(arrSections(5),":")(1),VbCrLf)))
Dim tempToDamp : tempToDamp = MakeList(ArraySort(Split(Split(arrSections(6),":")(1),VbCrLf)))
Dim dampToArea : dampToArea = MakeList(ArraySort(Split(Split(arrSections(7),":")(1),VbCrLf)))

Dim minSeed, minArea
minArea = -1
For i = 0 to UBound(seeds)
	Dim theSeed : theSeed = seeds(i)
	Dim theArea : theArea = FromSeedToArea(theSeed)
	If minArea = -1 or theArea < minArea Then
		minSeed = theSeed
		minArea = theArea
	End If
Next

answer1 = minArea

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

Function MakeList(ByRef inArr)
	Dim subI
	For subI = 0 to UBound(inArr)
		inArr(subI) = ArrayCast_StrToCur(Split(inArr(subI), " "))
	Next
	MakeList = inArr
End Function

Function FindOutputForMap(prmMap, prmValue)
	Dim subI
	For subI = 0 to UBound(prmMap)
		If prmValue > prmMap(subI)(1) and prmValue < (prmMap(subI)(1) + prmMap(subI)(2)) Then
			'Yep here it is
			Dim offset : offset = prmValue - prmMap(subI)(1)
			FindOutputForMap = prmMap(subI)(0) + offset
			Exit Function
		End If
	Next
	'Dang we didn't find anything. Oh well?
	DebugLine "HA! Airsick Lowlander"
	FindOutputForMap = prmValue
End Function

Function FromSeedToArea(prmSeed)
	Dim soil : soil = FindOutputForMap(seedToSoil, prmSeed)
	Dim fert : fert = FindOutputForMap(soilToFert, soil)
	Dim agua : agua = FindOutputForMap(fertToAgua, fert)
	Dim lite : lite = FindOutputForMap(aguaToLite, agua)
	Dim temp : temp = FindOutputForMap(liteToTemp, lite)
	Dim damp : damp = FindOutputForMap(tempToDamp, temp)
	Dim area : area = FindOutputForMap(dampToArea, damp)

	DebugLine prmSeed & " " & soil & " " & fert & " " & agua & " " & lite & " " & temp & " " & damp & " " & area

	FromSeedToArea = area
End Function











Function ArrayCast_StrToCur(prmArr)
	Dim retArr : ReDim retArr(UBound(prmArr))
	Dim subI
	For subI = 0 to UBound(prmArr)
		retArr(subI) = CCur(prmArr(subI))
	Next

	ArrayCast_StrToCur = retArr
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
			arrList.Add(CStr(prmArray(subI)))
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
	If debug then
		WriteLine msg
	End if
End Sub

