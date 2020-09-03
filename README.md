# terraform-project
Terraform script which will provision EC2, Lambda and SSM document in AWS. 
Lambda will invoke the SSM document by passing it the EC2 instance-id. 
SSM Document will run the command ‘echo “hello world”’ on the target EC2 machine received from the Lambda.
