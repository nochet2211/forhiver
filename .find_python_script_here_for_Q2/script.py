#!/usr/bin/env python3

import boto3

AWS_REGION = "us-east-1"

ec2 = boto3.client('ec2',region_name=AWS_REGION)

#choosing default vpc
response_vpc = ec2.describe_vpcs(Filters=[
            {
                'Name': 'is-default',
                'Values': ['true']
        }
    ])
for r in response_vpc['Vpcs']:
    default_vpc_id = (r['VpcId'])

#choosing all m5.large instances withing default vpc
response_ec2 = ec2.describe_instances(Filters=[
            {
                'Name': 'vpc-id',
                'Values': [default_vpc_id]
            },
            {
                'Name': 'instance-type',
                'Values': ['m5.large']
            }
    ])

#printing out results
for r in response_ec2['Reservations']:
    for i in r['Instances']:
        for a in i['Tags']:
            print(a['Value'],i['InstanceId'])