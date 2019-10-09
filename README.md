# AKS Demo

A sample solution leveraging Docker, ACR, and AKS.

## Steps

- Develop and test the .Net Core services locally
- Create the service principal in Azure
  - Run: ```sh create-service-principal.sh```
- Deploy AKS Cluster
  - Run: ```sh deploy.sh```
  - Select kubenet or CNI
- Create an Azure Container Registry (ACR)
  - Run: ```sh deploy-acr.sh```
- Create the docker files to build the images for:
  - FrontEnd: ```Dockerfile-FrontEnd```
  - APIGateway: ```Dockerfile-APIGateway```
  - Core.API: ```Dockerfile-CoreAPI```
- Build the docker images and push the images to ACR:
  - Run: ```build-images-and-push.sh``` 
- Test in Docker images with docker-compose
  - ```docker-compose up``` (docker-compose.yaml)
- Get Kubernetes credentials
  - ```az aks get-credentials --resource-group myResourceGroup --name myAKSCluster```
- Create YAML files for Kubernetes
  - Core.API
    - coreapi-deployment.yaml
    - coreapi-service.yaml
  - APIGateway
    - apigateway-deployment.yaml
    - apigateway-service.yaml 
  - FrontEnd
    - frontend-deployment.yaml
    - frontend-service.yaml 
- Deploy the kubernetes deployments and services
  - ```kubectl apply -f coreapi-deployment.yaml```
  - ```kubectl apply -f coreapi-service.yaml```
