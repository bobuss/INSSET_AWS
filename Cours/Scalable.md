Cloud et architectures scalables
================================

---
(ou comment utiliser la flexibilité du Cloud pour monter en charge)
===================================================================

---
#Qui suis-je ?

* Bertrand Tornil

* Lead dev chez IsCool Entertainment pour les jeux sur Facebook

* Architectures LAMP

* NoSQL

---
Partie 1 : Montée en charge
===========================

---
#Soit un site Web...

##Architecture classique : 1 machine

* le serveur web qui execute le code applicatif
* une base de donnée


##Scénario :

1. un client effectue une requête HTTP sur le serveur
  - le serveur doit transformer cette requête en réponse
  - accès aux données
  - création du corps de la réponse (page, json, xml)




---
#La charge monte

##Le temps de traitement d'un requête http augmente

* Équation triviale : plus de traitement demandés à autant de capacité


##Solution 1 : augmenter la puissance de la machine

* forcément limité

##Solution 2... répartissons la charge

* on achète de nouvelles machines (installation, monitoring, test, déploiement)
* OU
* on lance une nouvelle instance sur le Cloud


##Souplesse du Cloud \o/

---
#Séparation Serveur Web / DB

##Un example avec 2 machines :

* Le serveur web
* La DB


##on améliore les choses, mais ç'est forcément limité

---
#Stratégie multi-frontal

##on "clone" le serveur web x fois

* encore une fois le cloud rend les choses aisées
* * AWS = 1 commande = 1 nouvelle instance
* * puppet = industrialisation de la configuration
* * capistrano = industrialisation du déploiement

## et Pour répartir les requêtes entre les frontaux

* on place un "load balancer" devant

---
#Stratégies de "Load balancing"

##round robin

* Chacun son tour

##least connected

* le load-balancer doit pouvoir connaître l'état des connexions des frontaux
* il adapte le flot selon la charge réseau du frontal

##less loaded

* cette fois c'est l'état de charge général du frontal qui est pris en compte

##chaque stratégie a ses avantages / inconvénient

* ELB chez AWS

---
#Remarques sur le multi-frontal

## permet de monter pratiquement indéfiniment

* c'est une recette magique, qui a fait ses preuves

## soulève de nouveaux problèmes :

* partage d'information entre frontaux (session)
* déploiement (capistrano règle pas mal de problème)
* prix... à mettre en balance

---
#Bottleneck du stockage

## Arrive un moment, ou l'ajout de serveurs Webs cesse de régler le problème de la montée en charge

* le stockage est notre nouveau point de contension

## Première approche : cacher les données

* memcache devant la DB
* premier NoSQL réellement utilisé
* livejournal

## Pour aller plus loin

* cela dépend de nos besoins
* ceci est une remarque générale... il n'y a pas de solution miracle

---
#Le Web des CMS

## Sites avec beaucoup de lectures

* Solution : Réplication de la DB
* 1 master pour les écriture
* plusieurs slaves pour les lectures
* attention : gestion du retard

---
#Nouveaux besoins

##  Jeux, réseaux sociaux

* beaucoup d'écritures
* les data doivent être accessibles immédiatement
* stockages de réseaux
* complexité exponentielle
* montées en charge violentes

## passage sur des technologies plus adaptées : le NoSQL

---
Partie 2 : Le NoSQL en théorie
==============================

---
#Le théorème CAP de Brewer

## C : Consistency

* Un service est dit "consistent" s'il opère ses opérations entièrement... ou pas du tout
* notions d'atomicité, propriétés ACID, transactions

## A : Availability

* Un service est "available"... s'il marche...
* on considère qu'il marche quand chaque client peut utiliser le service en écriture et en lecture

## P : Partition Tolerance

* Dès lors que les données sont distribuées en plusieurs endroits (machines, lieux), aucune panne
moins forte qu'une destruction globale du réseau ne peut justifier un arrêt du service

---
#Que dit le théorème CAP ?

> des 3 propriétés CAP... on doit n'en garder que 2

##Relacher le "Partition Tolerance"

* Pas trop d'intérêt dans notre propos : architecture 1 Noeud

##Relacher l' "Availability"

* l'applicatif doit supporter la panne de partitions
* * découpage fonctionnel : 1 fonctionnalité est down, mais ne gène pas le reste du service

##Relacher le "Consistency"

* concept du "Eventually Consistent" (W.Vogels)
* notions de replicas(N), de quorum en lecture(R), en écriture(W)
* les "vector clocks" retracent l'historique des opérations, et permettent à l'applicatif de trancher selon une logique métier

---
Partie 3 : L'art de la distribution des données
===============================================

---
#Table de hachage persistante

* les informations sont ici stockées sur un nœud unique.
* Ce mode de stockage est donc efficace tant que le volume de données stockées et la charge de requêtes n’excèdent pas les capacités de la machine.
* En outre aucune tolérance aux pannes n’est ici admise puisque les données ne sont pas redondées.

---
#Sharding en distribution modulo

## On distribue les clés selon le modulo (du md5 de la clé par exemple)

![partition](images/partition.png "Partition")

* super simple
* mais on doit re-distribuer N-1/N data lors de l'ajout d'un N+1-ième noeud

---
#Sharding en hashing consistent

## un hashring est généré

![consistent hashing](images/consistenthashing.png "Consistent Hashing")

* plus complexe
* on ne doit re-distribuer que 1/N data lors de l'ajout d'un N+1-ième noeud

---
#Réplication sur N instances

## type simple  : 1 partition par instance

## type replica : M partitions par instances

![replication](images/replication.png "replication")

* on retrouve la notion de relachage de la consistence
* Dynamo (Amazon) et BigTable de google fonctionnent de cette manière

---
Partie 4 : Le NoSQL
===================

---
#Généralités sur le NoSQL

* Le NoSQL regroupe de nombreuses bases de données,
* récentes pour la plupart,
* logique de représentation de données non relationnelle
* et qui n’offrent donc pas une interface de requêtes en SQL.

## La distribution des données se prête bien à ces technologies

---
#Quelques mythes sur le NoSQL

* Il ne s’agit pas d’une technologie de remplacement des SGBDR
* Les NoSQL apportent simplement des options supplémentaires
* Outillage réduit
* Pas une solution miracle pour le stockage de données.

## USE THE RIGHT TOOL !

![pizza](images/pizza.jpg "pizza")

---
#Clé-Valeur

![clé valeur](images/type_valeur.png "Clé Valeur")

* la plus simple
* adapté aux caches
* accès rapides aux informations
* pas de requétage

## Riak, Redis, Voldemort

---
#Clé-Colonne

![clé colonne](images/type_colonnes.png "Clé Colonne")

* Colonnes différentes pour chaque ligne
* capacité à stocker des listes d'informations
* Requétage, indexes
* capacité d'accéder à des intervalles de colonnes

## HBase, Cassandra

---
#Clé-Document

![clé document](images/type_document.png "Clé Document")

* Adapté au monde du web
* extension du modèle clé-valeur
* un document contient des données organisées de manière hiérarchiques (XMl, JSON)
* indexes, notions de champs, requêtes

## MongoDB, CouchDB

---
#Graphs

![grpahs](images/type_graph.png "Graphs")

* stocke des données liées par des relations
* réseaux sociaux
* base de données géographiques

## Neo4j, HypergraphDB, FlockDB.

---

"In Real Life ?"
================

---
#Un exemple de NoSQL

## Redis

* mono-server : distribution par le code applicatif
* types de données (string, sets, zsets, lists)
* fonctionnalités (pub-sub, transaction, réplication master-slave)
* semi-persistent

[http://redis.io](http://redis.io "http://redis.io")

---
#Chez Weka, on utilise Redis pour :

## Compter

* les métriques métiers


## Stocker

* pour des accès rapides en R/W
* permet de se passer de la double couche cache + DB sur certaines fonctionnalités


## Sous quelle charge ?

* ~5000 commands / sec (R/W)
* utilisation intensive des listes, des ensembles


## Exemple : la Mammoth Party

---
En conclusion
=============

---

#A retenir

## Souplesse de cloud, certes

* Architectures distribuées
* veille techno + benchmark + tests


## USE THE RIGHT TOOL


## Veiller...

---
Question ?
==========