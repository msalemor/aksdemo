#!/bin/bash

echo "Starting AKS Cluster deployment"

RESOURCE_GROUP_NAME=aks-demo-rg
CLUSTER_NAME=demoaks
LOCATION=eastus2 # Ex. eastus, eastus2, westus, westus2
VNET_NAME=aksdemovnet
VNET_ADDRESS_PREFIX="10.0.0.0/8" # Ex. "10.0.0.0/8"
VNET_SUBNET_PREFIX="10.240.0.0/16" # Ex. "10.240.0.0/16"
AKS_VNET_SUBNET_NAME=akssubnet
#SP_NAME="http://alemor1sp"
SP_ID="93020f3a-85ce-4a3c-b330-805c40860b81"
SP_PASSWORD="f0106df2-e712-403c-a46b-418e3881c2f2"

# Enable AKS Preview Feature Extensions
az extension add --name aks-preview
az extension update --name aks-preview

echo "Crating Resource Gropup $RESOURCE_GROUP_NAME at $LOCATION"

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

echo "Createing VNET $VNET_NAME"

# Create a virtual network and subnet
az network vnet create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $VNET_NAME \
    --address-prefixes $VNET_ADDRESS_PREFIX \
    --subnet-name $AKS_VNET_SUBNET_NAME \
    --subnet-prefix $VNET_SUBNET_PREFIX

# Create a service principal and read in the application ID
#SP=$(az ad sp create-for-rbac --name $SP_NAME --skip-assignment --output json)
#SP_ID=$(echo $SP | jq -r .appId)
#SP_PASSWORD=$(echo $SP | jq -r .password)

# Wait 15 seconds to make sure that service principal has propagated
#echo "Waiting for service principal to propagate..."
#sleep 15

echo "Getting VNET ID"
# Get the virtual network resource ID
VNET_ID=$(az network vnet show --resource-group $RESOURCE_GROUP_NAME --name $VNET_NAME --query id -o tsv)

echo "Assigning VNET ID $VNET_ID Role to SP ID"
# Assign the service principal Contributor permissions to the virtual network resource
az role assignment create --assignee $SP_ID --scope $VNET_ID --role Contributor

# Get the virtual network subnet resource ID
SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP_NAME --vnet-name $VNET_NAME --name $AKS_VNET_SUBNET_NAME --query id -o tsv)

echo "Createging $CLUSTER_NAME AKS cluster"
# Create the AKS cluster and specify the virtual network and service principal information
az aks create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --node-count 3 \
    --enable-vmss \
    --enable-cluster-autoscaler \
    --load-balancer-sku Standard \
    --node-vm-size Standard_B2s \
    --min-count 3 \
    --max-count 6 \
    --generate-ssh-keys \
    --network-plugin azure \
    --service-cidr 172.21.0.0/16 \
    --dns-service-ip 172.21.0.10 \
    --docker-bridge-address 172.17.0.1/16 \
    --vnet-subnet-id $SUBNET_ID \
    --service-principal $SP_ID \
    --client-secret $SP_PASSWORD \
    --network-policy azure


