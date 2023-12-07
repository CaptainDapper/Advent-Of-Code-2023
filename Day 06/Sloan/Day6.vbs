option explicit

'---------------------------------
'   "Global" Function Variables
Dim ValidSeeds

'---------------------------------

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrSections : arrSections = Split(file.readAll(),VbCrLf)

Dim i,j,x,y,lol

Dim answer1 : answer1 = 1
Dim answer2 : answer2 = 0

Dim debug : debug = true

'1:  0
'2:  0  1
'3:  0  2
'4:  0  3  4
'5:  0  4  6
'6:  0  5  8  9
'7:  0  6 10 12
'8:  0  7 12 15 16
'9:  0  8 14 18 20
'10: 0  9 16 21 24 25
'11: 0 10 18 24 28 30
'12: 0 11 20 27 32 35 36
'13: 0 12 22 30 36 40 42
'14: 0 13 24 33 40 45 48 49

Dim times : times = ArrayTrim(Split(Trim(Split(arrSections(0), ":")(1))," "))
Dim dists : dists = ArrayTrim(Split(Trim(Split(arrSections(1), ":")(1))," "))

Dim bigTime : bigTime = CCur(Replace(Trim(Split(arrSections(0), ":")(1))," ",""))
Dim bigDist : bigDist = CCur(Replace(Trim(Split(arrSections(1), ":")(1))," ",""))

For i = 0 to UBound(times)
	'DebugLine times(i) & "ms => " & dists(i) & "mm"
	Dim thisTime : thisTime = times(i)
	Dim thisDist : thisDist = dists(i)

	answer1 = TheFunc(thisTime, thisDist) * answer1
Next

DebugLine bigTime & " " & bigDist
answer2 = TheFunc(bigTime, bigDist)

WriteLine "----- Results -----"
WriteLine "Part 1: " + CStr(answer1)
WriteLine "Part 2: " + CStr(answer2)

Function TheFunc(prmTime, prmDist)
	Dim quadClose : quadClose = Ceiling(QuadraticPlus(-1, prmTime, -prmDist))
	Dim vert : vert = Ceiling(Vertex(-1, prmTime))

	TheFunc = (vert - quadClose) * 2
	If prmTime Mod 2 = 0 Then
		TheFunc = TheFunc + 1
	End If
End Function

Function QuadraticPlus(a, b, c)
	QuadraticPlus = (-b + (b^2 - CDbl(4 * a * c))^(1/2)) / (2 * a)
End Function

Function Vertex(a, b)
	Vertex = -b / (2*a)
End Function















Private Function Ceiling(ByVal thisIn)
	Dim thisOut

	If Round(thisIn)<>thisIn Then
		thisOut = Round(thisIn + 0.5)
	Else
		thisOut = thisIn
	End If

	Ceiling = thisOut
End Function

Function ArrayTrim(prmArr)
	Dim arrList : Set arrList = NewArrayList()
	Dim subI
	For subI = 0 to UBound(prmArr)
		If Trim(prmArr(subI)) <> "" Then
			arrList.Add(prmArr(subI))
		End If
	Next

	Dim retArr : ReDim retArr(arrList.Count - 1)
	For subI = 0 to arrList.Count - 1
		retArr(subI) = arrList(subI)
	Next

	ArrayTrim = retArr
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

Function NewArrayList()
	Set NewArrayList = CreateObject("System.Collections.ArrayList")
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
