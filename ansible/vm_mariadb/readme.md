#Configuration automatique d'une VM avec mariadb

##lycée Fulbert - lmery

###To Do

En cas de problème avec les vbguest-tools

Bien vérifier que le plugin vagrant vbguest est bien installé. Voir doc [ici](https://github.com/dotless-de/vagrant-vbguest)

se connecter en ssh à la VM via

`vagrant ssh

```\
sudo apt update
sudo apt-get upgrade
sudo apt-get dist-upgrade
```

quitter la session ssh puis faire un

`vagrant reload

Tant que les guest tools ne sont pas correctement installé le provisionnement ne fonctionnera pas car il faut monter le volume dans la VM.

Pour provisionner:
`vagrant provision




