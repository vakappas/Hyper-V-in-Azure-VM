#login to your azure account
Login-AzureRmAccount
Get-AzureRmSubscription

Select-AzureRmSubscription -Subscription "vakappas - Internal Consumption"

#Deploy VM to Azure using Template
$ResourceGroup = "HVLab-RG"
New-AzureRmResourceGroup -Name $ResourceGroup -Location "West Europe"

$TemplateUri="https://raw.githubusercontent.com/vakappas/Hyper-V-in-Azure-VM/master/Hyper-V-Azure-VM.json"

New-AzureRmResourceGroupDeployment -Name HVLab -ResourceGroupName $ResourceGroup -TemplateUri $TemplateUri -Verbose

Remove-AzureRmResourceGroup -Name $ResourceGroup -Force

#connect to VM using RDP
mstsc /v:((Get-AzureRmPublicIpAddress -ResourceGroupName $ResourceGroup).IpAddress)