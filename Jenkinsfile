properties([
    parameters([
        choice(
            name: 'BUILD_ENABLE',
            choices: ['Yes', 'No'],
            description: 'Do you want to build a new JAR?'
        ),
        choice(
            name: 'DOCKER_IMAGE',
            choices: ['Yes', 'No'],
            description: 'Do you want to build a new Docker image?'
        ),
        choice(
            name: 'DEPLOY_ENABLE',
            choices: ['Yes', 'No'],
            description: 'Do you want to deploy the application?'
        )
    ])
])

pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'your-docker-image-name'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('Maven Build') {
            when {
                beforeAgent true
                expression { params.BUILD_ENABLE == 'Yes' }
            }
            steps {
                // Build the application
                bat 'mvn clean install -Dmaven.test.skip=true'
                //bat 'ls'
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }

        stage('Docker Build and Push') {
            when {
                beforeAgent true
                expression { params.DOCKER_IMAGE == 'Yes' }
            }
            steps {
                // Docker image creation and push
                echo 'Docker image creation...'
                bat 'docker build -f Dockerfile . -t steraj16/petclinic_app:1.0'
                bat 'docker push steraj16/petclinic_app:1.0'
            }
        }

        stage('Helm Deployment') {
            when {
                beforeAgent true
                expression { params.DEPLOY_ENABLE == 'Yes' }
            }
            steps {
                dir('charts') {
                    // Deploy using Helm
                    echo 'Deploying Petclinic app using Helm...'
                    echo 'Login to cluster'
                    bat 'kubectl config set-context docker-desktop'
                    bat 'helm upgrade --install petclinic . --create-namespace -f values.yaml --set image.repository="steraj16/petclinic_app" --set image.tag="1.0" -n petclinic'
                    bat 'kubectl get po -n petclinic'
                }
            }
        }
    }
}