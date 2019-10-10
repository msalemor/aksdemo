# Create a service principal
az ad sp create-for-rbac --name $SP_NAME --skip-assignment --output json > sp.txt