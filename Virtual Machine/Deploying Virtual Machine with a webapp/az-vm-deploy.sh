# Update for your admin password
AdminPassword=password@123
resourceGroup=rg1
vmname=vm1

# Create a resource group.
az group create --name $resourceGroup --location eastus

# Create a virtual machine. 
az vm create \
    --resource-group $resourceGroup \
    --name $vmname \
    --image win2016datacenter \
    --admin-username azureuser \
    --admin-password $AdminPassword

# Open port 80 to allow web traffic to host.
az vm open-port --port 80 --resource-group $resourceGroup --name $vmname 

# Use CustomScript extension to install IIS.
az vm extension set \
  --publisher Microsoft.Compute \
  --version 1.8 \
  --name CustomScriptExtension \
  --vm-name $vmname \
  --resource-group $resourceGroup \
  --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}'

az vm list-ip-addresses --resource-group $resourceGroup -name $vmname
