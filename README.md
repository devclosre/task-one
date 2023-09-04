# Task1: Create a VPC with Nginx as Webserver using Lauch Configuration, and in Auto Scaling Group
1. Created a VPC: Ntier-VPC with three public and private subnets in ap-southeast-4
   ![image](https://github.com/devclosre/task-one/assets/143948725/eef82c1e-9161-4986-823f-a6e16a076ee9)

2. All the three public subnets are connected to Public Route Table: Ntier-Public-rt
  ![image](https://github.com/devclosre/task-one/assets/143948725/b7c94c79-8762-4134-8c81-189edb693c2c)

3. The Ntier-Public-rt has a route to the Ntier-IGW, which makes it truly public subnet not just the name
   ![image](https://github.com/devclosre/task-one/assets/143948725/054cdc0f-96be-4803-9b29-2a29fe928dbf)

5. The Route table has three subnet association, ie all three Public Subnets
   ![image](https://github.com/devclosre/task-one/assets/143948725/19028b42-8960-408c-bf1b-775b28076451)

6.  Ntier-IGW is attached to Ntier-VPC
    ![image](https://github.com/devclosre/task-one/assets/143948725/3925f9d1-4003-40e4-85d7-c7007d65fa7c)

7. Now we need a SG to allow inboud and outbound traffic to the Instance in the ASG.
8. We have opened port 22 for SSH, 80 for HTTP traffic and 443 for HTTPS traffic.
   ![image](https://github.com/devclosre/task-one/assets/143948725/a2a3d6a2-e260-4ad9-93bb-290db631ff20)
   
   ![image](https://github.com/devclosre/task-one/assets/143948725/8ae7f047-d09d-4c9b-b443-8722ec6b6a0c)
   
9. Our Nginx server is in ASG and this Nginx Server is created using userdata in Launch Configuration.
   ![image](https://github.com/devclosre/task-one/assets/143948725/b4b5723f-ee4e-4122-9c75-e91bf9468a58)

   ![image](https://github.com/devclosre/task-one/assets/143948725/765fb9f1-bc2b-4679-a5a3-7cd969f3751c)


   
   
11. We can see that the Nginx server is deployed inside Public Subnet-1 of Ntier VPC and there is a public ip assigned to it.
   ![image](https://github.com/devclosre/task-one/assets/143948725/cd87493a-8131-44f1-be72-a784c6611828)

    
13. We are able to access the Nginx server that serves "Hello World" as it main page, which is created using
    Launch configuration and in Auto Scaling Group.
    ![image](https://github.com/devclosre/task-one/assets/143948725/2d11064a-9cbc-4379-b45e-fdb970cad6ab)

    
14. To test whether Auto Scaling Feature is working or not, we have manually terminated the Instance.
    ![image](https://github.com/devclosre/task-one/assets/143948725/1e4402c3-e2f6-428b-8f48-98b73782fc11)

    
15. ASG will look for min number of instance given in the configuration and creates a new Instance or Instances
    accordingly.So it created a Nginx Instance in the one of the three public subnets.
    ![image](https://github.com/devclosre/task-one/assets/143948725/1a9176ef-9ee5-4961-84f8-f1cbeb6367d6)

    
16. We can see the new machine is launched in ap-southeast-4a and through its public ip we can access
    the "Hello World" page again when we enter the ip in the browser.
    ![image](https://github.com/devclosre/task-one/assets/143948725/6630988b-b5d3-4dad-907f-75290c56a89f)

    
17. So whenever there is a termination of Instance or new instance created and so on, a notification
    will be send to email via SNS notification service.
    ![image](https://github.com/devclosre/task-one/assets/143948725/92fbe633-6c38-408d-87dc-a52c349a1023)

    
    
18. Subscriber needs to confirm the subscription to receive the email notification.
    ![image](https://github.com/devclosre/task-one/assets/143948725/bdd85c3d-e7be-46a0-8265-38954d1d1bf5)

    
20. Cost-Optimisation is achieved via cutting down on the number of running servers during non-business hours.
    ![image](https://github.com/devclosre/task-one/assets/143948725/f239f51e-1448-4e52-bc59-a5400bec613f)

    
21. Terraform configuration files used for Task1:
    ![image](https://github.com/devclosre/task-one/assets/143948725/31c9e1ca-4d57-4453-a8af-c04f52287c6d)

    
22. # Terraform workflow:
      Terraform workflow starts with creating the configuration files, then:
    
      terraform init --> Downloads the provider and install any backend.
    
      terraform validate --> Validates check for syntax errors.
    
      terraform plan --> Preview changes before applying.
    
      terraform apply --> Provision reproducible infrastructure.
    
      ![image](https://github.com/devclosre/task-one/assets/143948725/71aab6f9-571c-4c1d-bb3e-7868fdcdfe5f)

    
      terraform destroy --> Destroy the provisioned infrastructure.
    
     ![image](https://github.com/devclosre/task-one/assets/143948725/117583b4-75ce-47dd-8cfa-4f9242181cc4)



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









    


    





    





   



