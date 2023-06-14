# Minecraft-Server
Automatically provision resources for and deploy a Minecraft Server on AWS.

## provision_ec2.tf
The terraform configuration file provision_ec2.tf creates an EC2 instance that:
  - is located in us-west-2 region
  - runs the most recent Linux 2 AMI
  - uses a key pair I set up (NOTE: you would need to change this to a key pair in your own AWS account to connect to the instance)
  - has inbound security rules allowing ssh from anywhere and TCP connections over port 25565 (Minecraft communicates on this port)

## script.sh
The bash script script.sh performs the following actions:
  1. 
