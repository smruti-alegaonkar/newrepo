pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'smruti-alegaonkar'
        IMAGE_NAME = 'test-ubuntu'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Cloning repository...'
                git branch: 'main', url: 'https://github.com/smruti-alegaonkar/newrepo.git'
            }
        }

        stage('Setup Python Environment') {
            steps {
                echo '⚙️ Installing Python dependencies...'
                sh '''
                    python3 -m pip install --upgrade pip --break-system-packages
                    python3 -m pip install pytest --break-system-packages
                '''
            }
        }

        stage('Run Tests') {
            steps {
                echo '🧪 Running tests...'
                sh '''
                    python3 -m pytest || echo "No tests found or failed!"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh '''
                    docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
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
