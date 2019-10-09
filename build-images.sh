# Build the images
docker build -t alemor/coreapi -f 5.Dockerfile-CoreAPI .
docker build -t alemor/apigateway -f 5.Dockerfile-APIGateway .
docker build -t alemor/frontend -f 5.Dockerfile-FrontEnd .

# Run the images in docker
#docker run --rm alemor/coreapi
#docker run --rm -e CoreContactsAPIURI=http://coreapi/api/contacts alemor/apigateway
#docker run --rm -e APIGatewayCustomersURI=http://apigateway/api/customers -p 8090:80 alemor/frontend
