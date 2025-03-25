import json
import urllib.request
import os

def lambda_handler(event, context):
    slack_webhook_url = os.environ['SLACK_WEBHOOK_URL']
    sns_message = event['Records'][0]['Sns']['Message']
    slack_message = {
        "text": sns_message
    }
    req = urllib.request.Request(
        slack_webhook_url,
        data=json.dumps(slack_message).encode('utf-8'),
        headers={'Content-Type': 'application/json'}
    )
    try:
        urllib.request.urlopen(req)
        return {
            'statusCode': 200,
            'body': json.dumps('Successfully sent to Slack')
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }