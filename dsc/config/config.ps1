Configuration Config {
    param 
    ( 
        [Parameter(Mandatory)] 
        [string]$NodeName
    )
    
    Node $NodeName
    {
        WindowsFeature HyperV
        {
            Name = "Hyper-V"
            Ensure = "Present"
        }

        WindowsFeature HyperVRSAT
        {
            Name = "RSAT-Hyper-V-Tools"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]HyperV"
        }
        Script CreateFolder
        {
            SetScript = {New-Item -Type Directory -Name WSLab -Path d:}
            TestScript = {Test-Path -Path d:\WSLab}
            GetScript = {   @{Ensure = if (Test-Path -Path d:\WSLab) {'Present'} else {'Absent'}}   }
            DependsOn = "[WindowsFeature]HyperVRSAT"
        }
        
        LocalConfigurationManager 
        {
            RebootNodeIfNeeded = $true
        }
    }
}





