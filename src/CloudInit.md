[retour](index.html)

# CloudInit

[CloudInit](https://cloudinit.readthedocs.io/en/latest/) est un framework permettant d’exécuter un script fourni lors de l’instanciation d'une VM.

Ainsi, lorsque vous utiliser un fichier user-data lors du lancement d'un instance :

```
aws ec2 run-instances \
  --image-id ami-b0c36ed8 \
  --instance-type t1.micro \
  --region us-east-1 \
  --key MyKeyPair \
  --user-data file://myfile.sh
```

en fait, vous faites appel à CloudInit...

Une fois l'instance lancée, CloudInit va passer par le service de metadata, en l'occurence l'adresse `http://169.254.169.254/latest/user-data` pour récupérer le fichier et le parser.


## La syntaxe de CloudInit

Il y a plusieurs possibilités via une syntaxe spécifique en Yaml.

### #cloud-config

Permet de décrire d'une façon plus lisible les actions à lancer. Un certain nombre de directives permettent la gestion "out of the box" des packages, des comptes utilisateurs, des client chef, puppet...

Par exmple :

```
#cloud-config
packages:
 - git-core
```

reviens à `sudo apt-get install git-core`,


```
#cloud-config
apt_update: true
```

reviens à `sudo apt-get update`.


### #include

Spécifie la liste des fichiers à télécharger et à jouer.

Exemple : installation de CouchBase

```
#include
https://raw.github.com/couchbaselabs/cloud-init/master/couchbase-server-enterprise_x86_64_1.8.1.rpm.install
```


### #!

Les scripts bash que l'on utilise jusque là.

```
#!
curl -L http//www.opscode.com/chef/install.sh | sudo bash
```


## Quelques exemples

```
#cloud-config
# The default is to install from packages.
# Key from http://apt.opscode.com/packages@opscode.com.gpg.key
apt_sources:
 - source: "deb http://apt.opscode.com/ $RELEASE-0.10 main"
   key: |
     -----BEGIN PGP PUBLIC KEY BLOCK-----
     Version: GnuPG v1.4.9 (GNU/Linux)

     mQGiBEppC7QRBADfsOkZU6KZK+YmKw4wev5mjKJEkVGlus+NxW8wItX5sGa6kdUu
     3ZRAq/HMGioJEtMFrvsZjGXuzef7f0ytfR1zYeLVWnL9Bd32CueBlI7dhYwkFe+V
     Ep5jWOCj02C1wHcwt+uIRDJV6TdtbIiBYAdOMPk15+VBdweBXwMuYXr76+A7VeDL
     zIhi7tKFo6WiwjKZq0dzctsJJjtIfr4K4vbiD9Ojg1iISQQYEQIACQUCSmkLtAIb
     DAAKCRApQKupg++CauISAJ9CxYPOKhOxalBnVTLeNUkAHGg2gACeIsbobtaD4ZHG
     0GLl8EkfA8uhluM=
     -----END PGP PUBLIC KEY BLOCK-----

chef:

 # Valid values are 'gems' and 'packages' and 'omnibus'
 install_type: "packages"

 # Boolean: run 'install_type' code even if chef-client
 #          appears already installed.
 force_install: false

 # Chef settings
 server_url: "https://chef.yourorg.com:4000"

 # Node Name
 # Defaults to the instance-id if not present
 node_name: "your-node-name"

 # Environment
 # Defaults to '_default' if not present
 environment: "production"

 # Default validation name is chef-validator
 validation_name: "yourorg-validator"
 validation_key: |
     -----BEGIN RSA PRIVATE KEY-----
     YOUR-ORGS-VALIDATION-KEY-HERE
     -----END RSA PRIVATE KEY-----

 # A run list for a first boot json
 run_list:
  - "recipe[apache2]"
  - "role[db]"

 # Specify a list of initial attributes used by the cookbooks
 initial_attributes:
    apache:
      prefork:
        maxclients: 100
      keepalive: "off"

 # if install_type is 'omnibus', change the url to download
 omnibus_url: "https://www.opscode.com/chef/install.sh"

# Capture all subprocess output into a logfile
# Useful for troubleshooting cloud-init issues
output: {all: '| tee -a /var/log/cloud-init-output.log'}
```


[D'autres dans la doc de CloudInit](https://cloudinit.readthedocs.io/en/latest/).



---

#### Licence

Cette œuvre est mise à disposition selon les termes de la Licence [Creative Commons Attribution 3.0 France](https://creativecommons.org/licenses/by/3.0/fr/).

[![Licence Creative Commons](https://i.creativecommons.org/l/by/3.0/fr/88x31.png)](https://creativecommons.org/licenses/by/3.0/fr/)
