import boto3
import yaml
 
def deploy_stack(stack_name, template_body, parameters=None):
    client = boto3.client('cloudformation', region_name='us-east-1')
    try:
        response = client.create_stack(
            StackName=stack_name,
            TemplateBody=template_body,
            Parameters=parameters,
            Capabilities=['CAPABILITY_IAM']
        )
        print("Stack creation initiated. StackId:", response['StackId'])
    except client.exceptions.AlreadyExistsException:
        print("Stack already exists. Updating stack instead.")
        response = client.update_stack(
            StackName=stack_name,
            TemplateBody=template_body,
            Parameters=parameters,
            Capabilities=['CAPABILITY_IAM']
        )
        print("Stack update initiated. StackId:", response['StackId'])
 
def main():
    with open('s3_bucket.yaml', 'r') as f:
        template_body = f.read()
 
    with open('parameters.yaml', 'r') as f:
        parameters = yaml.safe_load(f)
 
    deploy_stack('MyS3BucketStack', template_body, parameters)
 
if __name__ == "__main__":
    main()