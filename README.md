## Overview
A sample template for CloudFormation to deploy a simple nginx server that serves a static web page.

### Assumptions
- aws cli is installed and configured with your AWS account
- You have a set of ssh keys named "*MyKeys*"
- You have not modified the default VPC/subnets

### How-to deploy
Run ./deploy.sh (deploy-http|stop-http|deploy-elb|stop-elb)
- deploy-http: Will start a single EC2 http instance to serve index.html and return the DNS name of that instance
- stop-http: Deletes the stack created by the above command
- deploy-elb: Will start two EC2 http instances behind an ELB to serve index.html and return the DNS name of that load balancer
- stop-elb: Stops the stack created by the above command

### How to update
- Update index.html as necessary and build the image on Docker Hub (this repo is automatically built here: docker.com/r/sparkd/nginx-staticfile/)
- Redeploy the stack
