Intervention INSSET - Septembre 2013
====================================

Contenu des cours


Présentation
------------

- qui suis-je ?
- qu'ai-je fait ?
- que fais-je ?
- que vais-je faire ?


AWS
---

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

- Security groups
- Une première instance
- Connexion
- Jouons avec les security groups
- Start / Stop de l'instance
- Installation d'un mini service web
- Le fichier user-data
- Les EBS
- ELB
- une deuxieme instance derrière l'ELB


### AutoScaling










