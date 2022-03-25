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
VPC module used with configration
-
