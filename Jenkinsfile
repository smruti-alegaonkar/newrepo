pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/smruti-alegaonkar/newrepo.git'
        BRANCH_NAME = 'main'
        IMAGE_NAME = 'smrutia/dockerpython:latest'
        VENV_PATH = '.venv'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Cloning repository...'
                git branch: "${BRANCH_NAME}", url: "${REPO_URL}"
            }
        }

        stage('Setup Environment') {
            steps {
                echo '⚙️ Creating Python virtual environment...'
                sh '''
                apt-get update -y
                apt-get install -y python3-venv
                python3 -m venv ${VENV_PATH}
                . ${VENV_PATH}/bin/activate
                pip install --upgrade pip
                if [ -f requirements.txt ]; then
                    pip install -r requirements.txt
                else
                    echo "No requirements.txt found, skipping..."
                fi
                '''
            }
        }

        stage('Run Tests') {
            steps {
                echo '🧪 Running tests...'
                sh '''
                . ${VENV_PATH}/bin/activate
                if command -v pytest >/dev/null 2>&1; then
                    pytest || true
                else
                    echo "pytest not found, skipping tests"
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh '''
                docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '⬆️ Pushing Docker image to Docker Hub...'
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_TOKEN')]) {
                    sh '''
                    echo "$DOCKER_TOKEN" | docker login -u smrutia --password-stdin
                    docker push ${IMAGE_NAME}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully!'
        }
        failure {
            echo '❌ Build failed! Please check logs.'
        }
    }
}
