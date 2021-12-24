#variables

$resourceGroup = "rg1"
$location = "eastus"
$vmName = "VM1"

New-AzResourceGroup `
  -ResourceGroupName $resourceGroup `
  -Location $location

$cred = Get-Credential

New-AzVm `
    -ResourceGroupName $resourceGroup `
    -Name $vmName `
    -Location $location `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -Credential $cred `
    -OpenPorts 80
    

# Install IIS
$PublicSettings = '{"commandToExecute":"powershell Add-WindowsFeature Web-Server"}'

Set-AzVMExtension -ExtensionName "IIS" -ResourceGroupName $resourceGroup -VMName $vmName `
  -Publisher "Microsoft.Compute" -ExtensionType "CustomScriptExtension" -TypeHandlerVersion 1.4 `
  -SettingString $PublicSettings -Location $location


Get-AzPublicIpAddress -ResourceGroupName $resourceGroup | Select "IpAddress"

#Navigate to the browser with the public ip and see if you are able to see default ip address
#Clen up resources after creation
# Remove-AzResourceGroup "rg1" -Force -Verbose