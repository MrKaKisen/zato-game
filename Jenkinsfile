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
                echo "Downloading LOVE2d engine!"
                sh "wget https://bitbucket.org/rude/love/downloads/love-0.10.2-win64.zip"
                sh "unzip love-0.10.2-win64.zip"
              }
        }
        stage("Build") {
            steps {
                echo "Building Zato Windows exe.."
                sh "cd zato"
                sh "zip -9 -r Zato-${BUILD_NUMBER}.love ."
                sh "cd .."
                sh "mv zato/Zato-${BUILD_NUMBER}.love Zato-${BUILD_NUMBER}.love"
                sh "cat love-0.10.2-win64/love.exe Zato-${BUILD_NUMBER}.love > Zato-${BUILD_NUMBER}.exe"

                sh "mkdir Zato-Windows-${BUILD_NUMBER}"
                sh "cp Zato-${BUILD_NUMBER}.exe Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/SDL2.dll Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/OpenAL32.dll Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/license.txt Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/love.dll Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/lua51.dll Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/mpg123.dll Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/msvcp120.dll Zato-Windows-${BUILD_NUMBER}"
                sh "cp love-0.10.2-win64/msvcr120.dll Zato-Windows-${BUILD_NUMBER}"

                sh "zip -r Zato-Windows-${BUILD_NUMBER}.zip Zato-Windows-${BUILD_NUMBER}"

                sh "rm Zato-${BUILD_NUMBER}.exe"

                echo "Building Zato Linux executable.."
                sh "cat /usr/bin/love Zato-${BUILD_NUMBER}.love > Zato-Linux-${BUILD_NUMBER}"
                sh "chmod a+x ./Zato-Linux-${BUILD_NUMBER}"

                archiveArtifacts artifacts: 'Zato-*', fingerprint: true
            }
        }
    }
}
