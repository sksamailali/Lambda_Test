import boto3
import random
import string
import json
import os

def generate_password(length=16):
    """Generate a strong random password."""
    chars = string.ascii_letters + string.digits + "!@#$%^&*()-_"
    return ''.join(random.choice(chars) for _ in range(length))

def lambda_handler(event, context):
    # Generate new password
    password = generate_password()
    
    # Store password in S3
    s3_client = boto3.client('s3')
    bucket = os.environ['S3_BUCKET']
    key = f"passwords/{context.aws_request_id}.json"

    s3_client.put_object(
        Bucket=bucket,
        Key=key,
        Body=json.dumps({"password": password}),
        ServerSideEncryption='aws:kms'
    )

    return {"statusCode": 200, "body": "Password rotation completed successfully"}

