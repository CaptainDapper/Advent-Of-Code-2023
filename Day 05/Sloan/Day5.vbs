option explicit

Include "ArrayFunctions"
Include "MapClass"

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







Dim seedRangeButOneThoughs : seedRangeButOneThoughs = SortObjectsByDefault(RangeStrToObjectsButOneThough(Trim(Split(arrSections(0),":")(1))))
Dim seedRanges : seedRanges = SortObjectsByDefault(RangeStrToObjects(Trim(Split(arrSections(0),":")(1))))

Dim seedsToSoils : Set seedsToSoils = MapStrToObject(Trim(Split(arrSections(1),":")(1)))
Dim soilsToFerts : Set soilsToFerts = MapStrToObject(Trim(Split(arrSections(2),":")(1)))
Dim fertsToAguas : Set fertsToAguas = MapStrToObject(Trim(Split(arrSections(3),":")(1)))
Dim aguasToLites : Set aguasToLites = MapStrToObject(Trim(Split(arrSections(4),":")(1)))
Dim litesToTemps : Set litesToTemps = MapStrToObject(Trim(Split(arrSections(5),":")(1)))
Dim tempsToDamps : Set tempsToDamps = MapStrToObject(Trim(Split(arrSections(6),":")(1)))
Dim dampsToAreas : Set dampsToAreas = MapStrToObject(Trim(Split(arrSections(7),":")(1)))

Dim maps : maps = Array(seedsToSoils, soilsToFerts, fertsToAguas, aguasToLites, litesToTemps, tempsToDamps, dampsToAreas)
Dim mapsBackwards : mapsBackwards = Array(dampsToAreas, tempsToDamps, litesToTemps, aguasToLites, fertsToAguas, soilsToFerts, seedsToSoils)

answer1 = GetMinAreaForSeeds(seedRangeButOneThoughs, maps)
answer2 = GetMinAreaForSeeds(seedRanges, maps)
'answer2 = GetMinAreaForSeedRanges(seedsUnsorted)
'answer2 = GetMinSeedForArea(dampToArea)

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1) 'Original Answer: 579439039
WriteLine "Part 2: " + CStr(answer2) 'Original Answer: 7873084



Function GetMinAreaForSeeds(prmSeedRanges, prmMaps)
	Dim minSeed, minArea
	minArea = -1

	Dim nextRange
	For Each nextRange in prmSeedRanges
		Dim nextMap, seedRanges
		seedRanges = Array(nextRange)
		For Each nextMap in prmMaps
			Dim newSeedRanges, seedRange
			newSeedRanges = Array()
			'Get all the previous ranges
			For Each seedRange in seedRanges
				'Get all the new ranges in the next map for each previous range
				Dim tempSeedRanges : tempSeedRanges = nextMap.ConvertRangeToDest(seedRange)
				'Push them into the new blank array
				ArrayMerge newSeedRanges, tempSeedRanges
			Next
			'Set the next previous ranges
			seedRanges = newSeedRanges
		Next
		'Find the lowest of these new ranges
		Dim lowestNewRange
		seedRanges = SortObjectsByDefault(seedRanges)
		Set lowestNewRange = seedRanges(0)

		'Compare that to the minArea
		If minArea = -1 Or lowestNewRange.First < minArea Then
			minArea = lowestNewRange.First
			minSeed = nextRange.First
		End If
	Next

	GetMinAreaForSeeds = minArea
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
