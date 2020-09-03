# IAM Role for EC2. 

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "Ec2_Instance_profile"
  role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_role_policy" "ec2_ssm_policy" {
  name = "EC2_SSM_policy"
  role = aws_iam_role.ec2_ssm_role.id
  policy = file("iam-policies/ec2-ssm-policy.json")
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "EC2_SSM_Role"
  assume_role_policy = file("iam-policies/ec2-assume-policy.json")
}

# IAM Role for Lambda. 

resource "aws_iam_role_policy" "lambda_ssm_policy" {
  name = "Lambda_SSM_policy"
  role = aws_iam_role.lambda_ssm_role.id

  policy = file("iam-policies/lambda-ssm-policy.json")
}

resource "aws_iam_role" "lambda_ssm_role" {
  name = "Lambda_SSM_Role"
  assume_role_policy = file("iam-policies/lambda-assume-policy.json")
}