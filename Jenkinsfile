pipeline {
    agent any
    stages {
        stage("Clean") {
            steps {
                echo "Cleaning.."
                sh "rm * -rf"
                checkout scm
            }
        }
        stage("LOVE2D") {
              steps {
                echo "Downloadin LOVE2d engine!"
                sh "wget https://bitbucket.org/rude/love/downloads/love-0.10.2-win64.zip"
                sh "unzip love-0.10.2-win64.zip"
              }
        }
        stage("Build") {
            steps {
                echo "Building Zato Windows exe.."
                sh "zip -9 -r Zato-${BUILD_NUMBER}.love zato"
                sh "cat love-0.10.2-win64/love.exe Zato-${BUILD_NUMBER}.love > Zato-${BUILD_NUMBER}.exe"
                archiveArtifacts artifacts: 'Zato-*', fingerprint: true
            }
        }
    }
}
