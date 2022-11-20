Instruction to deploy the stack 

* clone this repo 
* install terraform binary on the instance
* use ```terrafrom init && terraform plan && terraform apply```


## How to use your own keys? 

As per the code block in our terraform 

```
#creating key pair
resource "aws_key_pair" "keypair" {
    key_name="terraformkey"
    public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDR61VusN1H0JMxgqlFbNF9GVdSMFylK5j/ED7udWAEo2RrMcfrEcb8JccH3ld/pctcogGLGEXm+R47nv6eR6AJ0ZS2u5NHJFOfe1SxwZxJRP1fNsuOr2fJrbZoHxE0h4kyZZoCzpvdiFekgUY3BFnugKqv3PEkSzSpDqdE9o/eEnEtbpCoktBqru4uvsygwoV2vXDFR2WkE9h45b2ibIn2tfQQlS1mwHiaCv2Qjaqtg+fRomv23ZpUj2OiJ1j4JBNhVazU3PBSjlGk90+ycGwRFLJz91hWiTwSkghM1zvtcWKlW4juW+21zd5xnNbs/eaHGSVxGcauaWRY4NnG2X3 ec2-user@ip-172-31-89-157.ec2.internal"
}

```
The public_key is your own instance corresponding key pair of the private key, If you do not have one already please follow the steps and use it on the terraform configuration file. 


```
# ssh-keygen (Press enter to use your default location)
# Do not set up any key phrase leave it empty 
# cat ~/.ssh/id_rsa.pub (copy this public key and paste it on the main.tf public_key section)
```

## This terraform written to use Jenkins instance directly without need of configuring anything, So after apply grab the public ip and use ip:8080 to access the Jenkins