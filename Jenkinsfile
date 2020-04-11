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
                    sh "sceptre --var branch=${branch} --var asset=test.zip validate dev"
                    
                    dir("src"){
                        sh "npm test"
                    }   
                }
            }
        }

        stage("Deploy Prerequisites") {
            steps {
                script {
                    sh "sceptre --var branch=${branch} --var asset=test.zip ${operation} dev/prerequisites -y"
                    assets_bucket = sh(script:"eval \$(sceptre --var branch=master --ignore-dependencies list outputs dev/prerequisites.yaml --export=envvar) && echo \$SCEPTRE_AssetsBucket", returnStdout: true).trim()
                }
            }
        }

        stage("Package App") {
            steps {
                script {
                    if (operation == 'launch') {

                        long timestamp = System.currentTimeMillis() / 1000;
                        file_name = "test-app-" + timestamp + ".zip"
                        dir("src"){
                            sh 'npm ci'
                            sh "zip -r ../${file_name} *"
                        }

                        echo "package src dir to ${assets_bucket}"
                        sh "aws s3 cp ${file_name} s3://${assets_bucket}"
                    }
                }
            }
        }

        stage("Deploy App") {
            steps {
                script {
                    echo "placeholder"
                    sh "sceptre --var branch=${branch} --var asset=${file_name} ${operation} dev/app -y"
                    sh "sceptre --output json --var branch=${branch} --var asset=${file_name} --ignore-dependencies list outputs dev/app.yaml"
                }
            }
        }

        
 
    }
}