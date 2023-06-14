# Minecraft-Server
Automatically provision resources for and deploy a Minecraft Server on AWS using Terraform and Bash scripting.

## File Descriptions
### provision_ec2.tf
The Terraform configuration file **provision_ec2.tf** defines an EC2 instance that:
  - is located in us-west-2 region
  - runs the most recent Linux 2 AMI from AWS
  - uses a key pair I set up 
      - NOTE: you would need to change this to a key pair in your own AWS account to connect to the instance
  - has inbound security rules allowing ssh from anywhere and TCP connections over port 25565 
      - Minecraft communicates on port 25565
  - passes the content of script.sh to the instance through the user_data parameter
  - reports the public_ip of the EC2 instance once it's assigned

### script.sh
The Bash script **script.sh** performs the following actions:
  1. Create a "minecraft" directory.
  2. Install the most recent version of Java.
  3. Install Minecraft Server Edition.
  4. Start the Minecraft Server.
  5. Install Crontab.
  6. Configure Crontab to automatically start the Minecraft server on reboot.

## How to Execute and Connect
### Step 1. Install Terraform
Download and install the appropriate package from https://developer.hashicorp.com/terraform/downloads

### Step 2. Install the AWS CLI
Follow the instructions at https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### Step 3. Configure the AWS CLI

Upon installing the AWS CLI, a directory called .aws is created and a file called credentials is created inside it.

You will need to place your AWS access key ID and your secret access key in this file.

Instructions on how to retrieve your credentials are available at https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/getting-your-credentials.html

### Step 3. Initialize Terraform

Place the contents of this repository in their own directory.

Navigate to the directory and run `terraform init`.

This command initializes the terraform configuration, and MUST be done before attempting to execute.

### Step 4. Execute

To have terraform create the EC2 instance, use the command `terraform apply`.

It will take a minute for the EC2 instance to be created, at which point a success message "Apply complete! ..." will appear.

**Make note of the public ip address output after the success message.**

### Step 5. Connect

Open the Minecraft client and ensure you are using version 1.19.4 (newer versions may not work)

Select **Multiplayer**, then **Direct Connect**, and paste the public ip from the previous step.

Select **Connect**.

Congratulations, you are now connected to your own Minecraft server.

NOTE: It will take several minutes after terraform completes for the Minecraft server to finish booting.
