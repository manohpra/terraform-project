provider "aws" {
  region = "ap-south-1"
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = "ami-02b5fbc2cb28b77b8"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "MyEC2Instance"
  }
}

# Lambda Function

data "archive_file" "CodetoZip" {
  type        = "zip"
  source_file = "LambdaSSMCode.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "My_lambda_function" {
  filename      = "lambda_function_payload.zip"
  function_name = "Lambda-SSM-Function"
  role          = aws_iam_role.lambda_ssm_role.arn
  handler       = "LambdaSSMCode.lambda_handler"
  source_code_hash = data.archive_file.CodetoZip.output_base64sha256   
  runtime = "python3.8"
    environment {
    variables = {
      InstanceID = aws_instance.my_instance.id
    }
  }
}

# SSM Document

resource "aws_ssm_document" "ssm_document" {
  name          = "SSM-EC2-document"
  document_type = "Command"
  content = file("ssm-document-content.json")
}
