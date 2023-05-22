# unity-docker

## Description
This is a simple project, that extends https://github.com/ConSol/docker-headless-vnc-container, to include the installation of Unity Hub.

With this project you'll be able to run Unity inside a Docker container and use it on a web browser on the host machine.

**Note:** This project was created only with the purpose of learning. It may have issues and not work entirely. Use at your own risk.

## Instructions

This project contains a git submodule for a [fork](https://github.com/RuiSanches/docker-headless-vnc-container) of https://github.com/ConSol/docker-headless-vnc-container in consol-docker-headless-vnc-container folder. After cloning the unity-docker project, you should also run the command in the root of the unity-project:

```sh
git submodule update --init --recursive
```

To keep the submodule updated you can run in the root of the unity-project:

```sh
git submodule update --remote --recursive
```

## Usage

Given this project extends from https://github.com/ConSol/docker-headless-vnc-container, all that is supported there, is also supported in this project (you can take a look at the several ways of using the images).

To build the image and run the container you should run the following commands:

```sh
# Builds the consol debian-xfce-vnc docker image (the project image depends on this one)
docker build -t local-debian-xfce-vnc consol-docker-headless-vnc-container -f consol-docker-headless-vnc-container/Dockerfile.debian-xfce-vnc

# Builds this project image
docker build -t unity-docker-img .
# You can also specify the unityhub version, if you do not want the latest
# docker build --build-arg UNITYHUB_VERSION=3.4.2 -t unity-docker-img .

# Runs the container
# vnc port 5901 and noVNC port 6901 (web client)
docker run -d -p 5901:5901 -p 6901:6901 --name=unity-docker unity-docker-img
```

Now all you have to do is open a web browser and access the url:
```sh
# full client with default password -> vncpassword (you will be prompted to insert the password)
http://localhost:6901/vnc.html

# or

# lite client
http://localhost:6901/?password=vncpassword
```

To use Unity Hub, you can open a terminal and run:
```sh
unityhub
```

## Avanced Use Cases

You will likely want to persist data, even after stopping the container. For that reason you can use the docker-compose instead.

Besides persisting data using a volume, there is also a bind mount, that allows you to mount a specific directory to store your Unity projects (you can change the directory on the docker-compose file). This way you can change the code directly on the host machine, and see those changes automatically in Unity, on the container.

To use the docker-compose, you can run the following commands:
```sh
# Builds the consol debian-xfce-vnc docker image (the project image depends on this one)
docker build -t local-debian-xfce-vnc consol-docker-headless-vnc-container -f consol-docker-headless-vnc-container/Dockerfile.debian-xfce-vnc

# Create and start the container with the appropriate volume
docker compose up
```

## Troubleshooting

If for some reason, while installing the editor in UnityHub you start seeing errors, make sure you have enough space allocated.

After installing the editor you can navigate to the folder /tmp, where you'll notice a folder called unityhub- followed by a bunch of characters (e.g. unityhub-ab12c2d4-f567-88gh-9i0j-1k234567890l). This will be the unity editor installation file, which you should be able to delete to get more free space.
