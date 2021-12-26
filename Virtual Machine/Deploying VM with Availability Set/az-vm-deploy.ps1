#variables

$resourceGroup = "rg1"
$location = "eastus"
$vmName = "VM"
$availabilityset = "myavailabilityset"

#Remove Existing group if its there
Remove-AzResourceGroup "rg1" -Force -Verbose

New-AzResourceGroup `
  -ResourceGroupName $resourceGroup `
  -Location $location

# VMs must be created within the availability set to make sure they're correctly distributed across the hardware. 
# You can't add an existing VM to an availability set after it's created.



New-AzAvailabilitySet `
   -Location $location `
   -Name $availabilityset `
   -ResourceGroupName $resourceGroup `
   -Sku aligned `
   -PlatformFaultDomainCount 2 `
   -PlatformUpdateDomainCount 2



$cred = Get-Credential

for ($i=1; $i -le 2; $i++)
{
    
    New-AzVm `
        -ResourceGroupName $resourceGroup `
        -Name $vmName$i `
        -Location $location `
        -VirtualNetworkName "myVnet" `
        -SubnetName "mySubnet" `
        -SecurityGroupName "myNetworkSecurityGroup" `
        -PublicIpAddressName "myPublicIpAddress$i" `
        -AvailabilitySetName $availabilityset `
        -Credential $cred `
        -OpenPorts 80
}


# Install IIS
$PublicSettings = '{"commandToExecute":"powershell Add-WindowsFeature Web-Server"}'
for ($i=1; $i -le 2; $i++)
{
    Set-AzVMExtension -ExtensionName "IIS" -ResourceGroupName $resourceGroup -VMName $vmName$i -Publisher "Microsoft.Compute" -ExtensionType "CustomScriptExtension" -TypeHandlerVersion 1.4  -SettingString $PublicSettings -Location $location
}

Get-AzPublicIpAddress -ResourceGroupName $resourceGroup | Select "IpAddress"

#Navigate to the browser with the public ip and see if you are able to see default ip address
#Clen up resources after creation
# Remove-AzResourceGroup "rg1" -Force -Verbose