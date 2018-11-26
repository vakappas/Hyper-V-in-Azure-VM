#login to your azure account
Login-AzureRmAccount
Get-AzureRmSubscription

Select-AzureRmSubscription -Subscription "vakappas - Internal Consumption"

#Deploy VM to Azure using Template
New-AzureRmResourceGroup -Name "WSLabRGInsider" -Location "West Europe"

$TemplateUri="https://raw.githubusercontent.com/Microsoft/WSLab/master/Scenarios/Running%20WSLab%20in%20Azure/WSLabServerInsider.json"

New-AzureRmResourceGroupDeployment -Name WSLabInsider -ResourceGroupName WSLabRGInsider -TemplateUri $TemplateUri -Verbose

#connect to VM using RDP
mstsc /v:((Get-AzureRmPublicIpAddress -ResourceGroupName WSLabRGInsider).IpAddress)