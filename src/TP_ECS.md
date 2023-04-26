---
lang: fr
pagetitle: INSSET - Master 2 Cloud Computing - TP ECS
---

[retour](index.html)

# Utilisation de ecs-cli

## Installation

voir <https://github.com/aws/amazon-ecs-cli>


## Setup

```bash
$ ecs-cli configure --region us-east-1 -p socool -c clusterbertrand
```


## Création du cluster

D'abord un keypair

```bash
$ aws ec2 create-key-pair --key-name bertrand
```
```json
{
    "KeyPair": {
        "KeyMaterial": "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAgDbY5Hzlv+wP4nTVXkwRHemd3/OLo/O6u+kI2UloHqN6mZLP+XoFcEAmNmM0\n3sA/mfv0B9fKktSUqnAEPlygS35P1xJhUXqvdFhh4m7mF+D7naPPHWcg581sdhfqEQU1uMcFq+14\nfTgkQRCLkoNNsf3c4O1KxhJ6etHFxcqr/V104PnOPGlWWni+kIMyMP/+CvzzKCZkkL/EUk6LDH4T\nHqG4nDmEd4u0oNPakWd1nX26hfYN61IhkNedtqU9CnJPHBFRbl+BZbllB4ZkxYn6QHi5t7J0Lj26\nruq6URfKLIO4ZOcZ35ZARSFB4nYtU6tbw78sE0jJqZ6ibwHyPhw8fwIDAQABAoIBAEGs1pjjqUQQ\nBWr4cbslt7bczfPDawoGdOaATfoPcfgPwWMdIs8lw9dl5K0DUDexvmJ//tZtoORpY+WSD3pqM+m3\nv+npDlSQRYORKkK0j8Q3iGuNVzA2fVJ/lUlAorMpOgV2XN9eetOZiGiTswrPm2LLKPNGWYDwQjDb\ndzUDxem300kdPZcGiiW6OIIF39s0cHdYSurLlfFGBgT1YZUQQI8AyAZOA/uI5gzlXHo6pmOGc61Y\nnIGqAYV3k8eCsEag9XMyrAih1DiuSMEUzwXImPHuFQTB/Z28rhPPbdQ3mioHJBRDn3wGRz233q44\n5ZHGsi/XdeA2oNAIIg+20LFVhdECgYEA1jnngYbv30JPO/IAQdAjM4r4bV5adqQRhsZFeFcjI1pL\n6JXHnuBBN69z5liCICRLfWHtEwUXDbt/9tZmmG6Qp5SZdPSncmAbzsDuA7nKKrnhdoNDw4V8MN++\n+Hn+T0ezJp8dXNB3EnDiLvO71sunJMTAIxKjPejFG6SsqALWrSMCgYEAmTdB1XgOCdgl3P+8/Og0\nM3qwZGTbX641ug30QBgYmDKA3D+vLRBeGtxU+j/y41Ah2W016amtdM7KgMTVdB0ZjSR70TmaETrD\nkW449q0J/UrH9DmcOpUf8qVS8QwG/fhH/VElLKiWGitulHrZPVSSBomLpJKOUzHnSGl6ZO+m7vUC\ngYA5YVUjGpORh19VvSJYfnmPSr/z+3vbn2KaaO0eqKhexcbjS4smgQa29aXjov1nwpD9yocHuytL\noFdMNG1SkvroCCN6cjWPqzKHlKGsGc2O2C8N4Wb7Lfvv016Bi5uUfK39wEzLGYNrSxUqYlqD1BS3\nAoQ8YLec04ZIOzmL3wbFZQKBgHAeZYim3+8IQzzj0BJqgbiiMW5l97qeqyZJi9FTULwfSPjjiXc6\noQKa9XxjS4RYYUzQhEFHL21o3fs5DtJ3cPk+F3VV545wKCjGNd0dZ0/5ZzUq605bThOsM3O9T2iO\nRW/z73YssBraaYMyGsKsnmc2Q//cV1Y+EHeG6E/wp4H5AoGAT/jpdHo6hjYDd6z8WJT6zuyecT39\nl4oB72CO6PCJXLLtTj85brYLP6mZyecOvD4a7Zr97NcmA4aUZtv7ERHoHSRhyOm1ePHaV2i7JFfo\nHvc01+KCAJPx8txqvHvqKfNm2aMeok7FVPSB1vbdgnBRnGJiqYQ5GgrxH0Gc3DXTG7A=\n-----END RSA PRIVATE KEY-----",
        "KeyName": "MyKeyPair",
        "KeyFingerprint": "24:86:89:71:68:af:3e:00:49:15:96:06:2d:f3:2e:96:da:66:6e:d8"
    }
}

```

Le tout dans un ficher pem qui va bien, en chmod 600.


On lance le cluster ECS, la commande mettant en place ce qu'il faut côte IAM.

```bash
$ ecs-cli up --keypair bertrand --capability-iam --size 1
INFO[0000] Created cluster                               cluster=clusterbertrand
INFO[0000] Waiting for your cluster resources to be created
INFO[0001] Cloudformation stack status                   stackStatus=CREATE_IN_PROGRESS
INFO[0061] Cloudformation stack status                   stackStatus=CREATE_IN_PROGRESS
INFO[0121] Cloudformation stack status                   stackStatus=CREATE_IN_PROGRESS
INFO[0182] Cloudformation stack status                   stackStatus=CREATE_IN_PROGRESS

```

Un petit fichier `docker-compose.yml`

```yaml
web:
  image: nginx
  ports:
    - "80:80"
```

On lance le tout

```bash
$ ecs-cli compose up
INFO[0000] Using ECS task definition                     TaskDefinition=ecscompose-ecs:2
INFO[0000] Starting container...                         container=a7c98d92-a006-4739-8976-9a5a4ffee693/web
INFO[0000] Describe ECS container status                 container=a7c98d92-a006-4739-8976-9a5a4ffee693/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition=ecscompose-ecs:2
INFO[0012] Describe ECS container status                 container=a7c98d92-a006-4739-8976-9a5a4ffee693/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition=ecscompose-ecs:2
INFO[0018] Started container...                          container=a7c98d92-a006-4739-8976-9a5a4ffee693/web desiredStatus=RUNNING lastStatus=RUNNING taskDefinition=ecscompose-ecs:2

```


## Exploration de notre cluster via l'API

Tout y est ?

```bash
$ ecs-cli compose ps
Name                                      State                Ports                    TaskDefinition
a7c98d92-a006-4739-8976-9a5a4ffee693/web  RUNNING              52.30.91.147:80->80/tcp  ecscompose-ecs:2

```

Avec la cli AWS :

```bash
$ aws ecs list-container-instances --cluster clusterbertrand
```
```json
{
    "containerInstanceArns": [
        "arn:aws:ecs:eu-west-1:363281493319:container-instance/89b4b0c4-a18b-4fe6-ac44-bcfa63e9c178"
    ]
}
```

On récupère les détails

```bash
$ aws ecs describe-container-instances --cluster clusterbertrand --container-instances arn:aws:ecs:eu-west-1:363281493319:container-instance/89b4b0c4-a18b-4fe6-ac44-bcfa63e9c178
```
```json
{
    "failures": [],
    "containerInstances": [
        {
            "status": "ACTIVE",
            "registeredResources": [
                {
                    "integerValue": 1024,
                    "longValue": 0,
                    "type": "INTEGER",
                    "name": "CPU",
                    "doubleValue": 0.0
                },
                {
                    "integerValue": 996,
                    "longValue": 0,
                    "type": "INTEGER",
                    "name": "MEMORY",
                    "doubleValue": 0.0
                },
                {
                    "name": "PORTS",
                    "longValue": 0,
                    "doubleValue": 0.0,
                    "stringSetValue": [
                        "22",
                        "2376",
                        "2375",
                        "51678"
                    ],
                    "type": "STRINGSET",
                    "integerValue": 0
                },
                {
                    "name": "PORTS_UDP",
                    "longValue": 0,
                    "doubleValue": 0.0,
                    "stringSetValue": [],
                    "type": "STRINGSET",
                    "integerValue": 0
                }
            ],
            "ec2InstanceId": "i-1f6500a6",
            "agentConnected": true,
            "containerInstanceArn": "arn:aws:ecs:eu-west-1:363281493319:container-instance/89b4b0c4-a18b-4fe6-ac44-bcfa63e9c178",
            "pendingTasksCount": 0,
            "remainingResources": [
                {
                    "integerValue": 1024,
                    "longValue": 0,
                    "type": "INTEGER",
                    "name": "CPU",
                    "doubleValue": 0.0
                },
                {
                    "integerValue": 484,
                    "longValue": 0,
                    "type": "INTEGER",
                    "name": "MEMORY",
                    "doubleValue": 0.0
                },
                {
                    "name": "PORTS",
                    "longValue": 0,
                    "doubleValue": 0.0,
                    "stringSetValue": [
                        "22",
                        "2376",
                        "2375",
                        "80",
                        "51678"
                    ],
                    "type": "STRINGSET",
                    "integerValue": 0
                },
                {
                    "name": "PORTS_UDP",
                    "longValue": 0,
                    "doubleValue": 0.0,
                    "stringSetValue": [],
                    "type": "STRINGSET",
                    "integerValue": 0
                }
            ],
            "runningTasksCount": 1,
            "versionInfo": {
                "agentVersion": "1.4.0",
                "agentHash": "4ab1051",
                "dockerVersion": "DockerVersion: 1.7.1"
            }
        }
    ]
}
```

Chouette, on a l'id de l'instance :

on va :

- récupérer ses informations (id du security-group, et ip publique),
- ouvrir le port 22 du bon security-group,
- puis s'y connecter en ssh


```bash
$ aws ec2 describe-instances --instance-ids i-1f6500a6
```
```json
{
    "Reservations": [
        {
            "OwnerId": "363281493319",
            "ReservationId": "r-1c27dbb1",
            "Groups": [],
            "RequesterId": "226008221399",
            "Instances": [
                {
                    "Monitoring": {
                        "State": "enabled"
                    },
                    "PublicDnsName": "",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "EbsOptimized": false,
                    "LaunchTime": "2015-10-14T12:25:45.000Z",
                    "PublicIpAddress": "52.30.91.147",
                    "PrivateIpAddress": "10.0.1.68",
                    "ProductCodes": [],
                    "VpcId": "vpc-5cd2a239",
                    "StateTransitionReason": "",
                    "InstanceId": "i-1f6500a6",
                    "ImageId": "ami-bd5572ca",
                    "PrivateDnsName": "ip-10-0-1-68.eu-west-1.compute.internal",
                    "KeyName": "bertrand",
                    "SecurityGroups": [
                        {
                            "GroupName": "amazon-ecs-cli-setup-clusterbertrand-EcsSecurityGroup-15YBT38MUE27S",
                            "GroupId": "sg-cc8621a8"
                        }
                    ],
                    "ClientToken": "a5958eee-691a-47c7-8073-4d3e816145c4_subnet-6fbff018_1",
                    "SubnetId": "subnet-6fbff018",
                    "InstanceType": "t2.micro",
                    "NetworkInterfaces": [
                        {
                            "Status": "in-use",
                            "MacAddress": "06:69:a3:84:71:5b",
                            "SourceDestCheck": true,
                            "VpcId": "vpc-5cd2a239",
                            "Description": "",
                            "Association": {
                                "PublicIp": "52.30.91.147",
                                "PublicDnsName": "",
                                "IpOwnerId": "amazon"
                            },
                            "NetworkInterfaceId": "eni-5fede116",
                            "PrivateIpAddresses": [
                                {
                                    "Association": {
                                        "PublicIp": "52.30.91.147",
                                        "PublicDnsName": "",
                                        "IpOwnerId": "amazon"
                                    },
                                    "Primary": true,
                                    "PrivateIpAddress": "10.0.1.68"
                                }
                            ],
                            "Attachment": {
                                "Status": "attached",
                                "DeviceIndex": 0,
                                "DeleteOnTermination": true,
                                "AttachmentId": "eni-attach-7618995a",
                                "AttachTime": "2015-10-14T12:25:45.000Z"
                            },
                            "Groups": [
                                {
                                    "GroupName": "amazon-ecs-cli-setup-clusterbertrand-EcsSecurityGroup-15YBT38MUE27S",
                                    "GroupId": "sg-cc8621a8"
                                }
                            ],
                            "SubnetId": "subnet-6fbff018",
                            "OwnerId": "363281493319",
                            "PrivateIpAddress": "10.0.1.68"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Placement": {
                        "Tenancy": "default",
                        "GroupName": "",
                        "AvailabilityZone": "eu-west-1b"
                    },
                    "Hypervisor": "xen",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/xvda",
                            "Ebs": {
                                "Status": "attached",
                                "DeleteOnTermination": true,
                                "VolumeId": "vol-91656861",
                                "AttachTime": "2015-10-14T12:25:48.000Z"
                            }
                        }
                    ],
                    "Architecture": "x86_64",
                    "RootDeviceType": "ebs",
                    "IamInstanceProfile": {
                        "Id": "AIPAIZMRHCSW647CQZS2O",
                        "Arn": "arn:aws:iam::363281493319:instance-profile/amazon-ecs-cli-setup-clusterbertrand-EcsInstanceProfile-1NTWI5PBFF7VS"
                    },
                    "RootDeviceName": "/dev/xvda",
                    "VirtualizationType": "hvm",
                    "Tags": [
                        {
                            "Value": "ECS Instance - amazon-ecs-cli-setup-clusterbertrand",
                            "Key": "Name"
                        },
                        {
                            "Value": "arn:aws:cloudformation:eu-west-1:363281493319:stack/amazon-ecs-cli-setup-clusterbertrand/56a7e180-726e-11e5-8a57-50d5026fd80a",
                            "Key": "aws:cloudformation:stack-id"
                        },
                        {
                            "Value": "amazon-ecs-cli-setup-clusterbertrand",
                            "Key": "aws:cloudformation:stack-name"
                        },
                        {
                            "Value": "EcsInstanceAsg",
                            "Key": "aws:cloudformation:logical-id"
                        },
                        {
                            "Value": "amazon-ecs-cli-setup-clusterbertrand-EcsInstanceAsg-6U22V91VFXIO",
                            "Key": "aws:autoscaling:groupName"
                        }
                    ],
                    "AmiLaunchIndex": 0
                }
            ]
        }
    ]
}
```

Le security group :

```
$ aws ec2 authorize-security-group-ingress --group-id sg-cc8621a8 --protocol tcp --port 22 --cidr 0.0.0.0/0
```

Et enfin la connexion ssh.

```bash
$ ssh -i ~/key_socool.pem ec2-user@52.30.91.147 -v
...
...
   __|  __|  __|
   _|  (   \__ \   Amazon ECS-Optimized Amazon Linux AMI 2015.03.g
 ____|\___|____/

For documentation visit, http://aws.amazon.com/documentation/ecs
No packages needed for security; 1 packages available
Run "sudo yum update" to apply all updates.
Amazon Linux version 2015.09 is available.
[ec2-user@ip-10-0-1-68 ~]$ docker ps
CONTAINER ID        IMAGE                            COMMAND                CREATED             STATUS              PORTS                         NAMES
9732b396c0a6        nginx                            "nginx -g 'daemon of   19 minutes ago      Up 19 minutes       0.0.0.0:80->80/tcp, 443/tcp   ecs-ecscompose-ecs-2-web-b88e8086a6ebd8cc7d00
c43b03609b14        amazon/amazon-ecs-agent:latest   "/agent"               20 minutes ago      Up 20 minutes       127.0.0.1:51678->51678/tcp    ecs-agent
```

Ca marche !!! Les logs du nginx ?

```bash
$ docker logs --follow 9732b396c0a6
```
```accesslog
62.23.47.98 - - [14/Oct/2015:12:49:26 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0" "-"
2015/10/14 12:49:26 [error] 12#12: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 62.23.47.98, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "52.30.91.147"
62.23.47.98 - - [14/Oct/2015:12:49:26 +0000] "GET /favicon.ico HTTP/1.1" 404 168 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0" "-"
2015/10/14 12:49:26 [error] 12#12: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 62.23.47.98, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "52.30.91.147"
62.23.47.98 - - [14/Oct/2015:12:49:26 +0000] "GET /favicon.ico HTTP/1.1" 404 168 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0" "-"


```

Et voilà !


## On ferme tout

Brutalement :

```bash
$ ecs-cli down --force
INFO[0000] Waiting for your cluster resources to be deleted
INFO[0001] Cloudformation stack status                   stackStatus=DELETE_IN_PROGRESS
INFO[0061] Cloudformation stack status                   stackStatus=DELETE_IN_PROGRESS
INFO[0122] Cloudformation stack status                   stackStatus=DELETE_IN_PROGRESS
INFO[0182] Deleted cluster                               cluster=clusterbertrand

```

---

#### Licence

Cette œuvre est mise à disposition selon les termes de la Licence [Creative Commons Attribution 3.0 France](https://creativecommons.org/licenses/by/3.0/fr/).

[![Licence Creative Commons](https://i.creativecommons.org/l/by/3.0/fr/88x31.png)](https://creativecommons.org/licenses/by/3.0/fr/)
