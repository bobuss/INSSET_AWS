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
	- Security groups
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



Atelier AWS


(Mardi)

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



Devops
------

Dev = ajouter / améliorer des fonctionnalités == changements
Ops = assurer la stabilité


### Culture

### Automatisation

### Metriques

### Partage








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

### TP : L'art de la distribution de don









