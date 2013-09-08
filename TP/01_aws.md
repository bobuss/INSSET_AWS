Atelier AWS
===========

La doc en ligne
---------------

http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html



Installer AWS CLI
-----------------

Pour info : https://github.com/aws/aws-cli

```
($sudo apt-get install -y python-pip)
$ sudo pip install awscli
...
$ vi .aws-config
...
$ cat .aws-config
[default]
aws_access_key_id = <access key id>
aws_secret_access_key = <secret access key>
region = us-east-1
$ chmod 600 $HOME/.aws-config
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


Commencer par se créer une paire de clés
----------------------------------------

```bash
$ aws ec2 create-key-pair help
```

Astuce pour afficher clairement la clé... et panipuler plus facilement du json en ligne de commande.

Installer jq : http://stedolan.github.io/jq/



Lancement de notre première instance
------------------------------------

### choix d'une ami

pour ubuntu 12.04 (LTS), c'est https://cloud-images.ubuntu.com/precise/current/

Nous allons prendre l'image du système 64 bits, en root store sur EBS : ami-7daee114


```
aws ec2 run-instances help
```

Penser à note son instance-id.


Se connecter à l'instance
-------------------------

Récupérer le dns public.

```
aws ec2 describe-instances help
```

et se connecter


```
ssh ubuntu@ec2-xx-yy-zz-tt.compute-1.amazonaws.com -i my-key-pair.pem -v
...
...
[ubuntu@ip-xx-yy-zz-tt ~]$
```

On peut en lancer une deuxième, une troisième ... La commande describe-instances nous fournira les informations de ces instances.


## Stopper une instance

```
aws ec2 stop-instance help
```


## terminer une instance

```
aws ec2 terminate-instances help
```

## Mumuse avec les EBS (Elasctic Block Storage)

Dans la description de notre instance, nous notons

```
"BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/sda1",
                            "Ebs": {
                                "Status": "attached",
                                "DeleteOnTermination": true,
                                "VolumeId": "vol-21726d61",
                                "AttachTime": "2013-09-02T13:25:36.000Z"
                            }
                        }
                    ],
```

Nous pouvons le détacher

Au préalable, on le démonte.

```
# umount -d /dev/sda
```

Et depuis la ligne de commande :

```
aws ec2 detach-volume help
```


## Elastic Load Balancer

On déclare un ELB nommé upicardie-asdemo_VOTRENOM sur la zone us-east-1d, qui écoute sur le port 80 et qui répartit les requêtes sur le port 80 des instances :

```
aws elb create-load-balancer \
  --load-balancer-name upicardie-asdemo_VOTRENOM \
  --availability-zones us-east-1d \
  --listeners "LoadBalancerPort=80,InstancePort=80,Protocol=http"
{
    "DNSName": "upicardie-asdemo1-2087259529.us-east-1.elb.amazonaws.com"
}
```


Penser à ajouter les availability zones accéssibles à notre ELB : les micro instances sont en 1a. L'ELB écoute en 1b.

```
aws elb enable-availability-zones-for-load-balancer --load-balancer-name upicardie-asdemo_VOTRENOM --availability-zones us-east-1a
```

Attachons-lui les 2 instances que nous avons créées.

```
aws elb register-instances-with-load-balancer help
```

Excercice
---------

Installer un site web quelconque sur 3 instances, rattachées à un ELB. Lancer un test de charge naif (ou pas) afin d'observer les logs sur chaque machine.



La même chose en console WEB (ouf!)
-----------------------------------

Amazon est un des pioniers du Web. Il aurait été étonnant de ne pas avoir une façon plus visuelle d'utiliser les services d'AWS.

C'est possible à l'addresse : https://180843797005.signin.aws.amazon.com/console/

Mais vous allez devoir vous créer votre login

```
aws iam create-login-profile help
```
