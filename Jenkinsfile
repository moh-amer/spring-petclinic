pipeline {
    agent any

    triggers {
          pollSCM '* * * * *'
    }
  

    stages {

        stage("Prepare"){
            steps{
                git 'https://github.com/moh-amer/spring-petclinic'
            }
        }

        stage("Build"){
            steps{
                sh "./mvnw compile"
                sh "./mvnw clean package"
            }

            post {
                success {
                    junit 'target/surefire-reports/*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
    }
}

