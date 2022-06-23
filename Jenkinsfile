pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {
        stage('Git clone') {
           steps{
                git branch: 'main', credentialsId: 'Github', url: 'https://github.com/ricfdez/iac-ans-tf-jnks'
            }
        }
        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }


}
