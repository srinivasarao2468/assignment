def DOCKER_HUB_ID = 'srinivasarao2468'
def IMAGE_NAME = "assignment"
def IMAGE_VERSION = 'v1'

pipeline {
    agent any
    stages {
      stage('Build Docker Image'){
        steps{
          sh "docker build -t ${DOCKER_HUB_ID}/${IMAGE_NAME}:${IMAGE_VERSION} ."
          }
      }

      stage('Push To Private Registry'){
        steps{
          withCredentials([string(credentialsId: 'docker-hub', variable: 'docker_hub_pwd')]) {
               sh "docker login -u srinivasarao2468 -p ${docker_hub_pwd}"
               sh "docker push ${DOCKER_HUB_ID}/${IMAGE_NAME}:${IMAGE_VERSION}"
        }
      }
    }
  }
}
