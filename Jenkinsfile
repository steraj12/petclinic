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
		bat mvn clean install '-Dmaven.test.skip=true'
                
            }
        }

        stage('Docker Build') {
            steps {
                // Docker image creation
                echo 'Docker image creation...'
		bat 'docker build -f Dockerfile -t hub.docker.com/steraj16/petclinc_app:1.0'
		bat 'docker push hub.docker.com/steraj16/petclinc_app:1.0'
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
