#/bin/bash

# Always a good practice to use a version
#ver=$(date +"%Y%m%d%H%M")
#docker build -t alemor/coreapi:$ver -f Dockerfile-CoreAPI .

# Build the images
echo "Building CoreAPI"
docker build -t alemor/coreapi -f Dockerfile-CoreAPI .
echo "Building APIGateway"
docker build -t alemor/apigateway -f Dockerfile-APIGateway .
echo "Building FrontEnd"
docker build -t alemor/frontend -f Dockerfile-FrontEnd .

# Run the images in docker
#docker run --rm alemor/coreapi
#docker run --rm -e CoreContactsAPIURI=http://coreapi/api/contacts alemor/apigateway
#docker run --rm -e APIGatewayCustomersURI=http://apigateway/api/customers -p 8090:80 alemor/frontend

echo "Login into ACR"
docker login alemoracr.azurecr.io
# Provide User name and password from admin ACR

echo "Tag and Push CoreAPI"
docker tag alemor/coreapi alemoracr.azurecr.io/alemor/coreapi
docker push alemoracr.azurecr.io/alemor/coreapi

echo "Tag and Push APIGateway"
docker tag alemor/apigateway alemoracr.azurecr.io/alemor/apigateway
docker push alemoracr.azurecr.io/alemor/apigateway

echo "Tag and Push FrontEnd"
docker tag alemor/frontend alemoracr.azurecr.io/alemor/frontend
docker push alemoracr.azurecr.io/alemor/frontend
