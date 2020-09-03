import boto3
import os 

ssm = boto3.client('ssm')
region = 'us-east-1'
instances = os.environ['InstanceID']

def lambda_handler(event, context):
    response = ssm.send_command(
        InstanceIds=[instances],
        DocumentName='SSM-EC2-document',
        TimeoutSeconds=60,
        Comment='Print Hello World',
        Parameters={
            'commands': [
                'echo "Hello World" ',
            ]
        }
    )
