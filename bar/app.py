from os import getenv
from logging import getLogger, INFO

import boto3


s3_client = boto3.client("s3")
s3_bucket = getenv("S3_BUCKET")
s3_key = getenv("S3_KEY")
logger = getLogger()

logger.setLevel(INFO)


def handler(event, context):
    response = s3_client.get_object(
        Bucket=s3_bucket,
        Key=s3_key
    )

    logger.info(response)

    return {
        "statusCode": "200",
        "body": "OK"
    }
