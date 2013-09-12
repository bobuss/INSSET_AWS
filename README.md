Intervention INSSET - Septembre 2013
====================================


## lundi



### Présentation générale

- qui suis-je ?
- mise en place du backlog


### Slides AWS

- pourquoi ?
- comment ?
	- régions
	- zones de disponibilité
- quelques briques IAAS
	- instances EC2
	- AMI
	- S3
	- EBS
- quelques briques SAAS
	- ELB
	- RDS (mysql + fail-over)
	- Dynamo (nosql + autoscaling)
	- SQS (queue)
	- Route53 (DNS)
	- CloudFront (CDN)
- architecture web classique
- architecture web dans AWS



### Atelier AWS




## Mardi


Poursuite de l'atelier AWS

Discussion





(mercredi)


Utilisation du cloud pour la Montée en charge et la Résilience
--------------------------------------------------------------

- multi frontaux
- asynchrone

Les données
- replication : limite du / des masters pour l'écriture
- partitionnement vertical (fonctionnel)
- partitionnement horizontal (sharding)

- L'art de la repartition des data
- Vers la dénormalisation des données

### Le NoSQL

- CAP
- ACID
- Clé valeur
- Clé colonne
- Clé document
- Graph


### Case studies

- Case study #1 : chez nous
- Case study #2 : Pinterest
- Case study #3 : Instagram
- Case study #4 : Reddit


### TP

ELB


### Auto-Scaling



jeudi - vendredi
----------------

### Devops

- concepts

- industrialisation

1.ssh
2.pssh
3.fabric / capistrano
4.fabtools / cuisine
5.puppet / chef / saltstack

5 (bis) docker

- communication... aussi par l'outil

HuBot

Workflow Dev -> Integration continue -> Deploiement














Contenu des Ateliers
--------------------

### AWS

- Installation de l'environement
- Génération de la key pair

### S3

- upload
- download

### EC2

- Une première instance
- Connexion
- Jouons avec les security groups
- Start / Stop de l'instance
- Installation d'un mini service web
- Le fichier user-data ; lancement d'instances
- Génération d'une AMI ; lancement d'instances
- Security groups

### EBS

### ELB

### AutoScaling

### DevOps

- installation d'une gate
- developpement de l'outil de provisionning / déploiement
- notions de recettes / roles
- passage de tag dans les lancements d'instances
- lock
- historisation de la release
- taches (mise à jour du code, métier)
- outiller / outiller / outiller













