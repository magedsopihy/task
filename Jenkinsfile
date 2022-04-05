// #!/usr/bin/env groovy
// def gv

// pipeline {
//     agent any
   
   
//     stages {
//         stage("init"){
//             steps {
//                 script {
//                   gv = load "script.groovy"
//                 }
//             }
//         }
//         stage("build app"){
//             steps {
//                 script {
//                     gv.buildApp()
//                 }
//             }
//         }

//         stage("build image"){
//             steps {
//                 script {
//                     gv.buildImage()
//                 }
//             }
//         }
            

//         stage("deploy"){
//             steps{
//                 script{
//                     gv.deployApp()
//                 }
//             }
//         }
//     }
    
// }

pipeline {

 

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }

  stages {

    stage('Kaniko Build & Push Image') {
      steps {
        container('kaniko') {
          script {
            sh '''
            /kaniko/executor --dockerfile `pwd`/Dockerfile \
                             --context `pwd` \
                             --destination=magedsopihy/task:${BUILD_NUMBER}
            '''
          }
        }
      }
    }

    stage('Deploy App to Kubernetes') {     
      steps {
        container('kubectl') {

          // withCredentials([file(credentialsId: 'KUBE_CONFIG', variable: 'KUBECONFIG')]) 
          kubernetesDeploy(configs: "kubeconfig_task_eks", kubeconfigId: "KUBE_CONFIG")
          {
            sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" app-deployment.yaml'
            sh 'kubectl apply -f app-deployment.yaml'
          }
        }
      }
    }    
  
  }
}