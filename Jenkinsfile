pipeline {
    
    agent { label 'slave' }
    stages {
	   
        stage ('Checkout') {
          steps {
            git 'https://github.com/dilipsun/addressbook.git'
          }
        }
        stage('Build') {
            
             steps {
               
               sh '/opt/apache-maven-3.6.2/bin/mvn clean install'
                //junit '**/target/surefire-reports/TEST-*.xml'
		archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
        stage('Docker image') {
        
            steps {
                
                sh 'docker build -t dilipsun/addressbook$(git rev-parse HEAD):latest .'
            }
    }
        stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: '0cbba8fe-3712-4b74-9c83-b6508dea1199', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push dilipsun/addressbook$(git rev-parse HEAD):latest'
        }
      }
    }
        stage('Docker Deploy') {
       
      steps {
          sh 'docker run -itd -P dilipsun/addressbook$(git rev-parse HEAD):latest'
        }
      }
    
    }
    
}
