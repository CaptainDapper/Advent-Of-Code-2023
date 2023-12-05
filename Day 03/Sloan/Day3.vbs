 option explicit

Dim FSO : Set FSO = CreateObject("Scripting.FileSystemObject")
Dim file : Set file = FSO.OpenTextFile("Input.txt")
Dim arrLines : arrLines = Split(file.readAll(),VbCrLf)

Dim symbols : symbols = "#$%&*+-/=@"

Dim part2 : part2 = false
Dim debug : debug = true

Dim i,j,x,y,lol

Dim total : total = 0
Dim twotal : twotal = 0

'For i = 0 to UBound(arrLines)
'	arrLines(i) = Split(arrLines(i),"")
'Next

For i = 0 to UBound(arrLines)
	'DebugLine(" -> " + CStr(i))
	'Scan for symbols
	For j = 1 to Len(arrLines(i))
		Dim foundChar
		If ArrContains(symbols, Mid(arrLines(i),j,1), foundChar) Then
			'Found a symbol!
			'TL to BR, find a digit.
			Dim gear1, gear2
			gear1 = 0
			gear2 = 0
			For y = i-1 to i+1
				If y >= 0 and y < UBound(arrLines) Then
					Dim line : line = arrLines(y)
					For x = j-1 to j+1
						'DebugLine(line)
						If IsNumeric(Mid(line,x,1)) Then
							'Digit found!
								'Extract all connected digits L2R
							Dim firstDigit : firstDigit = NonDigitRev(line, x) + 1
							Dim lastDigit : lastDigit = NonDigit(x, line) - 1
							'DebugLine(firstDigit)
							'DebugLine(lastDigit)
							Dim number : number = Mid(line, firstDigit, (lastDigit - firstDigit + 1))

							'DebugLine(number)

							total = total + number

							If foundChar = "*" Then
								If gear1 <> 0 Then
									DebugLine("Uhm?")
								End If
								gear1 = gear2
								gear2 = number
								twotal = twotal + gear1 * gear2
							End If

								'Replace extracted digits with '.' in modified lines- that way we don't double count a digit.
							line = Left(line, firstDigit - 1)
							For lol = firstDigit to lastDigit
								line = line + "."
							Next
							line = line + Right(arrLines(y), Len(arrLines(y)) - lastDigit)
						End If
					Next
				End If
			Next
		End If
	Next
Next

WriteLine "----------"
WriteLine total
WriteLine twotal

Function NonDigit(prmStart, prmString)
	Dim subI
	For subI = prmStart to Len(prmString)
		If Not IsNumeric(Mid(prmString, subI, 1)) Then
			NonDigit = subI : Exit Function
		End If
	Next
	NonDigit = Len(prmString) + 1
End Function

Function NonDigitRev(prmString, prmStart)
	Dim subI : subI = prmStart
	For subI = prmStart to 1 Step -1
		If Not IsNumeric(Mid(prmString, subI, 1)) Then
			NonDigitRev = subI : Exit Function
		End If
	Next
	NonDigitRev = 0
End Function

Function ArrContains(prmSymbols, prmCharacter, ByRef outFoundChar)
	Dim subI
	For subI = 1 to Len(prmSymbols)
		Dim subSym : subSym = Mid(prmSymbols, subI, 1)
		'DebugLine(subSym + " " + prmCharacter + " | " + CStr((subSym = prmCharacter)))
		If subSym = prmCharacter Then
			outFoundChar = subSym
			ArrContains = True : Exit Function
		End If
	Next

	outFoundChar = ""
	ArrContains = False : Exit Function
End Function







Sub WriteLine(msg)
	WScript.Echo msg
End Sub

Sub DebugLine(msg)
	if debug then
		WriteLine msg
	end if
End Sub

