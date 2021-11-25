pipeline {
    
   agent { label 'master' }
    stages {
	   
        stage ('Checkout') {
          steps {
            git 'https://github.com/thiyagij/addressbook.git'
          }
        }
        stage('Build') {
            
             steps {
               
                sh '/opt/apache-maven-3.6.3/bin/mvn clean install'    
                //junit '**/target/surefire-reports/TEST-*.xml'
		archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
        stage('Docker image') {
        
            steps {
                
                sh 'docker build -t thiyagi01/addressbook$(git rev-parse HEAD):latest .'
            }
    }
        stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: '4b6286c4-8d32-472c-9e0c-cabddcf8e052', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push thiyagi01/addressbook$(git rev-parse HEAD):latest'
        }
      }
    }
        stage('Docker Deploy') {
       
      steps {
          sh 'docker run -itd -P thiyagi01/addressbook$(git rev-parse HEAD):latest'
        }
      }
    
    }
    
}
