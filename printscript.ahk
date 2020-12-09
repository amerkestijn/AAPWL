#Persistent

Loop
{
	; Does "a" PDF file exist in the folder?
	if FileExist("goto\folder\*.pdf")
	{
		; Loop it for every PDF in the dir
		Loop Files, goto\folder\*.pdf
		{
			; Send the file through PDFtoPrinter.exe, use as follows: PDFtoPrinter.exe FileToPrint PrinterName
			RunWait, goto\folder\PDFtoPrinter.exe goto\folder\pdf\%A_LoopFileName% "Printer name"
			Sleep, 2000
      ; Randomizer to add the outcome to the start of the file.
			Random, n, 1000, 9000
			if (n >= 5000)
			n := n + 1052
			FileMove, goto\folder\pdf\%A_LoopFileName%, goto\folder\printed\%n%-%A_LoopFileName%
			Sleep, 2500
		}
	}
	else
	{
		; If no PDF file is found. Sleep for 2.5 seconds
		Sleep, 2500
	}
}
