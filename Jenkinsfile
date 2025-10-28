pipeline {
    agent any

    tools {
        maven 'Maven'        // Use Maven tool configured in Jenkins (Manage Jenkins → Global Tool Configuration)
        jdk 'JDK17'          // Use Java version configured in Jenkins (for example: JDK17)
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Pulling source code from GitHub...'
                checkout scm
            }
        }

        stage('Compile') {
            steps {
                echo 'Compiling the source code...'
                sh 'mvn clean compile'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn package'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests...'
                sh 'mvn test'
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}
