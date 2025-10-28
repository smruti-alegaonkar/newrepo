pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/smruti-alegaonkar/newrepo.git'
            }
        }
        stage('Setup') {
            steps {
                sh 'python3 -m pip install --upgrade pip'
                sh 'python3 -m pip install -r requirements.txt || true'
            }
        }
        stage('Test') {
            steps {
                sh 'python3 -m pytest || true'
            }
        }
    }
}
