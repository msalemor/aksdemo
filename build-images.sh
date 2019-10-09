
# Always a good practice to use a version
ver=$(date +"%Y%m%d%H%M")

# Build the images
docker build -t alemor/coreapi -f Dockerfile-CoreAPI .
docker build -t alemor/apigateway -f Dockerfile-APIGateway .
docker build -t alemor/frontend -f Dockerfile-FrontEnd .

# Run the images in docker
#docker run --rm alemor/coreapi
#docker run --rm -e CoreContactsAPIURI=http://coreapi/api/contacts alemor/apigateway
#docker run --rm -e APIGatewayCustomersURI=http://apigateway/api/customers -p 8090:80 alemor/frontend

docker login alemoracr.azurecr.io
# Provide User name and password from admin ACR


docker tag alemor/coreapi alemoracr.azurecr.io/alemor/coreapi
docker push alemoracr.azurecr.io/alemor/coreapi

docker tag alemor/apigateway alemoracr.azurecr.io/alemor/apigateway
docker push alemoracr.azurecr.io/alemor/apigateway

docker tag alemor/frontend alemoracr.azurecr.io/alemor/frontend
docker push alemoracr.azurecr.io/alemor/frontend

