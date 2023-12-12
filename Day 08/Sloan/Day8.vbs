option explicit

Include "ArrayFunctions"

'---------------------------------
'   "Global" Function Variables
Dim ValidSeeds

'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrSections : arrSections = Split(file.readAll(), VbCrLf & VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true


Dim directions : directions = arrSections(0)
Dim nodeMap : Set nodeMap = (new NodeMapObj)(arrSections(1))
Dim currentNode
Do
	Set currentNode = nodeMap.FollowDirections(directions)
Loop While currentNode.Name <> "ZZZ"

answer1 = nodeMap.Steps

Dim ghostMap, ghostMaps, nodeKey
For Each nodeKey in nodeMap.DKeys
	If Right(nodeKey,1) = "A" Then
		Set ghostMap = New NodeMapObj
		ArrayPush ghostMaps, ghostMap.GhostyBoyz(nodeMap, nodeKey)
	End If
Next
WriteLine UBound(ghostMaps)
WScript.Sleep(200)

If False Then
	'BRUTE FORCE IT, BOBBY
	Do
		Dim allZeds : allZeds = True
		Dim zedCount : zedCount = 0
		For Each ghostMap in ghostMaps
			Dim oldNode : Set oldNode = ghostMap.CurrentNode
			Set currentNode = ghostMap.FollowDirections(directions)
			If Right(currentNode.Name,1) <> "Z" Then
				allZeds = False
			Else
				zedCount = zedCount + 1
			End If

			'WriteLine oldNode.Name  & " => " & currentNode.Name
		Next

		If zedCount > 0 Then
			WriteLine zedCount
		End If

		'WScript.Sleep(500)

		If ghostMaps(0).Steps Mod 500 = 0 Then
			WriteLine ghostMaps(0).Steps
		End If
	Loop While allZeds = False

	answer2 = ghostMaps(0).Steps
Else
	'LCD Method
	Dim allSteps
	For Each ghostMap in ghostMaps
		Do
			Set currentNode = ghostMap.FollowDirections(directions)
		Loop While Right(currentNode.Name, 1) <> "Z"
		ArrayPush allSteps, CCur(ghostMap.Steps)
	Next

	Dim theStep, currentLCD
	currentLCD = 0
	For Each theStep in allSteps
		If currentLCD = 0 Then
			currentLCD = CCur(theStep)
		Else
			currentLCD = LowestDenom(CCur(currentLCD), CCur(theStep))
		End If
	Next
End If

answer2 = currentLCD








WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

Public Function LowestDenom(i1, i2)
	Dim iTemp
	If i2 > i1 Then
		'make sure i1 is the highest number
		iTemp = i1
		i1 = i2
		i2 = iTemp
	End If
	iTemp = 1
	Do While PowerMod(i1 * iTemp, i2) <> 0
		iTemp = iTemp + 1
	Loop
	LowestDenom = i1 * iTemp
End Function

Public Function PowerMod(i1, i2)
	Dim psCommand, cmd, shell, rv, executor
	psCommand = i1 & "%" & i2
	cmd = "powershell.exe -noprofile -command " & psCommand
	Set shell = CreateObject("WScript.Shell")
	Set executor = shell.Exec(cmd)
	executor.StdIn.Close
	PowerMod = CCur(executor.StdOut.ReadAll)
	WriteLine psCommand & " " & PowerMod
End Function

Class NodeMapObj
	Private mDict
	Private mCurrentNode
	Private mCurrentStep

	Public Property Get CurrentNode()
		Set CurrentNode = mCurrentNode
	End Property

	Public Property Get Steps()
		Steps = mCurrentStep
	End Property

	Public Property Get DKeys()
		DKeys = mDict.Keys
	End Property

	Public Property Get Dictionary()
		Set Dictionary = mDict
	End Property

	Public Default Function Initialize(prmStr)
		Set mDict = CreateObject("Scripting.Dictionary")
		Dim nodesArr : nodesArr = Split(prmStr, VbCrLf)
		Dim nodeStr

		For Each nodeStr in nodesArr
			If nodeStr <> "" Then
				mDict.Add Left(nodeStr,3), (new NodeObj)(Left(nodeStr,3), Mid(nodeStr, 8, 3), Mid(nodeStr, 13, 3))
			End If
		Next

		Dim nodeKey
		For Each nodeKey in mDict.Keys
			Call mDict(nodeKey).SecondPass(mDict)
		Next

		Set mCurrentNode = mDict("AAA")
		mCurrentStep = 0

		Set Initialize = Me
	End Function

	Public Function GhostyBoyz(prmNodeMap, prmNodeKey)
		Set mDict = prmNodeMap.Dictionary
		Set mCurrentNode = mDict(prmNodeKey)
		mCurrentStep = 0

		Set GhostyBoyz = Me
	End Function

	Public Function FollowDirections(prmDirections)
		mCurrentStep = mCurrentStep + 1
		Dim curStep : curStep = mCurrentStep mod Len(prmDirections)
		If curStep = 0 Then
			curStep = Len(prmDirections)
		End If

		If Mid(prmDirections, curStep, 1) = "L" Then
			Set mCurrentNode = mCurrentNode.GoLeft()
		Else
			Set mCurrentNode = mCurrentNode.GoRight()
		End If

		Set FollowDirections = mCurrentNode
	End Function
End Class

Class NodeObj
	Private mNodeName

	Private mLeftStr
	Private mRightStr

	Private mLeftNode
	Private mRightNode

	Public Property Get Name()
		Name = mNodeName
	End Property

	Public Function GoLeft()
		Set GoLeft = mLeftNode
	End Function

	Public Function GoRight()
		Set GoRight = mRightNode
	End Function

	Public Default Function Initialize(prmNodeName, prmLeftStr, prmRightStr)
		mNodeName = prmNodeName
		mLeftStr = prmLeftStr
		mRightStr = prmRightStr

		Set Initialize = Me
	End Function

	Public Sub SecondPass(prmDict)
		Set mLeftNode = prmDict(mLeftStr)
		Set mRightNode = prmDict(mRightStr)
	End Sub
End Class












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
