#! /bin/bash

parameters=(
    VpcCidrBlock='172.100.0.0/20'
    PrimarySubnetCidrBlock='172.100.0.0/21'
    SecondarySubnetCidrBlock='172.100.8.0/21'
)
profile=jg75
bucket=jg75-sam-deploy
stack_name=vpc-lambda-s3
tempfile=$(mktemp).yml

trap 'rm $tempfile 2> /dev/null' EXIT

sam validate-template \
    --template-body "$(<template.yml)" \
  && sam build \
  && sam package \
         --profile $profile \
         --s3-bucket $bucket \
         --output-template-file $tempfile \
  && aws cloudformation deploy \
         --profile $profile \
         --template-file $tempfile \
         --stack-name $stack_name \
         --parameter-overrides "${parameters[@]}" \
         --capabilities CAPABILITY_IAM
