#!/bin/bash 

case "$1" in 
    deploy-http)
        echo "Deploying single http instance..."
        aws cloudformation deploy --template-file http.yml --stack-name http
        echo "Public DNS Name of http instance:"
        aws ec2 describe-instances --filters 
            "Name=tag:aws:cloudformation:stack-name,Values=http" \
            "Name=instance-state-name,Values=pending,running" \
            | grep PublicDnsName | head -1 | cut -d\" -f4
    ;;

    stop-http)
        aws cloudformation delete-stack --stack-name http
    ;;

    deploy-elb)
        echo "Deploying dual http instances behind ELB..."
        aws cloudformation deploy --template-file elb.yml --stack-name elb
        echo "Public DNS Name of ELB:"
        aws elb describe-load-balancers | grep "DNSName.*nginx-static-elb" | cut -d\" -f4
    ;;

    stop-elb)
        aws cloudformation delete-stack --stack-name elb
    ;;

    *)
        echo "Usage: deploy.sh (deploy-http|stop-http|deploy-elb|stop-elb)"
    ;;
esac
