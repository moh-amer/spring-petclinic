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
        stage("Deploy"){
            steps{
                sh "java -Dserver.port=5001 -jar target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar"
            }
        }
    }
}

