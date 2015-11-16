# Log Aggregation

This Docker template allows for the quick deployment of a fully functioning EFK Stack along with an nginx web server that will enable Basic authentication access control to kibana.

## Quick & Easy Startup

`docker-compose up` :smile:

You can then access Kibana on [http://localhost:80](http://localhost:80) and login with the default username & password.

* * *

## Setup & Usage

1. Generate username & pwd htpasswd file
```bash
  sudo apt-get install apache2-utils
  sudo htpasswd -c htpasswd.users <username> <password>
```
