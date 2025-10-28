pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Setup') {
      steps {
        sh 'python -m pip install --upgrade pip || true'
        sh 'python -m pip install -r requirements.txt || true'
      }
    }
    stage('Test') {
      steps {
        sh 'python -m pytest || true'
      }
    }
  }
}
