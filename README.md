Task1: Create a VPC with Nginx as Webserver using Lauch Configuration, and in Auto Scaling Group
Created a VPC: Ntier-VPC with three public and private subnets in ap-southeast-4 image

All the three public subnets are connected to Public Route Table: Ntier-Public-rt image

The Ntier-Public-rt has a route to the Ntier-IGW, which makes it truly public subnet not just the name

The Route table has three subnet association, ie all three Public Subnets image

Ntier-IGW is attached to Ntier-VPC image

Now we need a SG to allow inboud and outbound traffic to the Instance in the ASG.

We have opened port 22 for SSH, 80 for HTTP traffic and 443 for HTTPS traffic image image

Our Nginx server is in ASG and this Nginx Server is created using userdata in Launch Configuration.

image image

We can see that the Nginx server is deployed inside Public Subnet-1 of Ntier VPC and there is a public ip assigned to it.

We are able to access the Nginx server that serves "Hello World" as it main page, which is created using Launch configuration and in Auto Scaling Group.

image

To test whether Auto Scaling Feature is working or not, we have manually terminated the Instance. image

ASG will look for min number of instance given in the configuration and creates a new Instance or Instances accordingly.So it created a Nginx Instance in the one of the three public subnets.

image

We can see the new machine is launched in ap-southeast-4a and through its public ip we can access the "Hello World" page again when we enter the ip in the browser. image

So whenever there is a termination of Instance or new instance created and so on, a notification will be send to email via SNS notification service. image

image

Subscriber needs to confirm the subscription to receive the email notification. image

Cost-Optimisation is achieved via cutting down on the number of running servers during non-business hours. image

Terraform configuration files used for Task1: image

Terraform workflow:
Terraform workflow starts with creating the configuration files, then:

terraform init --> Downloads the provider and install any backend.

terraform validate --> Validates check for syntax errors.

terraform plan --> Preview changes before applying.

terraform apply --> Provision reproducible infrastructure.

image

terraform destroy --> Destroy the provisioned infrastructure.

image

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Task3: Using Ansible update the Home page of the Nginx server from "Hello World" to "Hello World from Ansible"
In the Task, by using terraform we have created another server which acts as a Ansible Control Machine. image

We are considering Nginx server in ASG as Node machine to Ansible Control Machine. We need to setup Passwordless Authentication between Ansible server and Nginx server, but by default AWS does not support Password Authentication, so we have to enable it on both the machine.

First create a user called "devops", set a password and give him sudo permissions by going into visudo. image image

Next step would be enable Password Authentication and PubkeyAuthentication from "/etc/ssh/sshd_config" image image

Once the changes are done reload sshd service.

image

Now create a key pair using "ssh-keygen" and the keys will be store in "~/.ssh/id_rsa and id_rsa.pub" image

Using "ssh-copy-id" copy the public key to Nginx server which is added as a host in the Ansible Control Machine Inventory file - "/etc/ansible/hosts". As the public key is copied to the Nginx server as the Passwordless Authentication is set between the Ansible Control Machine and Nginx server.

Now we can see the Nginx server is still serving "Hello World" image

For testing the connection between both the machine, we do a basic ping using adhoc command: image

Now with update_nginx.yml and index.html, we will use the following command to update the Nginx server from "Hello World" to "Hello World to Ansible"

image

image

Upon successful execution of the playbook we can now see "Hello World from Ansible" as the Nginx server is reloaded using hanlders task, which gets notified by some copy task.

image