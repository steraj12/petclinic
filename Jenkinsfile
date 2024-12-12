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
		bat 'mvn clean install'
                
            }
        }

        stage('Docker Build') {
            steps {
                // Docker image creation
                echo 'Docker image creation...'
		bat 'docker build -f Dockerfile -t petclinc_app:
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
