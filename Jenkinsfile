pipeline {
    environment {
        AWS_DEFAULT_REGION = 'eu-west-1'
        AWS_PROFILE = "default"
    }
    agent any
    stages {
        stage("Gather Parameters") {
            steps {
                script {
                    operation = input message: 'Please provide parameters', ok: 'Deploy',
                        parameters: [
                            choice(name: 'Operation', choices: ['launch', 'delete'], description: 'What sceptre operation?')
                        ]
                }
            }
        }

        stage ('Prep') {
            steps {
                script {
                    branch = GIT_BRANCH.replaceAll("[^A-Za-z0-9]", "")
                }
            }
        }

        stage ('Tests') {
            steps {
                script {
                    sh "sceptre --var branch=${branch} validate dev"
                    
                    dir("src"){
                        sh "npm test"
                    }   
                }
            }
        }

        stage("Deploy Prerequisites") {
            steps {
                script {
                    sh "sceptre --var branch=${branch} ${operation} dev/prerequisites -y"
                    assets_bucket = sh(script:"eval \$(sceptre --var branch=master --ignore-dependencies list outputs dev/prerequisites.yaml --export=envvar) && echo \$SCEPTRE_AssetsBucket", returnStdout: true).trim()
                }
            }
        }

        stage("Package App") {
            steps {
                script {
                    if (operation == 'launch') {
                        dir("src"){
                            sh 'npm ci'
                        }
                        echo "package src dir to ${assets_bucket}"
                    }
                }
            }
        }

        stage("Deploy App") {
            steps {
                script {
                    echo "placeholder"
                    sh "sceptre --var branch=${branch} ${operation} dev/app -y"
                }
            }
        }
 
    }
}