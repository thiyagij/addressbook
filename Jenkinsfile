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
               
               //sh '/opt/apache-maven-3.6.3/bin/mvn clean install'
	        sh 'mvn clean install'
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
        withCredentials([usernamePassword(credentialsId: '8bc44236-11f6-4afe-b7c2-52de71013ecf', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
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
