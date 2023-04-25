[retour](index.html)

# Docker

## Un survol de la chose

L'intéret des containers (et en particulier de Docker) en une illustration :

![Docker vs VM](img/Docker-technology.png)


De plus Docker a construit tout un écosystème cohérent :

- DockerHub : c'est le github des images Docker. D'ailleurs les commandes reprennent un peu la même syntaxe : pull, commit, push en particulier.
- Docker-compose (anciennement fig) : pour déclarer facilement l'agencement de plusieurs Dockers entre eux
- Docker-machine : provisionning dans le cloud de containers. Fonctionne avec AWS, Microsoft Azure, Digital Ocean... ou même VirtualBox en local.
- Docker-swarm : solution de clustering pour Docker.

On peut définir Docker en définissant ses 3 composants essentiels :

- les images
- les registries
- les containers


### Les images Docker

Une image Docker est un template de logiciel en lecture seule. Par exemple, une image peut contenir une système d'exploitation ubuntu, avec Nginx et votre application web installés. Les images servent à créer des containers Docker.

Docker permet de créer de nouvelles images, ou d'en amender des images existantes ; ou bien, il est possible de télécharger des images que d'autres ont créées depuis les registries.


### Les registries Docker

Les registries Docker. Il y a des espaces privés ou public sur lequels vous pouvez pousser ou récupérer des images. Le registry public de Docker est http://hub.docker.com. On y trouve une large collection d'images prêtes à l'emploi.


### Les containers Docker

Les containers Docker "hébergent" une ou plusieurs images Docker. Les containers Docker peuvent être démarrés, arrêtés, déplacés, ... Chaque container est une plateforme isolée et sécurisé.



## Installation

- Sur un linux, kernel > 3.8 : normalement disponible dans toutes les bonnes ditributions récentes du marché
- Sous mac ou Windows, depuis cette année, il y a aussi une version native : https://www.docker.com/


## Alors, ces images

On peut commencer par chercher dans le registry :

```bash
$ docker search ubuntu
NAME                           DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu                         Ubuntu is a Debian-based Linux operating s...   2362      [OK]
ubuntu-upstart                 Upstart is an event-based replacement for ...   35        [OK]
torusware/speedus-ubuntu       Always updated official Ubuntu docker imag...   25                   [OK]
tleyden5iwx/ubuntu-cuda        Ubuntu 14.04 with CUDA drivers pre-installed    18                   [OK]
...
```

À noter le statut officiel de certaines images. Les noms avec un / viennent d'un utilisateur de dockerHub (nommenclature login/repository comme sur github).

On récupère l'image, via un `pull`.

```bash
$ docker pull ubuntu
Using default tag: latest
latest: Pulling from library/ubuntu
d3a1f33e8a5a:  Downloading [========================================>          ] 53.51 MB/65.79 MB
c22013c84729: Download complete
d74508fb6632: Download complete
91e54dfb1179: Download complete
...
```

On peut à présent lister les images que l'on a localement :

```bash
$ docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu                     latest              91e54dfb1179        6 weeks ago         188.4 MB
```

Première commande indispensable :

```bash
$ docker run ubuntu:latest /bin/echo 'Hello World!'
Hello World!
```

Wow ! Une fois le conteneur instancié, Docker a exécuté la commande `/bin/echo 'Hello World!'` à l’intérieur de celui-ci et nous a retourné le résultat : Hello World!
Ensuite, le container s'est terminé.

D'ailleurs, on peut le retrouvé via la commande `ps`:

```bash
$ docker ps -a
CONTAINER ID        IMAGE                      COMMAND                  CREATED              STATUS                          PORTS                      NAMES
b104d0657323        ubuntu:latest              "/bin/echo 'Hello Wor"   41 seconds ago       Exited (0) 40 seconds ago                                  compassionate_yalow

```

Il est possible de se connecter en lancant une session interactive `-i` dans un terminal `-t` et en y executant bash :

```bash
$ docker run -t -i ubuntu:latest /bin/bash
root@5aff723e8730:/#

```

Il est également possible de lancer un container en mode daemon `-d` :

```bash
$ docker run -d ubuntu:latest /bin/bash -c "while true; do echo Hello; sleep 1; done"
8787bcb7fde348d039dc487c1bdda294d1c636de2df645362267dba7d7e6af3e

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
8787bcb7fde3        ubuntu:latest       "/bin/bash -c 'while "   4 seconds ago       Up 3 seconds                            cranky_swartz

$ docker logs cranky_swartz
Hello
Hello
Hello
Hello
Hello
Hello
Hello
Hello
Hello
Hello

$ docker stop cranky_swartz
cranky_swartz
```

## Quelques commandes supplémentaires pour manipuler les containers

On peut relancer un container précédemment arrêté :

```bash
$ docker start cranky_swartz
cranky_swartz
```

La fonction `pause` / `unpause`:

```bash
$ docker pause cranky_swartz
cranky_swartz
$ docker unpause cranky_swartz
cranky_swartz
```

Enfin, on peut se connecter à un container actuellement lancé via :

```bash
$ docker attach cranky_swartz
[CTRL-C]
root@82a7a75b7d25:/#
```

Pourquoi le `CTRL-C` ? en fait, le attach ne peut utiliser qu'une seule instance de shell, donc on doit killer le shell existant pour y accéder.

À noter que si on quitte en faisant `exit`, on stop le container. Pas très pratique.

Au final comment se connecte-t-on à notre container sans le stopper à la sortie ?

- soit on lance le _attach_ avec l'option --no-sig=true
- soit on sort avec `CTRL-P CTRL-Q`
- soit on lance un deuxième bash via

```bash
$ docker exec -it cranky_swartz /bin/bash
root@82a7a75b7d25:/#
```

Méthode winner \o/ (depuis docker >= 1.3). cf https://askubuntu.com/questions/505506/how-to-get-bash-or-ssh-into-a-running-container-in-background-mode

voilà, fin de la première partie.



## Publication sur DockerHub

Lorsque l'on fait des modification dans un container, on peut comparer à l'image d'origine

```bash
$ docker diff cranky_swartz
```

On peut alors commiter, et tagger :

```bash
$ docker commit ....
```

Enfin, pour publier sur DockerHub, on se connecte (avec un compte préalablement créé bien sûr)

```bash
$ docker login
Username:
Passwords:
Email:
```

On peut alors pousser sur le Hub :

```bash
$ docker push bobuss/mySublimeImage
```



## Le Dockerfile

La vrai façon de spécifier une image docker consiste à la décrire dans un fichier Dockerfile. Il y a toute une syntaxe pour cela.

On va commencer par une image toute simple, qui embarque un programme node.js qui répond un hello world basique.


### Le fichier index.js

```javascript
var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello from Docker !!');
});

var server = app.listen(8080, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});


```

### Les dépendances javascript dans un package.json

```json
{
  "name": "dockerapp",
  "dependencies": {
    "express": "^4.13.3"
  }
}
```

### Le Dockerfile

```dockerfile
# depuis l'image officielle ubuntu
FROM ubuntu

# ca c'est moi
MAINTAINER bobuss

# on execute des commandes dans le container
RUN apt-get update && \
    apt-get -y install curl && \
    apt-get -y install sudo && \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo bash - && \
    apt-get -y install python build-essential nodejs

# on ajoute le contenu du répertoire courant dans le container
# dans /src
ADD . /src

# on s'y deplace, et on lance le npm install
RUN cd /src && npm install

# on ouvre le port 8080
EXPOSE  8080

# et on lance la commande node /src/index.js
CMD ["node", "/src/index.js"]

```

On construit l'image. On donne un tag avec l'option `-t`. À Noter la nommenclature `username/projet` à la github, qui est repris par DockerHub.

```bash
$ docker build -t bobuss/node .
Sending build context to Docker daemon 3.584 kB
Step 0 : FROM ubuntu
 ---> 91e54dfb1179
Step 1 : MAINTAINER bobuss
...
...
...
Successfully built 04efea301f68

$ docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
bobuss/node                   latest              04efea301f68        25 seconds ago      387.6 MB

```

Et on lance maintenant notre container node.

Attention au port ! Le programme node expose le port 8080 dans le container. Il faut binder ce port sur un port de la machine locale via l'option `-p`.

Par exemple :

```bash
$ docker run -d -p 8080:8080 bobuss/node
081552fa8c0439860aacc658b5c6c05ba6d5c9d92f50e9b6b4d5316eb549da2e

```

On devrait voir un joli "Hello from Docker" en pointant sur http://localhost:8080


## Lier plusieurs containers

On va reprendre notre exemple précédent, en ajoutant un container redis ce qui nous permettra de compter les visites, par exemple.

Nous allons également un peu organiser notre répertoire de travail comme suit :

```
monAppDocker
├── .dockerignore
├── Dockerfile
└── src
    ├── index.js
    └── package.json
```

### .dockerignore

```
src/node_modules
```

### src/index.js

```javascript
var express = require('express');
var app = express();
var redis = require('redis');

var client = redis.createClient('6379', 'redis');

app.get('/', function (req, res) {
  client.incr('counter', function(err, counter) {
    if(err) return next(err);
    res.send('This page has been viewed ' + counter + ' times!');
  });
});

var server = app.listen(8080, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});

```

### src/package.json

```json
{
  "name": "dockerapp",
  "dependencies": {
    "express": "^4.13.3",
    "redis": "^2.1.0"
  }
}

```

### Dockerfile

```dockerfile
FROM ubuntu

MAINTAINER bobuss

RUN apt-get update && \
    apt-get -y install curl && \
    apt-get -y install sudo && \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo bash - && \
    apt-get -y install python build-essential nodejs

ADD src /src
RUN cd /src && npm install

EXPOSE  8080

CMD ["node", "/src/index.js"]

```

On re-build

```
$ docker build -t bobuss/node .
...
```

Pour lancer notre programme, dans un autre terminal, on lance un container redis :

```bash
docker run redis
1:C 06 Oct 21:39:56.778 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 3.0.3 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 1
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           http://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'

1:M 06 Oct 21:39:56.779 # Server started, Redis version 3.0.3
1:M 06 Oct 21:39:56.779 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
1:M 06 Oct 21:39:56.779 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:M 06 Oct 21:39:56.779 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1:M 06 Oct 21:39:56.779 * The server is now ready to accept connections on port 6379

```


Puis on lance notre container avec l'image bobuss/node, en liant le container redis. C'est l'option _link_ de la commande run. Cette option donne au container qui se lance les information sur un autre container. Dans notre exemple, le /etc/hosts du container contiendra une entrée _redis_ qui pointera sur le host du container redis.

Pour info, l'information est également disponible via variables d'environnement, pour ceux qui préfèrent.


```bash
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
180b25098d1d        redis               "/entrypoint.sh redis"   3 seconds ago       Up 3 seconds        6379/tcp            determined_raman

$ docker run -d -p 8080:8080 --link determined_raman:redis bobuss/node
8cc016d648625e402fef571fc28091a9b12ce15e3aba60528499e5d00e809a60

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
8cc016d64862        bobuss/node         "node /src/index.js"     4 seconds ago       Up 3 seconds        0.0.0.0:8080->8080/tcp   elated_yonath
180b25098d1d        redis               "/entrypoint.sh redis"   56 seconds ago      Up 56 seconds       6379/tcp                 determined_raman

```

On peut aller voir notre oeuvre sur http://localhost:8080



## docker-compose

Docker-Compose (anciennement fig) permet de spécifier comment lancer plusieurs containers en même temps, et de gérer les `link` entre eux.

Une fois installé, on écrit un fichier `docker-compose.yml` à la racine de notre projet.

```yaml
web:
  build: .
  ports:
   - "8080:8080"
  volumes:
   - ./src:/src
   - /src/node_modules
  links:
   - redis
redis:
  image: redis
```

Puis

```bash
$ docker-compose up
Warning: the mapping "src:/src" in the volumes config for service "web" is ambiguous. In a future version of Docker, it will designate a "named" volume (see https://github.com/docker/docker/pull/14242). To prevent unexpected behaviour, change it to "./src:/src"
Creating dockerapp_redis_1...
Building web...
Step 0 : FROM ubuntu
 ---> 91e54dfb1179
Step 1 : MAINTAINER bobuss
 ---> Using cache
 ---> 9820e5132a05
Step 2 : RUN apt-get update &&     apt-get -y install curl &&     curl -sL https://deb.nodesource.com/setup | sudo bash - &&     apt-get -y install python build-essential nodejs
 ---> Using cache
 ---> 3a9d1b18bd97
Step 3 : ADD src /src
 ---> 981a2824eda0
Removing intermediate container 2eb8518b0f9a
Step 4 : RUN cd /src && npm install
 ---> Running in 1683e1689dc4
npm WARN package.json dockerapp@ No description
npm WARN package.json dockerapp@ No repository field.
npm WARN package.json dockerapp@ No README data
redis@2.1.0 node_modules/redis

express@4.13.3 node_modules/express
├── escape-html@1.0.2
├── merge-descriptors@1.0.0
├── array-flatten@1.1.1
├── cookie@0.1.3
├── utils-merge@1.0.0
├── cookie-signature@1.0.6
├── methods@1.1.1
├── fresh@0.3.0
├── range-parser@1.0.2
├── vary@1.0.1
├── path-to-regexp@0.1.7
├── etag@1.7.0
├── content-type@1.0.1
├── parseurl@1.3.0
├── content-disposition@0.5.0
├── serve-static@1.10.0
├── depd@1.0.1
├── qs@4.0.0
├── finalhandler@0.4.0 (unpipe@1.0.0)
├── proxy-addr@1.0.8 (forwarded@0.1.0, ipaddr.js@1.0.1)
├── on-finished@2.3.0 (ee-first@1.1.1)
├── debug@2.2.0 (ms@0.7.1)
├── send@0.13.0 (destroy@1.0.3, statuses@1.2.1, ms@0.7.1, mime@1.3.4, http-errors@1.3.1)
├── accepts@1.2.13 (negotiator@0.5.3, mime-types@2.1.7)
└── type-is@1.6.9 (media-typer@0.3.0, mime-types@2.1.7)
 ---> 6cb839ba2a27
Removing intermediate container 1683e1689dc4
Step 5 : EXPOSE 8080
 ---> Running in 6697ae23540a
 ---> eb3e96f0a207
Removing intermediate container 6697ae23540a
Step 6 : CMD node /src/index.js
 ---> Running in a7d71607421f
 ---> f2679c36d047
Removing intermediate container a7d71607421f
Successfully built f2679c36d047
Creating dockerapp_web_1...
Attaching to dockerapp_redis_1, dockerapp_web_1
redis_1 | 1:C 06 Oct 21:18:31.659 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
redis_1 |                 _._
redis_1 |            _.-``__ ''-._
redis_1 |       _.-``    `.  `_.  ''-._           Redis 3.0.3 (00000000/0) 64 bit
redis_1 |   .-`` .-```.  ```\/    _.,_ ''-._
redis_1 |  (    '      ,       .-`  | `,    )     Running in standalone mode
redis_1 |  |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
redis_1 |  |    `-._   `._    /     _.-'    |     PID: 1
redis_1 |   `-._    `-._  `-./  _.-'    _.-'
redis_1 |  |`-._`-._    `-.__.-'    _.-'_.-'|
redis_1 |  |    `-._`-._        _.-'_.-'    |           http://redis.io
redis_1 |   `-._    `-._`-.__.-'_.-'    _.-'
redis_1 |  |`-._`-._    `-.__.-'    _.-'_.-'|
redis_1 |  |    `-._`-._        _.-'_.-'    |
redis_1 |   `-._    `-._`-.__.-'_.-'    _.-'
redis_1 |       `-._    `-.__.-'    _.-'
redis_1 |           `-._        _.-'
redis_1 |               `-.__.-'
redis_1 |
redis_1 | 1:M 06 Oct 21:18:31.661 # Server started, Redis version 3.0.3
redis_1 | 1:M 06 Oct 21:18:31.661 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
redis_1 | 1:M 06 Oct 21:18:31.661 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
redis_1 | 1:M 06 Oct 21:18:31.661 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
redis_1 | 1:M 06 Oct 21:18:31.661 * The server is now ready to accept connections on port 6379
web_1   | Example app listening at http://0.0.0.0:8080
^CGracefully stopping... (press Ctrl+C again to force)
Stopping dockerapp_web_1... done
Stopping dockerapp_redis_1... done

```

## Les données dans docker

Pour l'instant, à chaque fois que l'on lance `docker-compose up`, notre stack repart de 0. Ce qui n'est pas très pratique.
Une facon de traiter de données persistentes avec docker, consiste à utiliser les volumes.

Concernant redis, il faut tout d'abord activer la persistence. Le service doit être lancé avec l'option `--appendonly yes`.

En ligne de commande cela donnerait

```bash
docker run redis redis-server --appendonly yes
```

De plus, on peut spécifier vers quel stockage on lie un volume du container. Pour le service redis, quand la persistence est activée, les données sont écrites dans le répertoire `/data`. On se crée donc un repertoire `data`dans notre projet.

```bash
mkdir data
```

Ce qui donne comme structure :

```
monAppDocker
├── .dockerignore
├── Dockerfile
├── data
└── src
    ├── index.js
    └── package.json
```

On peut maintenant lancer un service redis qui gardera les modifications.

```bash
docker run -v data:/data redis redis-server --appendonly yes
```

Je vous laisse vous convaincre que cela fonctionne en relançant l'application dans un autre terminal...

Et si on applique toutes ces modifications dans le `docker-compose.yml`, cela nous donne :

```yaml
web:
  build: .
  ports:
    - "8080:8080"
  volumes:
    - ./src:/src
    - /src/node_modules
  links:
    - redis
redis:
  image: redis
  command: redis-server --appendonly yes
  volumes:
    - ./data:/data
```

On relance le tout ...

```bash
docker-compose up
Starting project_redis_1
Starting project_web_1
Attaching to project_redis_1, project_web_1
redis_1  |                 _._
redis_1  |            _.-``__ ''-._
redis_1  |       _.-``    `.  `_.  ''-._           Redis 3.2.1 (00000000/0) 64 bit
redis_1  |   .-`` .-```.  ```\/    _.,_ ''-._
redis_1  |  (    '      ,       .-`  | `,    )     Running in standalone mode
redis_1  |  |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
redis_1  |  |    `-._   `._    /     _.-'    |     PID: 1
redis_1  |   `-._    `-._  `-./  _.-'    _.-'
redis_1  |  |`-._`-._    `-.__.-'    _.-'_.-'|
redis_1  |  |    `-._`-._        _.-'_.-'    |           http://redis.io
redis_1  |   `-._    `-._`-.__.-'_.-'    _.-'
redis_1  |  |`-._`-._    `-.__.-'    _.-'_.-'|
redis_1  |  |    `-._`-._        _.-'_.-'    |
redis_1  |   `-._    `-._`-.__.-'_.-'    _.-'
redis_1  |       `-._    `-.__.-'    _.-'
redis_1  |           `-._        _.-'
redis_1  |               `-.__.-'
redis_1  |
redis_1  | 1:M 14 Nov 18:31:57.351 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
redis_1  | 1:M 14 Nov 18:31:57.352 # Server started, Redis version 3.2.1
redis_1  | 1:M 14 Nov 18:31:57.352 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
redis_1  | 1:M 14 Nov 18:31:57.353 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
redis_1  | 1:M 14 Nov 18:31:57.358 * DB loaded from append only file: 0.005 seconds
redis_1  | 1:M 14 Nov 18:31:57.358 * The server is now ready to accept connections on port 6379
web_1    | Example app listening at http://:::8080
```

On va sur http://localhost:8080 pour faire monter le compteur. Et que voit-on dans le répertoire `data` ?

```bash
tail -f data/appendonly.aof
2
$6
SELECT
$1
0
*3
$3
set
$2
un
$4
duex
*2
$6
SELECT
$1
0
*2
$4
incr
$7
counter
*2
$4
incr
$7
counter
*2
$4
incr
$7
counter
*2
$6
SELECT
$1
0
*2
$4
incr
$7
counter
*2
$4
incr
$7
counter
```


Et voilà \ò/ (Salut tintin). On peut passer à l'étape suivante, et se diriger vers l'informatique dans les nuages.



## Docker Machine

aka déploiement sur EC2 via la machinerie docker.

Inconvénient, docker-machine provisionne une instance, et permet de configurer le client local pour adresser un docker sur cette instance. Pour adresser plusieurs instances, il faut se tourner vers `docker-swarm`.

Pour tester, une fois installé, pour provisionner une instance VirutalBox en local, et une isntance sur EC2, chacune avec docker de préinstallé, on fait (Attention au nommage de l'instance dans EC2)

```bash
$ docker-machine create --driver virtualbox \
--virtualbox-memory 1024 dev;
No default boot2docker iso found locally, downloading the latest release...
Downloading https://github.com/boot2docker/boot2docker/releases/download/v1.8.2/boot2docker.iso to /home/bobuss/.docker/machine/cache/boot2docker.iso...
Creating VirtualBox VM...
Creating SSH key...
Starting VirtualBox VM...
Starting VM...
To see how to connect Docker to this machine, run: docker-machine env dev


$ docker-machine create \
--driver amazonec2 \
--amazonec2-access-key your-aws-access-key \
--amazonec2-secret-key your-aws-secret-key \
--amazonec2-vpc-id your-aws-vpc-id \
--amazonec2-subnet-id your-aws-subnet-id \
--amazonec2-region us-east-1 \
--amazonec2-zone a \
ec2box_bobuss
Launching instance...
To see how to connect Docker to this machine, run: docker-machine env ec2box_bobuss

$ docker-machine ls
NAME            ACTIVE   DRIVER       STATE     URL                         SWARM
dev                      virtualbox   Running   tcp://192.168.99.100:2376
ec2box_bobuss            amazonec2    Running   tcp://54.85.61.184:2376

```

La commande `docker-machine env XXXX` exporte dans les variable d'environnement de docker la configuration de l'instance demandée.

Par exemple, pour configurer son client docker pour utiliser l'hôte virtualbox, on execute

```bash
$ eval "$(docker-machine env dev)"
```

Maintenant, toute commande docker adressera le docker hébergé sur le VirtualBox en local.

De manière symétrique, pour adresser le docker hebergé sur EC2 :

```bash
$ eval "$(docker-machine env ec2box_bobuss)"
```

Et ainsi, toute commande docker s'adressera au docker hébergé sur l'instance EC2.



Enfin, pour retrouver le paramétrage de notre docker local,

```
$ eval "$(docker-machine env -u)"
```

---

#### Licence

Cette œuvre est mise à disposition selon les termes de la Licence [Creative Commons Attribution 3.0 France](https://creativecommons.org/licenses/by/3.0/fr/).

[![Licence Creative Commons](https://i.creativecommons.org/l/by/3.0/fr/88x31.png)](https://creativecommons.org/licenses/by/3.0/fr/)
