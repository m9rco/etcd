<p align="center">
<img src="logo.png" width=300/>
</p>

# Etcd 

<p align="center">
  
[![Author](https://img.shields.io/badge/Author-m9rco-Green.svg?style=flat&logo=tinder)](https://about.me/pushaowei/)
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=102)](https://travis-ci.org/m9rco/etcd/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/m9rco/etcd/pulls)
[![Build Status](https://travis-ci.org/m9rco/etcd.svg?branch=master)](https://travis-ci.org/m9rco/etcd) 
![Docker Pulls](https://img.shields.io/docker/pulls/m9rco/etcd.svg?style=flat-square)

</p>

## Images

- [2.0.10](2.0.10)
- [3.3.13](3.3.13)


## Usage

The recommended way to get the m9rco etcd Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/m9rco/etcd).

```sh
docker pull m9rco/etcd:latest
```

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/m9rco/etcd/tags/) in the Docker Hub Registry.

```sh
$ docker pull m9rco/etcd:[TAG]
```


## Using the Command Line


### Step 1: Create a network

```sh
docker network create app-tier --driver bridge
```

### Step 2: Launch the etcd server instance

Use the --network app-tier argument to the docker run command to attach the etcd container to the app-tier network.

```sh
 docker run -d --name etcd-server \
    --network app-tier \
    --publish 2379:2379 \
    --publish 2380:2380 \
    --env ALLOW_NONE_AUTHENTICATION=yes \
    --env ETCD_ADVERTISE_CLIENT_URLS=http://etcd-server:2379 \
    m9rco/etcd:latest
```    

### Step 3: Launch your etcd client instance

Finally we create a new container instance to launch the etcd client and connect to the server created in the previous step:

```
docker run -it --rm \
    --network app-tier \
    --env ALLOW_NONE_AUTHENTICATION=yes \
    m9rco/etcd:latest etcdctl --endpoints http://etcd-server:2379 set /message Hello
```

## Exec

```sh
 docker exec 3313_etcd_1 sh -c 'ETCDCTL_API=3  etcdctl get "name" "m9rco"'
```

## Using Docker Compose

When not specified, Docker Compose automatically sets up a new network and attaches all deployed services to that network. However, we will explicitly define a new bridge network named app-tier. In this example we assume that you want to connect to the etcd server from your own custom application image which is identified in the following snippet by the service name myapp.

```yaml

version: '2'

networks:
  app-tier:
    driver: bridge

services:
  etcd:
    image: 'm9rco/etcd:latest'
    environment:
      - ALLOW_NONE_AUTHENTICATION=yes
      - ETCD_ADVERTISE_CLIENT_URLS=http://etcd:2379
    ports:
      - 2379:2379
      - 2380:2380
    networks:
      - app-tier
  myapp:
    image: 'YOUR_APPLICATION_IMAGE'
    networks:
      - app-tier
```

> IMPORTANT: > > 1. Please update the placeholder YOUR_APPLICATION_IMAGE in the above snippet with your application image > 2. In your application container, use the hostname etcd to connect to the etcd server

### Launch the containers using:

```sh
docker-compose up -d
```

### Configuration

The configuration can easily be setup by mounting your own configuration file on the directory `/home/app/etcd/conf`:

```sh
docker run --name etcd -v /path/to/etcd.conf.yml:/home/app/etcd/conf/etcd.conf.yml m9rco/etcd:latest
```

After that, your configuration will be taken into account in the server's behaviour.

Using Docker Compose:

```yaml
version: '2'

services:
  etcd:
    image: m9rco/etcd:latest
    environment:
      - ALLOW_NONE_AUTHENTICATION=yes
      - ETCD_ADVERTISE_CLIENT_URLS=http://etcd:2379
    ports:
      - '2379:2379'
      - '2380:2380'
    volumes:
      - /path/to/etcd.conf.yml:/home/app/etcd/conf/etcd.conf.yml
```

You can find a sample configuration file on this link

Apart from providing your custom configuration file, you can also modify the server behavior via configuration flags exposed as environment variables.

For example if you want to modify the flag --my-flag, you will need to set the ETCD_MY_FLAG environment variable.

The previous rule applies to all etcd flags.

### Further documentation
For further documentation, please check etcd documentation or its GitHub repository

### Contributing
We'd love for you to contribute to this container. You can request new features by creating an issue, or submit a pull request with your contribution.    
