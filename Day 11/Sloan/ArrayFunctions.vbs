Function ArrayCast_StrToCur(prmArr)
	Dim retArr : ReDim retArr(UBound(prmArr))
	Dim subI
	For subI = 0 to UBound(prmArr)
		retArr(subI) = CCur(prmArr(subI))
	Next

	ArrayCast_StrToCur = retArr
End Function

Function NewDictionary()
	Set NewDictionary = CreateObject("Scripting.Dictionary")
End Function

Function NewArrayList()
	Set NewArrayList = CreateObject("System.Collections.ArrayList")
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

Function ArraySort(prmArray)
	Dim arrList : Set arrList = CreateObject("System.Collections.ArrayList")
	Dim subI
	For subI = 0 to UBound(prmArray)
		Do
			If prmArray(subI) = "" Then
				Exit Do
			End If
			arrList.Add(prmArray(subI))
		Loop While False
	Next

	arrList.Sort()

	Dim retArr : ReDim retArr(arrList.Count - 1)
	For subI = 0 to arrList.Count - 1
		If IsObject(arrList(subI)) Then
			Set retArr(subI) = arrList(subI)
		Else
			retArr(subI) = arrList(subI)
		End If
	Next

	ArraySort = retArr
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

Private Sub ArrayMerge(ByRef prmArray1, prmArray2)
	Dim arrItem
	For Each arrItem in prmArray2
		ArrayPush prmArray1, arrItem
	Next
End Sub

Private Function ArrayReverse(prmArrayIn)
	Dim newArray, subI
	For subI = UBound(prmArrayIn) To 0 Step -1
		ArrayPush newArray, prmArrayIn(subI)
	Next

	ArrayReverse = newArray
End Function



Private Function SortObjectsByDefault(prmObjectsArr)
	Dim subObj, subSortArr
	For Each subObj in prmObjectsArr
		ArrayPush subSortArr, subObj
	Next

	SortObjectsByDefault = SortBy(prmObjectsArr, subSortArr)
End Function

Private Function SortBy(prmArray, prmIntsSortBy)
	Dim subRS

	Const adOpenStatic = 3

	Const adSmallInt = 2
	Const adBigInt = 20
	Const adVarChar = 200

	'Create a disconnected recordset
	Set subRS = CreateObject("ADODB.RecordSet")
	subRS.Fields.append "DataField", adSmallInt
	subRS.Fields.append "SortField", adBigInt

	subRS.CursorType = adOpenStatic
	subRS.Open
	Dim subI
	For subI = 0 to UBound(prmArray)
		subRS.AddNew
		subRS("DataField") = subI
		subRS("SortField") = prmIntsSortBy(subI)
		subRS.Update
	Next
	subRS.Sort = "SortField"
	subRS.MoveFirst

	Dim retArr
	Do Until subRS.EOF
		ArrayPush retArr, prmArray(subRS("DataField"))
		subRS.MoveNext
	Loop

	SortBy = retArr
End Function
