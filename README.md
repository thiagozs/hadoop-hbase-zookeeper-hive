# Vagrant + Hadoop Cluster + Hbase + Zookeeper + Hive

Objetivo desse projeto estudo é levantar 4 maquinas virtuais em cluster
rodando [Apache Hadoop](http://hadoop.apache.org) pre-instalado.

Algumas informações foram retiradas do site.
http://cscarioni.blogspot.co.uk/2012/09/setting-up-hadoop-virtual-cluster-with.html

## Deploy do Cluster

Primeiramente precisaremos duas ferramentar para a execução da virtualização. Mas atenção,
esse tutorial somente vai funcionar em ambiente *UNIX.

Com seu *UNIX já configurado e rodando tudo 100%. Instale.

* [Virtual Box](http://virtualbox.org) 
* [Vagrant](http://vagrantup.com/)

Todas as informações de como instalar estão nas faqs e docs dos próprios sites.

Feito todo o processo de instalação das duas ferramentas, clone o projeto, e faça o
download dos Boxes que irão instalar como base. A meu gosto, utilizei o ubuntu, 
apesar de não ser o melhor, me facilitou muito na hora das instalações.

Executando o [Vagrant](http://vagrantup.com/) para subir o iso e startando a VM:

    $ vagrant box add ubuntu64 http://files.vagrantup.com/precise64.box
    $ vagrant up

O script vai levantar 4 máquinas de 512mb de memoria - `master`, `hadoop1`, `hadoop2` 
e `hadoop3`. Ajustes edite `Vagrantfile`.

As máquinas utilizam o [Puppet](http://puppetlabs.com/) para instalar e configura
todos aplicativos necessários utilizados no cluster.

Diretório padrão de instalação é `/opt/xxxxxxx-0.0.0` e todos estão em `PATH`.

A maquina `master` executa o namenode and jobtracker, o restante é data
nodes e trackers.

### Inicio Cluster

Depois de rodar o [Vagrant](http://vagrantup.com/), vamos formatar o [Apache Hadoop](http://hadoop.apache.org) na master.

     $ vagrant ssh master
     $ (master) sudo /opt/hadoop-1.2.1/bin/hadoop namenode -format -force
     $ (master) sudo /opt/hadoop-1.2.1/bin/start-all.sh
     $ (master) sudo /opt/hbase-0.94.11/bin/start-hbase.sh

### Para o Cluster

     $ vagrant ssh master
     $ (master) sudo stop-all.sh
     $ exit or Ctrl-D
     $ vagrant halt

utilizando de novo o cluster:

     $ vagrant up
     $ vagrant ssh master
     $ (master) sudo start-all.sh


### Destruindo o Cluster

     $ vagrant destroy

Isso irá excluir no modo HARD, os arquivos salvos não serão possíveis restauração.
     

## Interface WEB

### Visualizando a inteface do Hadoop

Inserindo o mesmo range de ips que foi utilizado para gerar o cluster, será necessário
colocar eles dentro do seu /etc/hosts.

namenode : http://master.local:50070/dfshealth.jsp
jobtracker : http://master.local:50030/jobtracker.jsp

### Visualizando a inteface do Hbase

master : http://master.local:60010/master-status

### Vagrant comandos.

Logar na maquina master.

    $ vagrant ssh master
    $ (master) hadoop fs -ls /
    $ ...

## Hadoop base de dados
    namenode : `/srv/hadoop/namenode` 
    datanodes : `/srv/hadoop/datanode`

### Puppet (automação)

Caso alguma alteração no Vagrantfile, e precise testa-lo ou replica-lo, utilize :

    $ vagrant provision

### Atualizações do projeto

- patchs, atualizações e dicas são bem-vindas neste projeto. =)
