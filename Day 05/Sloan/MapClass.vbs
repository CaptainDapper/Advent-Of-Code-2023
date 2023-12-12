Class Range
	private mOffset
	private mLength

	Public Property Get Offset()
		Offset = mOffset
	End Property

	Public Property Get Length()
		Length = mLength
	End Property

	Public Default Property Get First()
		First = mOffset
	End Property

	Public Property Get Last()
		Last = mOffset + mLength - 1
	End Property

	Public Sub Initialize(prmOffset, prmLength)
		mOffset = CCur(prmOffset)
		mLength = CCur(prmLength)
	End Sub
End Class

Class MapItem
	private mSourceRange
	private mDestRange

	Public Property Get DestOffset()
		DestOffset = mDestRange.Offset
	End Property

	Public Default Property Get SourceOffset()
		SourceOffset = mSourceRange.Offset
	End Property

	Public Property Get Length()
		Length = mSourceRange.Offset
	End Property

	Public Property Get Source()
		Set Source = mSourceRange
	End Property

	Public Property Get Dest()
		Set Dest = mDestRange
	End Property

	Public Sub Initialize(prmDestOffset, prmSourceOffset, prmLength)
		Set mDestRange = new Range
		mDestRange.Initialize prmDestOffset, prmLength

		Set mSourceRange = new Range
		mSourceRange.Initialize prmSourceOffset, prmLength
	End Sub
End Class

Class Map
	private mItems

	Public Sub Initialize(prmItems)
		Dim newItems
		mItems = SortObjectsByDefault(prmItems)

		'Fill gaps
		Dim subI, subItem, subPrevItem
		For subI = 1 To UBound(mItems)
			Set subPrevItem = mItems(subI - 1)
			Set subItem = mItems(subI)
			If subPrevItem.Source.Last + 1 < subItem.Source.First Then
				Dim newMapItem : Set newMapItem = new MapItem
				Call newMapItem.Initialize(subPrevItem.Source.Last + 1, subPrevItem.Source.Last + 1, subItem.Source.First - subPrevItem.Source.Last)
				ArrayPush newItems, newMapItem
			End If
		Next

		'Add final entry, for overspill
		Set newMapItem = new MapItem
		Call newMapItem.Initialize(mItems(UBound(mItems)).Source.Last + 1, mItems(UBound(mItems)).Source.Last + 1, 5999999999 - mItems(UBound(mItems)).Source.Last)
		ArrayPush newItems, newMapItem

		Dim newItem
		For Each newItem in newItems
			ArrayPush mItems, newItem
		Next

		mItems = SortObjectsByDefault(mItems)
	End Sub

	Public Function ConvertRangeToSource(prmDestRange)
		Dim newRanges : newRanges = Array()
		Dim mapItem
		For Each mapItem in mItems
			Dim overlap : Set overlap = GetOverlappingRange(mapItem.Dest, prmDestRange, mapItem.Source)
			If Not overlap Is Nothing Then
				Call ArrayPush(newRanges, overlap)
			End If
		Next

		ConvertRangeToSource = newRanges
	End Function

	Public Function ConvertRangeToDest(prmSourceRange)
		Dim newRanges : newRanges = Array()
		Dim mapItem
		For Each mapItem in mItems
			Dim overlap : Set overlap = GetOverlappingRange(mapItem.Source, prmSourceRange, mapItem.Dest)
			If Not overlap Is Nothing Then
				Call ArrayPush(newRanges, overlap)
			End If
		Next

		ConvertRangeToDest = newRanges
	End Function

	Public Function GetOverlappingRange(prmRange1, prmRange2, prmNewRange)
		'WriteLine "    " & prmRange1.First & ">" & prmRange2.Last & " | " & prmRange1.Last & "<" & prmRange2.First
		If prmRange1.First > prmRange2.Last or prmRange1.Last < prmRange2.First Then
			'No overlap at all. Move along
			Set GetOverlappingRange = Nothing
			Exit Function 'Continue
		End If

		Dim newFirst : newFirst = Max(prmRange1.First, prmRange2.First)
		Dim newOffset : newOffset = newFirst - prmRange1.First + prmNewRange.First
		Dim newLast : newLast = Min(prmRange1.Last, prmRange2.Last)
		Dim newLength : newLength = newLast - newFirst + 1
		
		Dim newRange : Set newRange = New Range
		Call newRange.Initialize(newOffset, newLength)
		'WriteLine "    Found! " & newOffset & " " & newLength
		Set GetOverlappingRange = newRange
	End Function
End Class

Function RangeStrToObjectsButOneThough(prmString)
	Dim splt : splt = Split(prmString," ")
	Dim subI, rangeArr
	For subI = 0 to UBound(splt)
		Dim subRange : Set subRange = new Range
		'WriteLine splt(subI + 1)
		Call subRange.Initialize(splt(subI), 1)

		ArrayPush rangeArr, subRange
	Next

	RangeStrToObjectsButOneThough = rangeArr
End Function

Function RangeStrToObjects(prmString)
	Dim splt : splt = Split(prmString," ")
	Dim subI, rangeArr
	For subI = 0 to UBound(splt) Step 2
		Dim subRange : Set subRange = new Range
		'WriteLine splt(subI + 1)
		Call subRange.Initialize(splt(subI), splt(subI + 1))

		ArrayPush rangeArr, subRange
	Next

	RangeStrToObjects = rangeArr
End Function

Function MapStrToObject(prmString)
	Dim subLines : subLines = Split(Trim(prmString),VbCrLf)
	Dim subI, mapItemArr
	For subI = 0 to UBound(subLines)
		'WriteLine "|" & subLines(subI) & "|"
		If subLines(subI) <> "" Then
			Dim splt : splt = Split(subLines(subI)," ")
			Dim subMapItem : Set subMapItem = new MapItem
			Call subMapItem.Initialize(splt(0), splt(1), splt(2))

			ArrayPush mapItemArr, subMapItem
		End If
	Next

	Dim subMap : Set subMap = new Map
	subMap.Initialize(mapItemArr)

	Set MapStrToObject = subMap
End Function
