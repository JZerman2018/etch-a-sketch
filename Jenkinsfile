pipeline {
     agent any
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
        //  stage('Lint HTML') {
        //       steps {
        //           sh 'tidy -q -e *.html'
        //       }
        //  }
         stage('Lint Dockerfile') {
            steps {
                script {
                    docker.image('hadolint/hadolint:latest-debian').inside() {
                            sh 'hadolint ./Dockerfile'
                    }
                }
            }
        }
        stage('Aqua Microscanner Security Scan') {
              steps {
                 aquaMicroscanner imageName: 'node:12-alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
              }
         }
         stage('Build Docker Image') {
            steps {
                sh './run_docker.sh'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh './upload_docker.sh'
            }
        }
        stage('Deploy') {
            steps {
                sh './run_kubernetes.sh'
            }
        }
        stage("Clean Up System") {
              steps {
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
     }
}