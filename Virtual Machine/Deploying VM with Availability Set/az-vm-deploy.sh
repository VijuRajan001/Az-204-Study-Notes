# Update for your admin password
adminpassword="password@123"
adminuser="adminuser"
resourcegroup="rg1"
vmname="vm"
availsetname="availsetvm"

# Create a resource group.
az group create --name $resourcegroup --location eastus

#Create AvailabilitySet
az vm availability-set create -n $availsetname -g $resourcegroup --platform-fault-domain-count 2 --platform-update-domain-count 2 

# Create a virtual machine. 

for i in `seq 1 2`; do
   az vm create \
     --resource-group $resourcegroup \
     --name $vmname$i \
     --availability-set $availsetname \
     --size Standard_DS1_v2  \
     --vnet-name myVnet \
     --subnet mySubnet \
     --image win2016datacenter \
     --admin-username $adminuser \
     --admin-password $adminpassword

     # Open port 80 to allow web traffic to host.

     az vm open-port --port 80 --resource-group $resourcegroup --name $vmname$i 
     
done




# Use CustomScript extension to install IIS.
for i in `seq 1 2`; do
    az vm extension set \
      --publisher Microsoft.Compute \
      --version 1.8 \
      --name CustomScriptExtension \
      --vm-name $vmname$i \
      --resource-group $resourcegroup \
      --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}'
done


az vm list-ip-addresses --resource-group $resourcegroup -name $vmname

#clean up resources after creation
#az group create --name $resourcegroup