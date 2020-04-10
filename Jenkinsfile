pipeline {
    environment {
        AWS_DEFAULT_REGION = 'eu-west-1'
    }
    agent any
    stages {
        stage("Gather Parameters") {
            steps {
                script {
                    input_params = input message: 'Please provide parameters', ok: 'Deploy',
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

        stage ('Validate') {
            steps {
                script {
                    echo "placeholder"
                    // sh "sceptre --var branch=${branch} validate dev"
                    // sh "npm test"
                }
            }
        }

        stage("Deploy Prerequisites") {
            steps {
                script {
                    echo "placeholder"
                    // sh "sceptre --var branch=${branch} ${input_params.Operation} dev/prerequisites"
                }
            }
        }

        stage("Package App") {
            when {
                expression { input_params.Operation == 'launch' }
            }
            steps {
                script {
                    echo "placeholder"
                    // sh 'npm ci'
                    
                }
            }
        }

        stage("Deploy App") {
            steps {
                script {
                    echo "placeholder"
                    // sh "sceptre --var branch=${branch} ${input_params.Operation} dev/app"
                }
            }
        }
 
    }
}