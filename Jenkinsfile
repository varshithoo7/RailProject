pipeline {
    agent any

     environment {
                AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
            }

    stages {
        stage('Checkout') {
            steps {
                     echo 'Performing Checkout'
    }
    post {
        success {
            echo 'Checkout stage completed successfully'
        }
    }
}

        
        stage('Setup AWS Credentials') {
            
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

        stage('SSH into Instance') {
            steps{
                script
                {
                    // Use SSH Agent plugin to SSH into the instance
            sshagent(['AWS_SSH_CREDENTIALS_ID']) {
                        sh "ssh -vvv -i C:/Users/SuperMan/Desktop/Kp.pem ec2-user@${PUBLIC_IP}"
        }
            }
        }
        }
    }

     post {
       
            // Change directory to RailProject
            dir('RailProject') {
                // Run Main.py using Python 3
                sh 'python3 Main.py'
            }
        
    }
}


    