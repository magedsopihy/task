#!/usr/bin/env groovy
def gv

pipeline {
    agent any
   
   
    stages {
        stage("init"){
            steps {
                script {
                  gv = load "script.groovy"
                }
            }
        }
        stage("build app"){
            steps {
                script {
                    gv.buildApp()
                }
            }
        }

        stage("build image"){
            steps {
                script {
                    gv.buildImage()
                }
            }
        }
            

        stage("deploy"){
            steps{
                script{
                    gv.deployApp()
                }
            }
        }
    }
    
}