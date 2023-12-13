Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	If debug then
		WriteLine msg
	End if
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

Function StringToChars(prmString)
	Dim subI, newArr
	ReDim newArr(Len(prmString)-1)
	For subI = 1 To Len(prmString)
		newArr(subI-1) = Mid(prmString, subI, 1)
	Next

	StringToChars = newArr
End Function
