pipeline {
    agent any

    triggers {
          pollSCM '* * * * *'
    }
  

    stages {

        stage("Prepare"){
            steps{
                git (url:'https://github.com/moh-amer/spring-petclinic',branch:'main')
            }
        }

        stage("Compiling and Packaging"){
            steps{
                sh "./mvnw compile"
                sh "./mvnw clean package"
            }

        }
        stage("Testing"){
            steps{
                    junit 'target/surefire-reports/*.xml'
                    archiveArtifacts 'target/*.jar'
            }
        }

        stage("Building"){
            steps{
                 withCredentials([usernamePassword(credentialsId: 'dockerId', passwordVariable: 'DOCKER_PASS',
                  usernameVariable: 'DOCKER_USER')]) {

                sh """
                    docker build -t 'pharogrammer/petclinic:v1.${BUILD_NUMBER}' .
                    docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
                    docker push pharogrammer/petclinic:v1.${BUILD_NUMBER}
                """
            }
        }
    }

}


        post{
                success{
                        slackSend color: "#439FE0", message: "Deployed Successfully To DockerHub: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
                }
        }
}
