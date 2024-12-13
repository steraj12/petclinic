pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'your-docker-image-name'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('Maven build') {
            steps {
                // Build of the application
		bat 'mvn clean install -Dmaven.test.skip=true'
                
            }
        }

        stage('Docker Build and Push') {
            steps {
                // Docker image creation
                echo 'Docker image creation...'
				bat 'docker build -f Dockerfile . -t steraj16/petclinc_app:1.0'
				bat 'docker push steraj16/petclinc_app:1.0'
				
            }
        }
    }
		stage('Docker Build and Push') {
            steps {
                // Docker image creation
				cd charts
                echo '------------------------ Deployment of Petclinic app-----------------------------------------------------------------'
				bat helm upgrade --install petclinic . --create-namespace -f values.yaml --set image.repository="petclinic" --set image.="petclinic" -n petclinc
				bat kubectl get po -n petclinc
				
            }
        }
    }
    post {
        success {
            // Add post-build steps here (e.g., notifications)
            echo 'Build and deployment successful!'
        }
    }
}
