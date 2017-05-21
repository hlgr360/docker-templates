#docker-kong-dashboard

This Dockerfile can be used to run [kong dashboard](https://github.com/PGBI/kong-dashboard) in docker.

## Building

First, build the docker image:

```
docker build -t kong-dashboard .
```

If you only want to try out Kong using the dashboard, follow these instructions:

## Get Kong and Cassandra

Follow the instructions from Kong on how to get Kong and Cassandra up and running in Docker:

* https://getkong.org/install/docker/

**Note**: Depending on your OS, Kong will not run on `localhost`, but on your `DOCKER_HOST`, which is installation dependant. Mostly on Windows it will be `192.168.99.100` (but it's stated in your Docker Quickstart Terminal's `env` environment).

**Note 2**: Wait for approximately 10-20 seconds after starting Cassandra before you start Kong. It takes a little while for Cassandra to open up its ports for Kong to communicate with it. If you did it too early, Kong will just exit again. Starting up Kong again requires you to first either delete the container and re-issue the `run`, or to start the container again using its ID (which you can get using `docker ps -a`).

## Run Kong Dashboard

Now you can run Kong dashboard using the following docker command (assuming you used exactly the commands from the Kong installation guide for starting Kong):

```
docker run -p 8080:8080 -d --name kong-dashboard --link kong:kong kong-dashboard
```

If you're lucky, now you'll be able to call the Kong Dashboard on

```
http://<DOCKER_HOST>:8080
```

### Troubleshooting

In case your connection is refused to this port, please check the state of the following issue:

* https://github.com/PGBI/kong-dashboard/issues/10

If it's still open, you will have to tweak your container to make the node.js gulp server also serve other hosts than `localhost`, by doing the following things:

Get the ID of your kong-dashboard container by issuing the following command:

```
docker ps -a
```

Using that ID, call

```
docker exec -it <dashboard container id> bash
```

Now you're inside the dashboard container in a bash script; now, issue the following command:

```
root@<dashboard container id>:/# vi /kong-dashboard/gulpFile.js
```

Inside that file, locate the following lines:

```javascript
    gulp.src('public')
        .pipe(webserver({
            livereload: false,
            directoryListing: false,
            open: true,
            port: 8080
        }));
```

Insert the line with `host` so that it looks like this:


```javascript
    gulp.src('public')
        .pipe(webserver({
            livereload: false,
            host: "0.0.0.0",
            directoryListing: false,
            open: true,
            port: 8080
        }));
```

Save the file (for `vi` dummies like me: `Esc` `:x`).

Now exit the container (`exit`), then restart it:

```
docker stop <dashboard container id>
docker start <dashboard container id>
```

Now you should be good to go.

## Using kong-dashboard

The first thing kong-dashboard will ask you for is the URL of the Kong administration port.

Note that all requests from kong-dashboard will be done as CORS requests **from the browser**, and not as server side requests. The URL is thus the URL which has to be used to access the Kong admin port **from the system your browser runs on**.

Note that this normally is not possible at all (as it must be closed off the public network). A workaround for this is to ssh into your host and tunnel the admin port to `localhost`, e.g. using PuTTY or a similar tool.

This also applies if you have provisioned Kong, Cassandra and Kong-Dashboard on a virtual machine e.g. from Azure or AWS. You would definitely not want to expose the 8001 port to the public internet.  