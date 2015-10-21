La doc en ligne
---------------

http://docs.aws.amazon.com/cli/latest/reference/



Installer AWS CLI
-----------------

Pour info : https://github.com/aws/aws-cli

```bash

($ sudo apt-get install -y python-pip)
$ sudo pip install awscli
...

$ aws configure
...

$ cat ~/.aws/config
[default]
aws_access_key_id = <access key id>
aws_secret_access_key = <secret access key>
region = us-east-1

$ aws ec2 describe-regions
{
    "Regions": [
        {
            "Endpoint": "ec2.eu-west-1.amazonaws.com",
            "RegionName": "eu-west-1"
        },
        {
            "Endpoint": "ec2.sa-east-1.amazonaws.com",
            "RegionName": "sa-east-1"
        },
        {
            "Endpoint": "ec2.us-east-1.amazonaws.com",
            "RegionName": "us-east-1"
        },
        {
            "Endpoint": "ec2.ap-northeast-1.amazonaws.com",
            "RegionName": "ap-northeast-1"
        },
        {
            "Endpoint": "ec2.us-west-2.amazonaws.com",
            "RegionName": "us-west-2"
        },
        {
            "Endpoint": "ec2.us-west-1.amazonaws.com",
            "RegionName": "us-west-1"
        },
        {
            "Endpoint": "ec2.ap-southeast-1.amazonaws.com",
            "RegionName": "ap-southeast-1"
        },
        {
            "Endpoint": "ec2.ap-southeast-2.amazonaws.com",
            "RegionName": "ap-southeast-2"
        }
    ]
}
```

### Pratique : l'autocompletion

```bash
complete -C aws_completer aws
```


### Alternative : SAWS (AWS cli on Steroids)

https://github.com/donnemartin/saws


On commence par se créer une paire de clés
------------------------------------------

```bash
$ aws ec2 create-key-pair --key-name MyKeyPair
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

```bash
$ vi my-key-pair.pem
(copier la clé. Attention aux retours chariots)


$ cat my-key-pair.pem
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAgDbY5Hzlv+wP4nTVXkwRHemd3/OLo/O6u+kI2UloHqN6mZLP+XoFcEAmNmM0
3sA/mfv0B9fKktSUqnAEPlygS35P1xJhUXqvdFhh4m7mF+D7naPPHWcg581sdhfqEQU1uMcFq+14
fTgkQRCLkoNNsf3c4O1KxhJ6etHFxcqr/V104PnOPGlWWni+kIMyMP/+CvzzKCZkkL/EUk6LDH4T
HqG4nDmEd4u0oNPakWd1nX26hfYN61IhkNedtqU9CnJPHBFRbl+BZbllB4ZkxYn6QHi5t7J0Lj26
ruq6URfKLIO4ZOcZ35ZARSFB4nYtU6tbw78sE0jJqZ6ibwHyPhw8fwIDAQABAoIBAEGs1pjjqUQQ
BWr4cbslt7bczfPDawoGdOaATfoPcfgPwWMdIs8lw9dl5K0DUDexvmJ//tZtoORpY+WSD3pqM+m3
v+npDlSQRYORKkK0j8Q3iGuNVzA2fVJ/lUlAorMpOgV2XN9eetOZiGiTswrPm2LLKPNGWYDwQjDb
dzUDxem300kdPZcGiiW6OIIF39s0cHdYSurLlfFGBgT1YZUQQI8AyAZOA/uI5gzlXHo6pmOGc61Y
nIGqAYV3k8eCsEag9XMyrAih1DiuSMEUzwXImPHuFQTB/Z28rhPPbdQ3mioHJBRDn3wGRz233q44
5ZHGsi/XdeA2oNAIIg+20LFVhdECgYEA1jnngYbv30JPO/IAQdAjM4r4bV5adqQRhsZFeFcjI1pL
6JXHnuBBN69z5liCICRLfWHtEwUXDbt/9tZmmG6Qp5SZdPSncmAbzsDuA7nKKrnhdoNDw4V8MN++
+Hn+T0ezJp8dXNB3EnDiLvO71sunJMTAIxKjPejFG6SsqALWrSMCgYEAmTdB1XgOCdgl3P+8/Og0
M3qwZGTbX641ug30QBgYmDKA3D+vLRBeGtxU+j/y41Ah2W016amtdM7KgMTVdB0ZjSR70TmaETrD
kW449q0J/UrH9DmcOpUf8qVS8QwG/fhH/VElLKiWGitulHrZPVSSBomLpJKOUzHnSGl6ZO+m7vUC
gYA5YVUjGpORh19VvSJYfnmPSr/z+3vbn2KaaO0eqKhexcbjS4smgQa29aXjov1nwpD9yocHuytL
oFdMNG1SkvroCCN6cjWPqzKHlKGsGc2O2C8N4Wb7Lfvv016Bi5uUfK39wEzLGYNrSxUqYlqD1BS3
AoQ8YLec04ZIOzmL3wbFZQKBgHAeZYim3+8IQzzj0BJqgbiiMW5l97qeqyZJi9FTULwfSPjjiXc6
oQKa9XxjS4RYYUzQhEFHL21o3fs5DtJ3cPk+F3VV545wKCjGNd0dZ0/5ZzUq605bThOsM3O9T2iO
RW/z73YssBraaYMyGsKsnmc2Q//cV1Y+EHeG6E/wp4H5AoGAT/jpdHo6hjYDd6z8WJT6zuyecT39
l4oB72CO6PCJXLLtTj85brYLP6mZyecOvD4a7Zr97NcmA4aUZtv7ERHoHSRhyOm1ePHaV2i7JFfo
Hvc01+KCAJPx8txqvHvqKfNm2aMeok7FVPSB1vbdgnBRnGJiqYQ5GgrxH0Gc3DXTG7A=
-----END RSA PRIVATE KEY-----
```

Important : MyKeyPair est le nom de notre clé. Rien à voir avec le ficher en local qui est la clé publique. Lors des appels à l'API, on passera le nom de la clé (donc MyKeyPair). Lors de la connexion aux instances, on passera à la commande ssh le ficher de la clé publique (donc le fichier `my-key-pair.pem`).

Nous avons notre clé publique en local. Pour pouvoir l'utiliser, on va la protéger.

```bash
$ chmod 600 my-key-pair.pem
```


Lancement de notre première instance
------------------------------------

### Choix d'une AMI (Amazon Machine Image)

Comme son nom l'indique, c'est l'image que l'on utilise lors du lancement de l'instance. Elle est spécifique :

- à la région,
- au système d'exploitation,
- à l'architecture (32 ou 64bits),
- aux permissions
- et au type de stockage du _root device_.


Pour faire son choix en Ubuntu : http://cloud-images.ubuntu.com/locator/ec2/

Donc, pour une instance t2.micro, le _root device_ est EBS en Hardware Virtual Machine (HVM), on choisit l'image pour la région us-east-1 d'une ubuntu 15.04 (vivid) en 64bits : _ami-e7de9b82_.

D'où la commande :



```bash
$ aws ec2 run-instances --image-id ami-e7de9b82 --instance-type t2.micro --region us-east-1 --key MyKeyPair
```
```json
{
    "OwnerId": "447005562149",
    "ReservationId": "r-06199676",
    "Groups": [],
    "Instances": [
        {
            "Monitoring": {
                "State": "disabled"
            },
            "PublicDnsName": null,
            "KernelId": "aki-919dcaf8",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "EbsOptimized": false,
            "LaunchTime": "2014-09-12T15:24:07.000Z",
            "PrivateIpAddress": "172.31.37.163",
            "ProductCodes": [],
            "VpcId": "vpc-ab8e3dce",
            "StateTransitionReason": null,
            "InstanceId": "i-e4e01b0a",
            "ImageId": "ami-e7de9b82",
            "PrivateDnsName": "ip-172-31-37-163.ec2.internal",
            "KeyName": "MyKeyPair",
            "SecurityGroups": [
                {
                    "GroupName": "default",
                    "GroupId": "sg-2be2c34e"
                }
            ],
            "ClientToken": null,
            "SubnetId": "subnet-3f0e1c17",
            "InstanceType": "t2.micro",
            "NetworkInterfaces": [
                {
                    "Status": "in-use",
                    "SourceDestCheck": true,
                    "VpcId": "vpc-ab8e3dce",
                    "Description": null,
                    "NetworkInterfaceId": "eni-58a35472",
                    "PrivateIpAddresses": [
                        {
                            "PrivateDnsName": "ip-172-31-37-163.ec2.internal",
                            "Primary": true,
                            "PrivateIpAddress": "172.31.37.163"
                        }
                    ],
                    "PrivateDnsName": "ip-172-31-37-163.ec2.internal",
                    "Attachment": {
                        "Status": "attaching",
                        "DeviceIndex": 0,
                        "DeleteOnTermination": true,
                        "AttachmentId": "eni-attach-1937d164",
                        "AttachTime": "2014-09-12T15:24:07.000Z"
                    },
                    "Groups": [
                        {
                            "GroupName": "default",
                            "GroupId": "sg-2be2c34e"
                        }
                    ],
                    "SubnetId": "subnet-3f0e1c17",
                    "OwnerId": "447005562149",
                    "PrivateIpAddress": "172.31.37.163"
                }
            ],
            "SourceDestCheck": true,
            "Placement": {
                "Tenancy": "default",
                "GroupName": null,
                "AvailabilityZone": "us-east-1d"
            },
            "Hypervisor": "xen",
            "BlockDeviceMappings": [],
            "Architecture": "x86_64",
            "StateReason": {
                "Message": "pending",
                "Code": "pending"
            },
            "RootDeviceName": "/dev/sda1",
            "VirtualizationType": "paravirtual",
            "RootDeviceType": "ebs",
            "AmiLaunchIndex": 0
        }
    ]
}
```

On note le `"PublicDnsName": null`, ce qui signifie que l'instance n'a pour le moment pas d'entrée DNS, puisqu'elle est en train de se lance (statut `pending`).


## Se connecter à l'instance

Quelques instants plus tard, nous allons redemander :

```bash
$ aws ec2 describe-instances
```
```json
{
    "Reservations": [
        {
            "OwnerId": "447005562149",
            "ReservationId": "r-06199676",
            "Groups": [],
            "Instances": [
                {
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "PublicDnsName": "ec2-54-165-229-123.compute-1.amazonaws.com",
                    "RootDeviceType": "ebs",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "EbsOptimized": false,
                    "LaunchTime": "2014-09-12T15:24:07.000Z",
                    "PublicIpAddress": "54.165.229.123",
                    "PrivateIpAddress": "172.31.37.163",
                    "ProductCodes": [],
                    "VpcId": "vpc-ab8e3dce",
                    "StateTransitionReason": null,
                    "InstanceId": "i-e4e01b0a",
                    "ImageId": "ami-e7de9b82",
                    "PrivateDnsName": "ip-172-31-37-163.ec2.internal",
                    "KeyName": "MyKeyPair",
                    "SecurityGroups": [
                        {
                            "GroupName": "default",
                            "GroupId": "sg-2be2c34e"
                        }
                    ],
                    "ClientToken": null,
                    "SubnetId": "subnet-3f0e1c17",
                    "InstanceType": "t2.micro",
                    "NetworkInterfaces": [
                        {
                            "Status": "in-use",
                            "SourceDestCheck": true,
                            "VpcId": "vpc-ab8e3dce",
                            "Description": null,
                            "Association": {
                                "PublicIp": "54.165.229.123",
                                "PublicDnsName": "ec2-54-165-229-123.compute-1.amazonaws.com",
                                "IpOwnerId": "amazon"
                            },
                            "NetworkInterfaceId": "eni-58a35472",
                            "PrivateIpAddresses": [
                                {
                                    "PrivateDnsName": "ip-172-31-37-163.ec2.internal",
                                    "Association": {
                                        "PublicIp": "54.165.229.123",
                                        "PublicDnsName": "ec2-54-165-229-123.compute-1.amazonaws.com",
                                        "IpOwnerId": "amazon"
                                    },
                                    "Primary": true,
                                    "PrivateIpAddress": "172.31.37.163"
                                }
                            ],
                            "PrivateDnsName": "ip-172-31-37-163.ec2.internal",
                            "Attachment": {
                                "Status": "attached",
                                "DeviceIndex": 0,
                                "DeleteOnTermination": true,
                                "AttachmentId": "eni-attach-1937d164",
                                "AttachTime": "2014-09-12T15:24:07.000Z"
                            },
                            "Groups": [
                                {
                                    "GroupName": "default",
                                    "GroupId": "sg-2be2c34e"
                                }
                            ],
                            "SubnetId": "subnet-3f0e1c17",
                            "OwnerId": "447005562149",
                            "PrivateIpAddress": "172.31.37.163"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Placement": {
                        "Tenancy": "default",
                        "GroupName": null,
                        "AvailabilityZone": "us-east-1d"
                    },
                    "Hypervisor": "xen",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/sda1",
                            "Ebs": {
                                "Status": "attached",
                                "DeleteOnTermination": true,
                                "VolumeId": "vol-49fc4906",
                                "AttachTime": "2014-09-12T15:24:11.000Z"
                            }
                        }
                    ],
                    "Architecture": "x86_64",
                    "KernelId": "aki-919dcaf8",
                    "RootDeviceName": "/dev/sda1",
                    "VirtualizationType": "paravirtual",
                    "AmiLaunchIndex": 0
                }
            ]
        }
    ]
}
```

Et Bam ! la machine est prête (statut "running"). Notons le DNS public (pour nous c'est `ec2-54-165-229-123.compute-1.amazonaws.com`).

Attention aux machines des petits camarades. Vous les verrez :)

Normalement, nous avons maintenant tout ce qu'il faut pour nous connecter à notre toute première instance en SSH. Chaque système a ses petites habitudes. Sous ubuntu, c'est l'user ubuntu qui doit se connecter.

```bash
$ ssh ubuntu@ec2-54-165-229-123.compute-1.amazonaws.com -i my-key-pair.pem -v
...
...
...
ubuntu@ip-172-31-37-163:~$
```

On peut en lancer une deuxième, une troisième ... La commande describe-instances nous fournira les informations de ces instances.

Depuis l'instance on peut récupérer un certain nombre d'information : les meta-data

```bash
ubuntu@ip-172-31-42-29:~$ curl http://169.254.169.254/latest/meta-data/
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
hostname
instance-action
instance-id
instance-type
kernel-id
local-hostname
local-ipv4
mac
metrics/
network/
placement/
profile
public-hostname
public-ipv4
public-keys/
reservation-id
security-groups
services/
```

Enfin, on est sudo...

```bash
ubuntu@ip-172-31-37-163:~$ sudo apt-get update
...
...
```

## Automatiser l'installation des services au lancement de l'instance

On a pour le moment été capable de lancer une instance, et de s'y connecter. Un fois dessus, on peut manuellement installer ce que l'on veut, comme sur n'importe quelle machine.

Par exemple :

- installer l'écosystème du langage/framework qu'il nous faut
- git clone notre super projet
- regler 2-3 paramètres + fichiers de configuration
- lancer les services

Ainsi, tout s'installe et se lance, dès que l'instance est lancée.

Un tel script de lancement s'écrit dans le fichier `user-data` que l'on peut passer en paramètre à la commande `aws ec2 run-instance ..... --user-data file://user-data-file`.

Un exemple dans un écosystème node.js à jour (donc, en compilant) + quelques astuces...

```bash
#!/bin/bash

apt-get update
apt-get install git make g++ -y

wget http://nodejs.org/dist/v0.10.31/node-v0.10.31.tar.gz
tar xvzf node-v0.10.31.tar.gz
cd node-v0.10.31
./configure
make
make install

npm install pm2 -g
cd /home/ubuntu/
git clone git://github.com/MY_NAME/MY_PROJECT.git
cd MY_PROJECT
cat >> config/config.json << EOD
var conf = {
    'maVariable': 1
}
EOD
npm install .
ulimit -n 102400
PORT=80 NODE_ENV=production pm2 start app.js

```




## Stopper une instance

```bash
$ aws ec2 stop-instance --instance-id i-e4e01b0a
```
```json
{
    "StoppingInstances": [
        {
            "InstanceId": "i-e4e01b0a",
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
```

## Terminer une instance

```bash
$ aws ec2 terminate-instances --instance-id i-e4e01b0a
```
```json
{
    "TerminatingInstances": [
        {
            "InstanceId": "i-e4e01b0a",
            "CurrentState": {
                "Code": 32,
                "Name": "shutting-down"
            },
            "PreviousState": {
                "Code": 64,
                "Name": "stopping"
            }
        }
    ]
}
```

## Mumuse avec les EBS (Elasctic Block Storage)

Nos t2.micro sont en EBS-root : il n'y a qu'un volume, et c'est / (le root). Impossible donc de le démonter
On va créer un nouveau volume.

```bash
$ aws ec2 create-volume --size 100 --availability-zone us-east-1d
```
```json
{
    "AvailabilityZone": "us-east-1d",
    "Attachments": [],
    "Tags": [],
    "Encrypted": false,
    "VolumeType": "standard",
    "VolumeId": "vol-99922fd6",
    "State": "creating",
    "SnapshotId": null,
    "CreateTime": "2014-09-16T08:23:40.498Z",
    "Size": 100
}
```

On peut alors remonter cet EBS sur la deuxième instance.

```bash
$ aws ec2 attach-volume --instance-id i-abcd1234 --volume-id vol-99922fd6 --device /dev/sdf
```
```json
{
    "AttachTime": "2014-09-12T15:26:13.000Z",
    "InstanceId": "i-abcd1234",
    "VolumeId": "vol-99922fd6",
    "State": "attaching",
    "Device": "/dev/sdf"
}
```


## Elastic Load Balancer

On déclare un ELB nommé upicardie-asdemo1 sur la zone us-east-1d, qui écoute sur le port 80 et qui répartit les requêtes sur le port 80 des instances. Notre compte AWS est en mode VPC, nous allons devoir utiliser les subnets VPC pour initialiser le load balancer.

```bash
$ aws ec2  describe-subnets
```
```json
{
    "Subnets": [
        {
            "VpcId": "vpc-ab8e3dce",
            "CidrBlock": "172.31.16.0/20",
            "MapPublicIpOnLaunch": true,
            "DefaultForAz": true,
            "State": "available",
            "AvailabilityZone": "us-east-1a",
            "SubnetId": "subnet-19c2126e",
            "AvailableIpAddressCount": 4089
        },
        {
            "VpcId": "vpc-ab8e3dce",
            "CidrBlock": "172.31.32.0/20",
            "MapPublicIpOnLaunch": true,
            "DefaultForAz": true,
            "State": "available",
            "AvailabilityZone": "us-east-1d",
            "SubnetId": "subnet-3f0e1c17",
            "AvailableIpAddressCount": 4087
        },
        {
            "VpcId": "vpc-ab8e3dce",
            "CidrBlock": "172.31.0.0/20",
            "MapPublicIpOnLaunch": true,
            "DefaultForAz": true,
            "State": "available",
            "AvailabilityZone": "us-east-1b",
            "SubnetId": "subnet-d9bd4f80",
            "AvailableIpAddressCount": 4091
        }
    ]
}
```

```bash
$ aws elb create-load-balancer \
  --load-balancer-name upicardie-asdemo1 \
  --subnets subnet-d9bd4f80 subnet-3f0e1c17 subnet-19c2126e \
  --listeners "LoadBalancerPort=80,InstancePort=80,Protocol=http"
```
```json
{
    "DNSName": "upicardie-asdemo1-2087259529.us-east-1.elb.amazonaws.com"
}
```


Attachons-lui les 2 instances que nous avons créées.

```bash
$ aws elb register-instances-with-load-balancer \
  --load-balancer-name upicardie-asdemo1 \
  --instances i-a0eccdc1 i-a0eccda1
```

Exercice
--------

Installer un site web quelconque sur 3 instances, rattachées à un ELB. Lancer un test de charge naif (ou pas) afin d'observer les logs sur chaque machine.



La même chose en console WEB (ouf!)
-----------------------------------

Amazon est un des pioniers du Web. Il aurait été étonnant de ne pas avoir une façon plus visuelle d'utiliser les services d'AWS.

C'est possible à l'addresse : https://447005562149.signin.aws.amazon.com/console/

Mais vous allez devoir vous créer votre login

```bash
$ aws iam create-login-profile help
```

Regarder aussi

```bash 
$ aws iam get-account-password-policy
```

