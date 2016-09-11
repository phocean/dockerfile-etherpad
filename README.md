# Purpose

This is a Dockerfile to build a Docker container running Etherpad on your machine.

Etherpad is a nice Web based share whiteboard, very handy to work in a group or in a class.

# Build

You can build the image with this command:

```
docker build -t debian-etherpad .
```

# Run

Etherpad is started with the following command:

```
docker run -d --name etherpad -p 80:9001 -v etherpad:/opt/etherpad-lite/var -t debian-etherpad
```

I recommend creating an alias with this command in your shell.

After that, you should be able to access to the Web interface from your favorite browser at these URLs:

```
http://127.0.0.1
http://<your LAN IP address>
```

Note that, for persistency, it creates a Docker volume named *etherpad*.

So, even if you delete the container that way:

```
docker rm -f etherpad
```

And you run a new container, previous data will still be available.

The data is preserved in a Docker volume. You can see it there:

```
% docker volume ls
DRIVER              VOLUME NAME
local               etherpad
```

If you want to stop persistency and reset all data, just delete this volume before running a new container:

```
docker volume rm etherpad
```
