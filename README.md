# Task1: Create a VPC with Nginx as Webserver using Lauch Configuration, and in Auto Scaling Group
1. Created a VPC: Ntier-VPC with three public and private subnets in ap-southeast-4
   ![image](https://github.com/devclosre/task1/assets/143948725/a3b4e90f-8244-4526-b495-10ba17e1d5f2)
2. All the three public subnets are connected to Public Route Table: Ntier-Public-rt
   ![image](https://github.com/devclosre/task1/assets/143948725/6f5eaf18-2dd8-4853-902b-d28c902f4ed5)
3. The Ntier-Public-rt has a route to the Ntier-IGW, which makes it truly public subnet not just the name
4. The Route table has three subnet association, ie all three Public Subnets
   ![image](https://github.com/devclosre/task1/assets/143948725/c616960f-2928-4f2e-85ef-9f14a3e54b55)
5.  Ntier-IGW is attached to Ntier-VPC
    ![image](https://github.com/devclosre/task1/assets/143948725/ebaf9d41-5900-4771-be2d-3ad16df2a8dd)
6. Now we need a SG to allow inboud and outbound traffic to the Instance in the ASG.
7. We have opened port 22 for SSH, 80 for HTTP traffic and 443 for HTTPS traffic
   ![image](https://github.com/devclosre/task1/assets/143948725/7f1c8ed3-8270-4c7e-9278-e1a16a0f07b4)
   ![image](https://github.com/devclosre/task1/assets/143948725/9b361605-7a4b-4ed5-98ac-1826ff06bbec)
9. Our Nginx server is in ASG and this Nginx Server is created using userdata in Launch Configuration.
   
    ![image](https://github.com/devclosre/task1/assets/143948725/fa4bf29f-c6f3-48aa-bc6c-4ca846494f70)
   ![image](https://github.com/devclosre/task1/assets/143948725/15c00c92-817e-48b7-8813-6f98cf02f708)
10. We can see that the Nginx server is deployed inside Public Subnet-1 of Ntier VPC and there is a public ip assigned to it.
11. We are able to access the Nginx server that serves "Hello World" as it main page, which is created using
    Launch configuration and in Auto Scaling Group.
    
    ![image](https://github.com/devclosre/task1/assets/143948725/ca55a6a5-f0a4-41cd-91e1-0c21eae5dc8b)
12. To test whether Auto Scaling Feature is working or not, we have manually terminated the Instance.
    ![image](https://github.com/devclosre/task1/assets/143948725/935c30e4-023b-47f8-bef9-e4f765f48c6e)
13. ASG will look for min number of instance given in the configuration and creates a new Instance or Instances
    accordingly.So it created a Nginx Instance in the one of the three public subnets.
    
    ![image](https://github.com/devclosre/task1/assets/143948725/9dd651f9-1cf2-4b00-ab1c-2ce04ef0c0cd)
15. We can see the new machine is launched in ap-southeast-4a and through its public ip we can access
    the "Hello World" page again when we enter the ip in the browser.
    ![image](https://github.com/devclosre/task1/assets/143948725/b9e23913-82ad-4bcc-ab65-15c606e13912)
16. So whenever there is a termination of Instance or new instance created and so on, a notification
    will be send to email via SNS notification service.
    ![image](https://github.com/devclosre/task1/assets/143948725/13bf9ea5-e60a-4943-a0c0-23ed0070245f)

    ![image](https://github.com/devclosre/task1/assets/143948725/815deba7-d5b4-4dc3-a475-601fcc4b2156)
18. Subscriber needs to confirm the subscription to receive the email notification.
    ![image](https://github.com/devclosre/task1/assets/143948725/bf46b72c-8154-4ab9-aaed-046957709771)
19. Cost-Optimisation is achieved via cutting down on the number of running servers during non-business hours.
    ![image](https://github.com/devclosre/task1/assets/143948725/6b46afcc-2ab4-4157-ab6b-4d7caffb7cd4)
    
20. Terraform configuration files used for Task1:
    ![image](https://github.com/devclosre/task1/assets/143948725/55cbdc9e-001e-4a7f-a28d-08b32f31495b)
    
22. # Terraform workflow:
      Terraform workflow starts with creating the configuration files, then:
    
      terraform init --> Downloads the provider and install any backend.
    
      terraform validate --> Validates check for syntax errors.
    
      terraform plan --> Preview changes before applying.
    
      terraform apply --> Provision reproducible infrastructure.
    
    ![image](https://github.com/devclosre/task1/assets/143948725/0142f08e-b402-4033-bab0-bdfc24eef03b)
    
      terraform destroy --> Destroy the provisioned infrastructure.
    
    ![image](https://github.com/devclosre/task1/assets/143948725/2fba2420-5835-4e11-8646-0bdef5499ae0)


    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    # Task3: Using Ansible update the Home page of the Nginx server from "Hello World" to "Hello World from Ansible"
    1. In the Task, by using terraform we have created another server which acts as a Ansible Control Machine.
       ![image](https://github.com/devclosre/task1/assets/143948725/fe3697c7-6ff5-4358-80d1-b1d83c85d468)

    2. We are considering Nginx server in ASG as Node machine to Ansible Control Machine.
       We need to setup Passwordless Authentication between Ansible server and Nginx server, but by default AWS does not support
       Password Authentication, so we have to enable it on both the machine.
    3. First create a user called "devops", set a password and give him sudo permissions by going into visudo.
       ![image](https://github.com/devclosre/task1/assets/143948725/20d4693a-e350-48c9-9050-74c8a66c4cca)
       ![image](https://github.com/devclosre/task1/assets/143948725/10b7cc30-2480-41a5-9ff6-5b3c7918be58)

    4. Next step would be enable Password Authentication and PubkeyAuthentication from "/etc/ssh/sshd_config" 
       ![image](https://github.com/devclosre/task1/assets/143948725/ae5325b2-c3f2-430d-bd48-1d12cd1e5c44)
       ![image](https://github.com/devclosre/task1/assets/143948725/b88bc63c-91f1-48bc-9431-81f847b9779d)

       Once the changes are done reload sshd service.

       ![image](https://github.com/devclosre/task1/assets/143948725/ea9686a6-4207-4011-a282-d581024150f0)

    6. Now create a key pair using "ssh-keygen" and the keys will be store in "~/.ssh/id_rsa and id_rsa.pub"
       ![image](https://github.com/devclosre/task1/assets/143948725/30410dbc-1dbc-4900-b610-234528de3e90)

       

    7. Using "ssh-copy-id" copy the public key to Nginx server which is added as a host in the Ansible Control Machine
       Inventory file - "/etc/ansible/hosts". As the public key is copied to the Nginx server as the Passwordless Authentication
       is set between the Ansible Control Machine and Nginx server.

    8. Now we can see the Nginx server is still serving "Hello World"
       ![image](https://github.com/devclosre/task1/assets/143948725/d8d776d1-57b6-47d3-be01-bb7a502b4255)

    9. For testing the connection between both the machine, we do a basic ping using adhoc command:
       ![image](https://github.com/devclosre/task1/assets/143948725/127f4b32-a625-48cd-b4b3-38433aed4feb)

    10. Now with update_nginx.yml and index.html, we will use the following command to update the Nginx server from "Hello World" to
        "Hello World to Ansible"
        
       ![image](https://github.com/devclosre/task1/assets/143948725/4cac7200-7e9c-441d-832d-bb4bd0319483)

       ![image](https://github.com/devclosre/task1/assets/143948725/96209de6-8ff9-4786-9363-99601a8d1daf)

    11. Upon successful execution of the playbook we can now see "Hello World from Ansible" as the Nginx server is reloaded using hanlders task,
        which gets notified by some copy task.
        
        ![image](https://github.com/devclosre/task1/assets/143948725/af6999a9-097b-467a-9651-326aaabbf7ca)









    


    





    





   



