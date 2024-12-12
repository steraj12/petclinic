pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'your-docker-image-name'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('maven build') {
            steps {
                // Build of the application
		sh 'maven clean install'
                
            }
        }

        stage('Deploy') {
            steps {
                // Add deployment steps here if needed
                echo 'Deploying...'
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
