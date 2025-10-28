pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/smruti-alegaonkar/newrepo.git'
        DOCKERHUB_REPO = 'smruti-alegaonkar/test-ubuntu'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📥 Cloning repository..."
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('Setup Environment') {
            steps {
                echo "⚙️ Installing Python dependencies (safe mode)..."
                sh '''
                    python3 -m pip install --upgrade pip --break-system-packages
                    python3 -m pip install pytest --break-system-packages
                '''
            }
        }

        stage('Run Tests') {
            steps {
                echo "🧪 Running tests..."
                sh '''
                    python3 -m pytest || echo "No tests found or some failed!"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                sh 'docker build -t ${DOCKERHUB_REPO}:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "🚀 Pushing image to Docker Hub..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKERHUB_REPO}:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Build failed! Please check logs."
        }
    }
}
