pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                echo 'Cloning project from GitHub...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Running build...'
                sh 'python3 app.py'
            }
        }
    }
}
