pipeline {
    agent any

    stage('Checkout') {
    steps {
        // No git checkout command here since it's configured in Jenkins job configuration
    }
    post {
        success {
            echo 'Checkout stage completed successfully'
        }
    }
}

        
        stage('Setup AWS Credentials') {
            environment {
                AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
            }
            steps {
                // Use withCredentials to securely access AWS credentials
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    // Execute Terraform commands within this block
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                    script {
                        PUBLIC_IP = sh(script: 'terraform output -json public_ip | jq.exe -r', returnStdout: true).trim()
                    }
                } // Close withCredentials block
            }
        }
    }
}
