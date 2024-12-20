properties([
    parameters([
    choice(
            name: 'BUILD_ENABLE',
            choices: ['Yes', 'No'],
            description: 'Do You want to build New Jar'         
        ),
    choise(
            name: 'DOCKER_IMAGE',
            choices: ['Yes', 'No'],
            description: 'Do You want to build Build New Docker image'
        ),
    choise(
            name: 'DEPLOY_ENABLE',
            choices: ['Yes', 'No'],
            description: 'Do You want to build New Jar'
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
        stage('Maven build') {
            when {
                beforeAgent true
                expression { parameters.BUILD_ENABLE == 'Yes'}
            }
            steps {
                // Build of the application
		bat 'mvn clean install -Dmaven.test.skip=true'
                
            }
        }

        stage('Docker Build and Push') {
            when {
                beforeAgent true
                expression { parameters.DOCKER_IMAGE == 'Yes'}
            }
            steps {
                // Docker image creation
                echo 'Docker image creation...'
				bat 'docker build -f Dockerfile . -t steraj16/petclinc_app:1.0'
				bat 'docker push steraj16/petclinc_app:1.0'
				
            }
        }
		
		stage('Helm Deployment') {
            when {
                beforeAgent true
                expression { parameters.DEPLOY_ENABLE == 'Yes'}
            }
            steps {
                // Docker image creation
				cd ./charts
                echo '------------------------ Deployment of Petclinic app-----------------------------------------------------------------'
				bat 'helm upgrade --install petclinic . --create-namespace -f values.yaml --set image.repository="petclinic" --set image.="petclinic" -n petclinc'
				bat 'kubectl get po -n petclinc'
				
            }
        }
    }
}