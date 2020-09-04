pipeline {
     agent any
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Lint Dockerfile') {
            steps {
                script {
                    docker.image('hadolint/hadolint:latest-alpine').inside() {
                            sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
                            sh '''
                                lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
                                if [ "$lintErrors" -gt "0" ]; then
                                    echo "Errors have been found, please see below"
                                    cat hadolint_lint.txt
                                    exit 1
                                else
                                    echo "The Dockerfile is error free!!"
                                fi
                            '''
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