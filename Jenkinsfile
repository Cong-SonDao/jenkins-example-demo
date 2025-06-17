pipeline {
    agent any

    environment {
        HARBOR_REGISTRY = 'registry.duypnn.com'
        HARBOR_PROJECT = 'demo3'
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        HARBOR_CREDENTIALS = 'harbor-credentials-id' // ID của credentials trong Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${HARBOR_REGISTRY}/${HARBOR_PROJECT}/${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'echo "Run tests here, ví dụ: pytest"'
                    }
                }
            }
        }
        stage('Login to Harbor & Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: env.HARBOR_CREDENTIALS, usernameVariable: 'HARBOR_USER', passwordVariable: 'HARBOR_PASS')]) {
                        sh "echo $HARBOR_PASS | docker login $HARBOR_REGISTRY -u $HARBOR_USER --password-stdin"
                        sh "docker push ${HARBOR_REGISTRY}/${HARBOR_PROJECT}/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker logout $HARBOR_REGISTRY"
                    }
                }
            }
        }
    }
}
