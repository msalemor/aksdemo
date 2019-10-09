#!/bin/bash

AKS_RESOURCE_GROUP=aks-demo-rg
AKS_CLUSTER_NAME=demoaks
ACR_NAME=alemoracr
ACR_LOCATION=eastus2

# Create the ACR
echo "Creating ACR $ACR_NAME at $ACR_LOCATION"
az acr create --resource-group $AKS_RESOURCE_GROUP --name $ACR_NAME --sku Basic --location $ACR_LOCATION

# Get the id of the service principal configured for AKS
echo "Getting the client ID for the cluster $AKS_CLUSTER_NAME"
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

# Get the ACR registry resource id
echo "Getting the ACR resource ID"
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $AKS_RESOURCE_GROUP --query "id" --output tsv)

# Create role assignment
echo "Assiging the acrpull role to the client id used by AKS"
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID
