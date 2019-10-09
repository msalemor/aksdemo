
# Always a good practice to use a version
ver=$(date +"%Y%m%d%H%M")

# Build the images
docker build -t alemor/coreapi:$ver -f Dockerfile-CoreAPI .
docker build -t alemor/apigateway:$ver -f Dockerfile-APIGateway .
docker build -t alemor/frontend -f:$ver Dockerfile-FrontEnd .

# Run the images in docker
#docker run --rm alemor/coreapi
#docker run --rm -e CoreContactsAPIURI=http://coreapi/api/contacts alemor/apigateway
#docker run --rm -e APIGatewayCustomersURI=http://apigateway/api/customers -p 8090:80 alemor/frontend
