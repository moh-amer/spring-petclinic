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

    /////////////////start ////////////
stage("Clone Git Repository") {
            steps {
                git(
                    url: "https://github.com/moh-amer/petclinic-config",
                    branch: "main",
                    changelog: true,
                    poll: true
                )
            }
        }
        stage("Create artifacts or make changes") {
            steps {
                sh "touch testfile"
                sh "git add testfile"
                sh "git commit -m 'Add testfile from Jenkins Pipeline'"
            }
        }
        stage("Push to Git Repository") {
            steps {
                withCredentials([gitUsernamePassword(credentialsId: 'git-hub-moh_amer', gitToolName: 'Default')]) {
                    sh "git push -u origin main"
                }
            }
        }

    ////////////////end //////////////

}


        post{
                success{
                        slackSend color: "#439FE0", message: "Deployed Successfully To DockerHub: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
                }
        }
}
