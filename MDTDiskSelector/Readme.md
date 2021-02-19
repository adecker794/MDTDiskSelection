Tutorial to get the disk selection working for your MDT deployment.

First:
    Open the MDTWizardStudio and open the executable
    File: Open
    Open the "DeployWiz_Definition_ENU.xml" that is inside your "Scripts" folder in
        your deployment share
        This loads up all of your current\available guis for the deployment.
    Move the "DiskSelectionScript.vbs" to your Scripts folder
        You will need the contents of "DiskSelection_1.xml" but it doesn't need to be in the scripts folder
    From there right click on global, click "Add"
    Pane ID will be the name so "Disk Selection" works
    Filename will be the xml, so DiskSelection.xml
        You can drag the created pane down further in the sequence if you don't want it first.
    In the settings tab, on the bottom, click Add.
        CustomScript
        It will ask for a vbs file, select the "DiskSelectionScript.vbs"
        It will populate the window to the right, showing the script
    On the top tabs, go to HTML
        Copy the contents from "DiskSelection_1.xml" into the window
    
Second:
    Open Deployment Share Properties and then go to the Rules Tab
        DiskNumber=-1
        add that to the rules
    Open the task sequence you want this to work on
        Go To: Preinstall -> New Computer Only
        Under Validate you need to "Run a PowerShell Script"
            PowerShell script: X:\Windows\Temp\DiskSelectionOutput.ps1 
        Under that PowerShell Script you need to create more of the "Format and Partition Disk (BIOS) & (UEFI)"
        In order to make this work, you need to go into Options
            Add -> Task Sequence Variable
            Variable name is "DiskNumber"
            Condition is equals
            Value is whatever drive number you want( 1, 2, 3, etc)
            You can make "Format and Partition Disk (BIOS) & (UEFI)" for however many disks you want
        Whatever drive number you made the variable name equal to, you need to go back into the properties and set the "Disk Number" option to that(the little up and down arros about halfway down the screen)
Now, click Apply and test it out. You can update the deployment share if you'd like



 
