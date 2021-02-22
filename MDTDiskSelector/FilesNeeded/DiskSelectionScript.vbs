Option Explicit
Sub Window_Onload
    window.resizeTo 640,480
End Sub
Sub Run_PS_Script()
    ExampleOutput.value = ""
    btnClick.disabled = True
    document.body.style.cursor = "wait"
    btnClick.style.cursor = "wait"
    Dim WshShell, Command, PSFile,return, fso, file, text, Temp
    Set WshShell = CreateObject("WScript.Shell")
    Temp = WshShell.ExpandEnvironmentStrings("X:\Windows\Temp")
    Command = "cmd /c echo Get-WmiObject win32_diskdrive ^| Select-Object Model, @{n='DiskNumber'; e={$_.Index}}, @{n='Size / GB';e={[math]::truncate($_.size / 1GB)}} ^| Fl ^| Out-File X:\Windows\Temp\output.txt -Encoding ascii > X:\Windows\Temp\process.ps1"
    PSFile = WshShell.Run(Command, 0, True)
    return = WshShell.Run("powershell.exe -ExecutionPolicy Unrestricted -File X:\Windows\Temp\process.ps1", 0, true)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set file = fso.OpenTextFile("X:\Windows\Temp\output.txt", 1)
    text = file.ReadAll
    ExampleOutput.Value = text
    file.Close
    document.body.style.cursor = "default"
    btnClick.style.cursor = "default"
    btnClick.disabled = False
End Sub

Sub Submit_OnClick()
    Dim TheForm
    Dim TSVar
    Dim DiskSelectionNumber
    Dim objFSO, objFile, objTotal
    Dim WshShell, Command, PSFile,return, fso, file, text, Temp
    Set WshShell = CreateObject("WScript.Shell")
    Temp = WshShell.ExpandEnvironmentStrings("X:\Windows\Temp")
    Set TheForm = Document.ValidForm
    
    If IsNumeric(TheForm.Text1.Value) Then
        MsgBox "Thank you."
    Else
        MsgBox "Please enter a numeric value."
    End If
    TSVar = "$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment"
    DiskSelectionNumber = "$tsenv.Value('DiskNumber') = " + TheForm.Text1.Value
    Set objFSO=CreateObject("Scripting.FileSystemObject")
    Set objFile=objFSO.CreateTextFile("X:\Windows\Temp\DiskSelectionOutput.ps1",2,true)
    objFile.WriteLine(TSVar)
    objFile.WriteLine(DiskSelectionNumber)
    objFile.close
    return = WshShell.Run("powershell.exe -executionpolicy unrestricted -file X:\Windows\Temp\DiskSelectionOutput.ps1", 0, true)
End Sub
