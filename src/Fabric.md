---
lang: fr
pagetitle: INSSET - Master 2 Cloud Computing - Fabric
---

[retour](index.html)

# Introduction à Fabric

Fabric est une librairie python ainsi qu'un outil en ligne de commande visant à simplifier l'utilisation de SSH lors du déploiement d'applications ou lors de tâches d'administration système.


## Installation

C'est un projet python :

```bash
$ pip install fabric
```


## Utilisation basique

Dans un fichier `fabfile.py`, à la racine de notre projet.

```python
from fabric.api import task

@task
def hello():
    print("Hello world!")

```
_NB : la syntaxe `@task est un décorateur en python : C'est un design pattern qui permet d'attacher dynamiquement des foncionnalités à une fonction_

Puis, on lance la tâche

```bash
$ fab hello
Hello world!

Done.
```


## Execution de commandes en local

```python
from fabric.api import task, local

@task()
def commit_and_push():
    local("nosetests tests/unit/")
    local("git add -p && git commit")
    local("git push")
```
_NB : nosetests est une librairie de tests pour python_

Ce qui donne :

```bash
$ fab commit_and_push
...........

Ran 55 fabulous tests in 0.2529 seconds

[localhost] run: git add -p && git commit

<interactive Git add / git commit edit message session>

[localhost] run: git push

<git push session, possibly merging conflicts interactively>

Done.
```


## Un peu d'organisation, que diable !

```python
from fabric.api import task, local

@task
def test():
    local("nosetests tests/unit/")

@task
def commit():
    local("git add -p && git commit")

@task
def push():
    local("git push")

@task
def prepare_deploy():
    test()
    commit()
    push()
```

La tâche `prepare_deploy` est toujours disponible, mais l'organisation plus granulaire permet d'appeler spécifiquement une sous-tâche si besoin.

À noter :

```bash
fab --list
Available commands:

    commit
    prepare_deploy
    push
    test
```

Et allons au bout, en ajoutant les commentaires dans chaque tâche.

```python
from fabric.api import task, local

@task
def test():
    """Runs the tests.
    """
    local("nosetests tests/unit/")

@task
def commit():
    """Put on stage the modified content of the working tree, and commit.
    """
    local("git add -p && git commit")

@task
def push():
    """Push the code to the remote repository.
    """
    local("git push")

@task
def prepare_deploy():
    """Locally Prepare the release : test the code, commit-it and push it to the remote repository.
    """
    test()
    commit()
    push()
```
_NB : En python, un commentaire multiligne en première position d'un function, d'une classe, d'une méthode ou d'un module constitue une `docstring`. Les capacité d'introspection de python permettent de décupérer ce commentaire lors de l'execution d'un script._

Et zou !

```bash
$ fab --list
Available commands:

    commit          Put on stage the modified content of the working tree, and commit.
    prepare_deploy  Locally Prepare the release : test the code, commit-it and push it to the remote repository.
    push            Push the code to the remote repository.
    test            Runs the tests.
```


## Execution distante

C'est bien gentil, mais l'idée à l'origine c'était de pouvoir executer la même tâche sur plusieurs hosts distants... Facile, c'est `run` qui nous allons utiliser dans notre tâche.
On en profite pour ajouter deux-trois petites choses...

```python
from fabric.api import task, settings, run, sudo

@task
def deploy():
    code_dir = '/var/www/my_project'
    # check the existence of the repositiry
    with settings(warn_only=True):
        if run("test -d %s" % code_dir).failed:
            run("git clone user@vcshost:/path/to/repo/.git %s" % code_dir)
    # update
    with cd(code_dir):
        run("git pull")
        sudo("apachectl -k graceful")
```

Et pour lancer la tâche sur une machine:

```bash
$ fab deploy
No hosts found. Please specify (single) host string for connection: my_server
[my_server] run: test -d /var/www/my_project

Warning: run() encountered an error (return code 1) while executing 'test -d /var/www/my_project'

[my_server] run: git clone user@vcshost:/path/to/repo/.git /var/www
[my_server] out: Cloning into /var/www/my_project...
[my_server] out: Password: <enter password>
[my_server] out: remote: Counting objects: 6698, done.
[my_server] out: remote: Compressing objects: 100% (2237/2237), done.
[my_server] out: remote: Total 6698 (delta 4633), reused 6414 (delta 4412)
[my_server] out: Receiving objects: 100% (6698/6698), 1.28 MiB, done.
[my_server] out: Resolving deltas: 100% (4633/4633), done.
[my_server] out:
[my_server] run: git pull
[my_server] out: Already up-to-date.
[my_server] out:
[my_server] sudo: apachectl -k graceful
```

À noter que l'on aurait pu appeler la tâche en passant le host en paramètre :

```
$ fab -H my_server deploy
......
```

## Paramétrage via le dictionnaire d'environnement

Maintenant, on va s'affranchir du passage de paramètre :

Première possiblité :

```
from fabric.api import run, env

env.hosts = ['host1', 'host2']
```

La commande `run` s'executera sur chacun des hosts.


Autre possibilité, les rôles

```
from fabric.api import env

env.roledefs = {
    'web': ['www1', 'www2', 'www3'],
    'db': ['db1']
}
```

Il faudra alors cibler quelle tâche peu executer quel rôle. Par exemple `deploy` sur les frontaux, et `migrate` sur la DB. On utilise pour cela d'autre décorateurs `@hosts` et `@role`.

```python
from fabric.api import run, roles

env.roledefs = {
    'db': ['db1', 'db2'],
    'web': ['web1', 'web2', 'web3'],
}

@roles('db')
def migrate():
    # Database stuff here.
    pass

@roles('web')
def update():
    # Code updates here.
    pass
```


## Fabric en dynamique

Plus fort, maintenant... on va pouvoir depuis le script fabric dynamiquement définir la liste des hosts. La commande `execute` permet de passer un paramètre hosts à un appel de task.

```python
from fabric.api import run, execute, task

# une librairie qui me permet trouver des hosts selon des critères de recherche
from mylib import find_hosts

def do_work()
    """le code à executer sur les hosts
    """
    run("my_super_command")

# et donc la commande qu'on appelle depuis la ligne de commande
@task
def deploy(param=None):
    # c'est ici que la magie opère
    # on récupère la liste des hosts
    host_list = find_hosts(param)

    # et on la passe à notre fonction
    # done.
    execute(do_work, hosts=host_list)

```

Notez bien le `param`. On peut appeler des tâches en passant des paramètres ; ca peut devenir démentiel !

```
$ fab deploy:web
```

```
$ fab deploy:db
```


### Une autre approche (que je préfère)

On va utiliser une autre tâche pour spécifier les hosts

```python
from fabric.api import run, task

from mylib import find_hosts

# cette fois c'est une tache
@task
def do_work():
    run("my_super_command")

@task
def set_hosts(param):
    # On met à jour env.hosts plutôt que d'appeler execute()
    env.hosts = find_hosts(param)

```

Aussi l'appel devient

```
$ fab set_hosts:prod do_work
```

Et au final, on peut imaginer des tâches du genre :

```bash
$ fab set_hosts:db snapshot
$ fab set_hosts:cassandra,cluster2 repair_ring
$ fab set_hosts:redis,environ=prod status
```


## Le cousin Fabtools

Fabtools s'appuie sur fabric pour proposer un ensemble de helpers tout prêts.

Juste l'exemple commenté de la doc :

```python
from fabric.api import *
from fabtools import require
import fabtools

@task
def setup():

    # Require some Debian/Ubuntu packages
    require.deb.packages([
        'imagemagick',
        'libxml2-dev',
    ])

    # Require a Python package
    with fabtools.python.virtualenv('/home/myuser/env'):
        require.python.package('pyramid')

    # Require an email server
    require.postfix.server('example.com')

    # Require a PostgreSQL server
    require.postgres.server()
    require.postgres.user('myuser', 's3cr3tp4ssw0rd')
    require.postgres.database('myappsdb', 'myuser')

    # Require a supervisor process for our app
    require.supervisor.process('myapp',
        command='/home/myuser/env/bin/gunicorn_paster /home/myuser/env/myapp/production.ini',
        directory='/home/myuser/env/myapp',
        user='myuser'
        )

    # Require an nginx server proxying to our app
    require.nginx.proxied_site('example.com',
        docroot='/home/myuser/env/myapp/myapp/public',
        proxy_url='http://127.0.0.1:8888'
        )

    # Setup a daily cron task
    fabtools.cron.add_daily('maintenance', 'myuser', 'my_script.py')
```


## Resources

- Fabric [https://docs.fabfile.org/en/1.9/](https://docs.fabfile.org/en/1.9/)
- Pour les rubyistes... [https://capistranorb.com/](https://capistranorb.com/)
- Fabtools [https://fabtools.readthedocs.io/en/0.17.0/](https://fabtools.readthedocs.io/en/0.17.0/)



---

#### Licence

Cette œuvre est mise à disposition selon les termes de la Licence [Creative Commons Attribution 3.0 France](https://creativecommons.org/licenses/by/3.0/fr/).

[![Licence Creative Commons](https://i.creativecommons.org/l/by/3.0/fr/88x31.png)](https://creativecommons.org/licenses/by/3.0/fr/)
