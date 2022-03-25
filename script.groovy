
  
def buildApp(){
    echo "building the application"
    
}

def buildImage(){
    echo "building the docker image"
    withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'PASS', usernameVariable: 'USERNAME')]){
    sh 'docker build -t magedsopihy/node_project:1.0 .'
    sh 'echo $PASS | docker login -u $USERNAME --password-stdin'
    sh 'docker push magedsopihy/node_project:1.0'
    }
}

def deployApp() {
    echo "deploying the application"
}
return this