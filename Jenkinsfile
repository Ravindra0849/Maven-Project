pipeline {
    agent any
    
    tools {
        maven "maven"
    }

    stages {
        stage('Clean the Workspace') {
            steps {
                cleanWs()
            }
        }
        
        stage('Download  the code from github repo') {
            steps {
                git "https://github.com/Ravindra0849/Maven-Project.git"
            }
        }
        
        stage('Code Compilation') {
            steps {
                sh "mvn compile"
            }
        }
        
        stage('Unit Test') {
            steps {
                sh "mvn test"
            }
        }
        
        stage('Build the Artifact') {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage('Build the docker image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                        sh "docker build -t web ."
                        sh "docker tag web ravisree900/web:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        
        stage('Push the docker image into Docker Registry') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                        sh "docker push ravisree900/web:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        
        stage('Container Creation') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                        sh "docker run -d -p 8081:80 ravisree900/web:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
