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
         stage ('Lint Dockerfile') {
            agent {
                docker {
                    image 'hadolint/hadolint:latest-debian'
                }
            }
            steps {
                sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
            }
            post {
                always {
                    archiveArtifacts 'hadolint_lint.txt'
                }
            }
        }
        // stage('Aqua Microscanner Security Scan') {
        //       steps {
        //          aquaMicroscanner imageName: 'node:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
        //       }
        //  }
        stage('Build Docker Image') {
            steps {
                sh './run_docker.sh'
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                    sh './upload_docker.sh'
                }
            }
        }
        stage('Deploy') {
            steps {
                withAWS(credentials: 'JZerman', region: 'us-east-1') {
                sh "aws eks --region us-east-1 update-kubeconfig --name devopscapstone"
                sh "kubectl config use-context arn:aws:eks:us-east-1:766162985452:cluster/devopscapstone"
                sh "kubectl apply -f deployment.yml"
                sh "kubectl get nodes"
                sh "kubectl get deployments"
                sh "kubectl get pod -o wide"
                sh "kubectl get svc"
            }
        }
    }
        stage('Clean Up System') {
            steps {
                echo 'Cleaning up...'
                sh "docker system prune"
            }
        }
    }
}