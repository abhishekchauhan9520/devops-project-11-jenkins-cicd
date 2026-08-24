pipeline {
  agent any

  environment {
    IMAGE_NAME = 'project11-jenkins-docker'
    CONTAINER_NAME = 'project11-app'
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Validate') {
      steps {
        sh 'test -f Dockerfile'
        sh 'test -f app/index.html'
        sh 'grep -q "<h1>Jenkins + Docker CI/CD</h1>" app/index.html'
      }
    }

    stage('Build Image') {
      steps { sh 'docker build -t "$IMAGE_NAME:${BUILD_NUMBER}" .' }
    }

    stage('Smoke Test') {
      steps {
        sh '''
          docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
          docker run -d --name "$CONTAINER_NAME" -p 18080:80 "$IMAGE_NAME:${BUILD_NUMBER}"
          trap 'docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true' EXIT
          for i in $(seq 1 20); do
            if curl -fsS http://127.0.0.1:18080/ >/dev/null; then exit 0; fi
            sleep 1
          done
          exit 1
        '''
      }
    }
  }

  post {
    always {
      sh 'docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true'
    }
    success { echo 'CI/CD pipeline completed successfully.' }
    failure { echo 'CI/CD pipeline failed.' }
  }
}
