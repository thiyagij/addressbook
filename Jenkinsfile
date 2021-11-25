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
        withCredentials([usernamePassword(credentialsId: '8bc44236-11f6-4afe-b7c2-52de71013ecf', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
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
