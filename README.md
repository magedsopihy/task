# CICD PIPLINE

## used tools

- docker
- terraform
- jenkins
- AWS EKS
- kaniko
- ansible


### building the app
----
the build with nodejs and express framework
you can run the locally by cloning the repo in cd insde app directory the run \
node app.js

### decorize the app
----

to reduce the image size I 
- used node:16-alpine as a base image 
- bundled only the production package isnide the image by using this command RUN npm ci --only=production
- used multistage mechanizem

commands used to build and test the app locally
- docker build -t magedsopihy/app:v1.0 .
- docker run -d -p 80:3000 magedsopihy/app:v1.0
- docker login 
- docker push magedsopihy/app:v1.0

### provisiong EKS cluster
----

I used terraform to provision EKS cluster and kept my code moduled \
VPC and EKS modules used with this configration
- three private subnets for in three 3 azs used for worker nodes.
- three public subnet in three azs used for loadbancers.
- t2.small type is used for worker nodes.
- autoscallinig group is set to  max=> 3, min=>1, desired=>2.
- persistent volume is to genrnal purpose 2 gp2 with size of 30g.

after the EKS id provisioned local provider used to deploy jenkins by ansible playbook.

commands used to provision the cluster
- terraform init 
- terraform plan
- terraform apply

### deploying jenkins in the cluster
----

ansible k8s module is used to deploy in the cluster with objects
- deployment object with initContainer to configure jenkins plugins which are passed to the init container from configmap object.
- service object to expose jenkins server via loadblancer.
- service account, clusterrole, clusterrolebinding to authorize jenkins to deploy objects in the cluster.
- persistent volume, persistent volume claim to store jenkins jobs,configeration, etc.

### jenkins pipline 
----
- Kubernetes plugin used to spin up an ephemeral Kubernetes pod based Jenkins only if there is a build request,
  once the build is complete, the pod will get terminated automatically.
- the pipline flow as follows 
  checkout github repo >> build docker image from Dockerfile >> push image to dockerhub >> deploy the app to the cluster
- Kaniko is used to build the image inside the jenkins container to avoid giving containers elevated privileges 
  when performing container image builds with docker.
- another container equipped with kubectl utility used to depoly the app to cluster.
