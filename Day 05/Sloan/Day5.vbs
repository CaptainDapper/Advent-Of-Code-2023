option explicit

'---------------------------------
'   "Global" Function Variables
Dim ValidSeeds

'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrSections : arrSections = Split(file.readAll(),VbCrLf & VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true

Dim seeds : seeds = ArrayCast_StrToCur(ArraySort_Str(Split(Split(arrSections(0),":")(1)," ")))
Dim seedsNoSort : seedsNoSort = ArrayCast_StrToCur(ArrayNoSort(Split(Split(arrSections(0),":")(1)," ")))
Call BuildValidSeeds(seedsNoSort)
Dim seedToSoil : seedToSoil = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(1),":")(1),VbCrLf))))
Dim soilToFert : soilToFert = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(2),":")(1),VbCrLf))))
Dim fertToAgua : fertToAgua = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(3),":")(1),VbCrLf))))
Dim aguaToLite : aguaToLite = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(4),":")(1),VbCrLf))))
Dim liteToTemp : liteToTemp = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(5),":")(1),VbCrLf))))
Dim tempToDamp : tempToDamp = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(6),":")(1),VbCrLf))))
Dim dampToArea : dampToArea = FillEmptyTiers(MapStrToCur(ArraySort_Str(Split(Split(arrSections(7),":")(1),VbCrLf))))

answer1 = GetMinAreaForSeeds(seeds)
'answer2 = GetMinAreaForSeedRanges(seedsUnsorted)
answer2 = GetMinSeedForArea(dampToArea)

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

Function GetMinSeedForArea(prmDampToAreaMap)
	Dim subI
	For subI = 7777777 to 7873091
		If subI Mod 100000 = 0 Then
			DebugLine subI
		End If
		Dim seedNum : seedNum = FromAreaToSeed(subI)
		If IsValidSeed(seedNum) Then
			DebugLine "ZOPMGGGS!!!!!! FINALLLYYYY"
			DebugLine seedNum & " => " & subI
			GetMinSeedForArea = subI
			Exit Function
		End If
	Next
End Function

Sub BuildValidSeeds(prmSeeds)
	Dim subI
	For subI = 0 to UBound(prmSeeds) Step 2
		ArrayPush ValidSeeds, prmSeeds(subI)
		ArrayPush ValidSeeds, prmSeeds(subI) + prmSeeds(subI + 1)
		'DebugLine prmSeeds(subI) & " ~ " & prmSeeds(subI) + prmSeeds(subI + 1)
	Next
End Sub

Function IsValidSeed(prmSeed)
	Dim subI
	For subI = 0 to UBound(ValidSeeds) Step 2
		'DebugLine ValidSeeds(subI) & " " & prmSeed & " " & ValidSeeds(subI+1)
		If prmSeed >= ValidSeeds(subI) and prmSeed < ValidSeeds(subI + 1) Then
			IsValidSeed = True
			Exit Function
		End If
	Next
	IsValidSeed = False
	Exit Function
End Function

Function FindInputForMap(prmMap, prmValue)
	Dim subI
	For subI = 0 to UBound(prmMap)
		If prmValue >= prmMap(subI)(0) and prmValue < (prmMap(subI)(0) + prmMap(subI)(2)) Then
			'Yep here it is
			Dim offset : offset = prmValue - prmMap(subI)(0)
			FindInputForMap = prmMap(subI)(1) + offset
			Exit Function
		End If
	Next
	'Dang we didn't find anything. Oh well?
	'DebugLine "HA! Groundsick Highlander"
	'DebugLine prmMap(0)(1)
	'DebugLine prmValue
	FindInputForMap = prmValue
End Function

Function FromAreaToSeed(prmArea)
	Dim damp : damp = FindInputForMap(dampToArea, prmArea)
	Dim temp : temp = FindInputForMap(tempToDamp, damp)
	Dim lite : lite = FindInputForMap(liteToTemp, temp)
	Dim agua : agua = FindInputForMap(aguaToLite, lite)
	Dim fert : fert = FindInputForMap(fertToAgua, agua)
	Dim soil : soil = FindInputForMap(soilToFert, fert)
	Dim seed : seed = FindInputForMap(seedToSoil, soil)

	'DebugLine prmArea & " " & damp & " " & temp & " " & lite & " " & agua & " " & fert & " " & soil & " " & seed

	FromAreaToSeed = seed
End Function





Function GetMinAreaForSeedRanges(prmSeeds)
	Dim subI
	Dim minArea : minArea = -1
	For subI = 0 to UBound(prmSeeds) Step 2
		Dim soilRanges : soilRanges = ConvertRanges(Array(prmSeeds(subI), prmSeeds(subI+1)), seedToSoil)
		Dim fertRanges : fertRanges = ConvertRanges(soilRanges, soilToFert)
		Dim aguaRanges : aguaRanges = ConvertRanges(fertRanges, fertToAgua)
		Dim liteRanges : liteRanges = ConvertRanges(aguaRanges, aguaToLite)
		Dim tempRanges : tempRanges = ConvertRanges(liteRanges, liteToTemp)
		Dim dampRanges : dampRanges = ConvertRanges(tempRanges, tempToDamp)
		Dim areaRanges : areaRanges = ConvertRanges(dampRanges, dampToArea)

		Dim subJ
		For subJ = 0 to UBound(areaRanges) Step 2
			If minArea = -1 or areaRanges(subJ) < minArea Then
				minArea = areaRanges(subJ)
			End If
		Next
	Next

	GetMinAreaForSeedRanges = minArea
End Function

Function ConvertRanges(oldRangeArray, prmNewMap)
	DebugLine "-------------------------"

	Dim newRanges
	Dim subI
	For subI = 0 to UBound(oldRangeArray) Step 2
		Dim curInd : curInd = oldRangeArray(subI)
		Dim curRng : curRng = oldRangeArray(subI+1)
		DebugLine curInd & " " & curRng
		Do While curInd < oldRangeArray(subI) + curRng
			Dim newNextIndex : newNextIndex = GetNextIndexInMap(prmNewMap, curInd)
			ArrayPush newRanges, newNextIndex
			ArrayPush newRanges, newNextIndex - curInd

			DebugLine curInd & " < " & oldRangeArray(subI) + curRng
			curInd = newNextIndex
		Loop

		Dim subJ
		For subJ = 0 to UBound(newRanges)
			'DebugLine "     |" & newRanges(subJ) & "|"
		Next
	Next

	ConvertRanges = newRanges
End Function

Function GetNextIndexInMap(prmMap, prmStartExclusive)
	Dim arrList : Set arrList = GetSortedSourceIndexList(prmMap)
	Dim nextIndexStart : nextIndexStart = prmStartExclusive
	Dim subI
	For subI = 0 to arrList.Count - 1
		Do
			If CCur(arrList(subI)) <= nextIndexStart Then
				Exit Do 'Continue
			End If
			'DebugLine(arrList(subI))
			GetNextIndexInMap = CCur(arrList(subI))
			Exit Function
		Loop While False
	Next
End Function

Function GetSortedSourceIndexList(prmMap)
	Dim arrList : Set arrList = CreateObject("System.Collections.ArrayList")
	Dim subI
	For subI = 0 to UBound(prmMap)
		Call arrList.Add(prmMap(subI)(1))
	Next

	arrList.Sort()

	Set GetSortedSourceIndexList = arrList
End Function

Function MapStrToCur(ByRef inArr)
	Dim subI
	For subI = 0 to UBound(inArr)
		inArr(subI) = ArrayCast_StrToCur(Split(inArr(subI), " "))
	Next
	MapStrToCur = inArr
End Function

Function FillEmptyTiers(ByRef prmMap)
	DebugLine UBound(prmMap)

	Dim arrList : Set arrList = GetSortedSourceIndexList(prmMap)
	Dim subI
	For subI = 0 to arrList.Count - 1
		Dim curIndex : curIndex = CCur(arrList(subI))
		Dim curMapItem : curMapItem = GetMapByIndex(prmMap, curIndex)
		Dim potentialIndex : potentialIndex = curMapItem(1) + curMapItem(2)
		Dim potentialNextMap : potentialNextMap = GetMapByIndex(prmMap, potentialIndex)
		If subI = arrList.Count - 1 Then
			Exit For
		End If
		Dim nextIndex : nextIndex = CCur(arrList(subI + 1))
		If IsNull(potentialNextMap) Then
			ReDim Preserve prmMap(UBound(prmMap) + 1)
			prmMap(UBound(prmMap)) = Array(potentialIndex, potentialIndex, nextIndex - potentialIndex)
			'DebugLine "Filled a Gap"
		End If
	Next

	'DebugLine potentialIndex & "|"
	ReDim Preserve prmMap(UBound(prmMap) + 1)
	prmMap(UBound(prmMap)) = Array(potentialIndex, potentialIndex, 9999999999)


	DebugLine UBound(prmMap)
	DebugLine("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	FillEmptyTiers = prmMap
End Function

Function GetMapByIndex(prmMap, prmIndex)
	Dim subI
	For subI = 0 to UBound(prmMap)
		If prmMap(subI)(1) = prmIndex Then
			GetMapByIndex = prmMap(subI)
			Exit Function
		End If
	Next
	GetMapByIndex = null
End Function

Function TryGetMapByIndex(prmMap, prmIndex, ByRef outMapItem)
	TryGetMapByIndex = False

	Dim subI
	For subI = 0 to UBound(prmMap)
		If prmMap(subI)(1) = prmIndex Then
			TryGetMapByIndex = True
			outMapItem = prmMap(subI)
			Exit Function
		End If
	Next
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
	DebugLine prmMap(0)(0)
	DebugLine prmValue
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

Function GetMinAreaForSeeds(prmSeeds)
	Dim minSeed, minArea, subI
	minArea = -1
	For subI = 0 to UBound(prmSeeds)
		Dim theSeed : theSeed = prmSeeds(subI)
		Dim theArea : theArea = FromSeedToArea(theSeed)
		If minArea = -1 or theArea < minArea Then
			minSeed = theSeed
			minArea = theArea
		End If
	Next
	GetMinAreaForSeeds = minArea
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

Function ArrayListToArray(prmArrayList)
	Dim newArray : ReDim newArray(prmArrayList.Count - 1)
	Dim subI
	For subI = 0 to prmArrayList.Count - 1
		newArray(subI) = prmArrayList(subI)
	Next
	ArrayListToArray = newArray
End Function

Function ArraySort_Str(prmArray)
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

	ArraySort_Str = retArr
End Function

Function ArraySort_Cur(prmArray)
	Dim arrList : Set arrList = CreateObject("System.Collections.ArrayList")
	Dim subI
	For subI = 0 to UBound(prmArray)
		Do
			If prmArray(subI) = "" Then
				Exit Do
			End If
			arrList.Add(CCur(prmArray(subI)))
		Loop While False
	Next

	arrList.Sort()

	Dim retArr : ReDim retArr(arrList.Count - 1)
	For subI = 0 to arrList.Count - 1
		retArr(subI) = CCur(arrList(subI))
	Next

	ArraySort_Cur = retArr
End Function

Function ArrayNoSort(prmArray)
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

	Dim retArr : ReDim retArr(arrList.Count - 1)
	For subI = 0 to arrList.Count - 1
		retArr(subI) = CStr(arrList(subI))
	Next

	ArrayNoSort = retArr
End Function

Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	If debug then
		WriteLine msg
	End if
End Sub

Private Sub ArrayPush(ByRef thisArray, ByRef thisItem)
	'Adds a value to the end of the Array.
	'Equivalent to PHP array_push()
	If TypeName(thisArray)="Empty" then
		Redim thisArray(0)
	End if

	If UBound(thisArray) = -1 Then
		Redim thisArray(0)
	End If

	if TypeName(thisArray(0))<>"Empty" then
		ReDim Preserve thisArray(UBound(thisArray)+1)
	End if

	if IsObject(thisItem) then
		set thisArray(UBound(thisArray)) = thisItem
	else
		thisArray(UBound(thisArray)) = thisItem
	end if
End Sub
