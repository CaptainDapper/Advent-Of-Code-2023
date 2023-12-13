option explicit

Include "ArrayFunctions"

'---------------------------------
'   "Global" Function Variables
Dim ValidSeeds

'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
'Dim arrSections : arrSections = Split(file.readAll(),VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 0
Dim answer2 : answer2 = 0

Dim debug : debug = true
Dim rs : Set rs = InputToRecordSet(file)
Dim rank : rank = 0
rs.Sort = "Order ASC, Hand ASC"
rs.MoveFirst
Do While Not rs.EOF
	rank = rank + 1
	'WriteLine rank & ") " & rs("Hand") & " " & rs("Order") & " " & rs("Bid")

	answer1 = answer1 + (rank * rs("Bid"))

	rs.MoveNext
Loop

rank = 0
rs.Sort = "Order2 ASC, Hand2 ASC"
rs.MoveFirst
Do While Not rs.EOF
	rank = rank + 1
	WriteLine rank & ") " & rs("Hand2") & " " & rs("Order2") & " " & rs("Bid")

	answer2 = answer2 + (rank * rs("Bid"))

	rs.MoveNext
Loop



'Same Order? Check first cards, then next, etc
'DON'T check high card, which is silly because that label is called "high card" when it shouldn't be called high card if it's not checking the high card. lol

'Bid * Rank
'Rank = relative strength amongst all other hands.







WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

Function InputToRecordSet(prmFile)
	Dim arrLines : arrLines = Split(Trim(prmFile.readAll()), VbCrLf)

	Dim subRS

	Const adOpenStatic = 3

	Const adSmallInt = 2
	Const adBigInt = 20
	Const adVarChar = 200

	'Create a disconnected recordset
	Set subRS = CreateObject("ADODB.RecordSet")
	Dim subJ
	subRS.Fields.append "Hand", adVarChar, 5
	subRS.Fields.append "Hand2", adVarChar, 5
	For subJ = 1 to 5
		subRS.Fields.append "Card" & subJ, adVarChar, 1
	Next
	subRS.Fields.append "Bid", adSmallInt
	subRS.Fields.append "Order", adSmallInt
	subRS.Fields.append "Order2", adSmallInt

	subRS.CursorType = adOpenStatic
	subRS.Open
	Dim subI
	For subI = 0 to UBound(arrLines)
		If arrLines(subI) <> "" Then
			Dim subHand : subHand = Split(arrLines(subI), " ")(0)
			subHand = Replace( _
					Replace( _
						Replace( _
							Replace( _
								Replace( _
									subHand _
								,"A","E") _
							,"T","A") _
						,"J","B") _
					,"Q","C") _
				,"K","D")
			Dim subBid : subBid = Split(arrLines(subI), " ")(1)

			subRS.AddNew

			subRS("Hand") = subHand
			subRS("Hand2") = Replace(subHand,"B","1")
			For subJ = 1 to 5
				subRS("Card" & subJ) = Mid(subHand, subJ, 1)
			Next
			subRS("Bid") = subBid
			subRS("Order") = CalculateOrder(subHand)
			subRS("Order2") = CalculateOrder2(subRS("Hand2"))
			subRS.Update
		End If
	Next

	Set InputToRecordSet = subRS
End Function

Function CalculateOrder(prmHand)
	'5OAK			25
	'4OAK			17
	'FH				13
	'3OAK			11
	'2Pair			9
	'2OAK			7
	'High Card		5

	Dim subI, subJ
	Dim cardDict : Set cardDict = CreateObject("Scripting.Dictionary")
	For subI = 1 to 5
		Dim thisCard : thisCard = Mid(prmHand, subI, 1)
		If Not cardDict.Exists(thisCard) Then
			cardDict.Add thisCard, 1
		Else
			cardDict(thisCard) = cardDict(thisCard) + 1
		End If
	Next

	Dim cKey
	Dim total : total = 0
	For Each cKey in cardDict
		total = total + (cardDict(cKey)^2)
	Next

	CalculateOrder = total
End Function

Function CalculateOrder2(prmHand)
	'5OAK			25
	'4OAK			17
	'FH				13
	'3OAK			11
	'2Pair			9
	'2OAK			7
	'High Card		5

	Dim subI, subJ
	Dim cardDict : Set cardDict = CreateObject("Scripting.Dictionary")
	Dim jokerCount : jokerCount = 0
	Dim maxCount, maxCard : maxCount = -1
	For subI = 1 to 5
		Dim thisCard : thisCard = Mid(prmHand, subI, 1)
		If thisCard = "1" Then
			jokerCount = jokerCount + 1
		Else
			If Not cardDict.Exists(thisCard) Then
				cardDict.Add thisCard, 1
			Else
				cardDict(thisCard) = cardDict(thisCard) + 1
			End If
			If cardDict(thisCard) > maxCount Then
				maxCount = cardDict(thisCard)
				maxCard = thisCard
			End If
		End If
	Next

	If maxCount = -1 Then
		'All Jokers!
		cardDict.Add "1", 5
	Else
		cardDict(maxCard) = maxCount + jokerCount
	End If

	Dim cKey
	Dim total : total = 0
	For Each cKey in cardDict
		total = total + (cardDict(cKey)^2)
	Next

	CalculateOrder2 = total
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
