# jenkinsChallenge
A simple Docker / Jenkins Knowledge challenge

## Preconditions
You need docker in your machine and  a k8s cluster accesible by the docker network. Formexample you can run minikube

- Install docker []
- Install minikube (optional) []

## Configure

We need to set some environment variables, you can edit Jenkins admin credentials on config/.envFile, next scripts creates a service account with the proper roles and fills token and CA cert info in the envFile file.
Create a k8s service account 
```    
kubectl create -f config/jenkins-sa.yml
```    

Get token
```    

   echo TOKEN=$(kubectl describe secret `kubectl get secrets --no-headers|grep jenkins |awk '{print $1}'` |grep token: |awk '{print $2}') >> config/.envFile
   ```    

Get K8s server cert and port server 
```    
   echo CA=\"$(cat `kubectl config view |grep certificate-authority: |awk '{print $2}'`)\" >> config/.envFile
   echo K8S_HOST=$(kubectl config view |grep server |awk '{print $2}') |sed  s/127\.0\.0\.1/host.docker.internal/g >> config/.envFile
   ```    

Run
```  
docker compose up --build
```    

Now go to https://localhost:8080, use your credentials (defaults are in envFile) and create a new Pipeline task from file ./jenkinsfile in the repository and run it, it will run in a pod with multiple container in k8s.

# Challenge 2

In the folder Challenge2 we have Terraform files to creawte a GKE cluster.

## Preconditions

You need to install terraform and Google Cloud SDK 

* https://cloud.google.com/sdk/docs/install
* https://learn.hashicorp.com/tutorials/terraform/install-cli
```    

   $ gcloud init
   $ gcloud auth application-default login
```    

then Create a Google Cloud project in the web console, keep the project id.

## Configure

Change file Challenge2/terraform.tfvars to add your project id

## Deploy

```
$ cd Challenge2
$ terraform init
$ terraform plan
$ terraform apply
```

