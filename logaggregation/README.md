# Log Aggregation
- - -

This Docker template allows for the quick deployment of a fully functioning EFK Stack along with an nginx web server that will enable Basic authentication access control to kibana.

## Quick & Easy Startup

`docker-compose up` :smile:

You can then access Kibana on [http://localhost:80](http://localhost:80) and login with the default username & password.

* * *

## Setup & Usage

### 1. Generate username & pwd htpasswd file
```bash
sudo apt-get install apache2-utils
sudo htpasswd -c htpasswd.users <username> <password>
```
Then replace the existing file under `EFK/nginx` .

### 2. Configure fluentd  aggregator

* Make changes to `EFK/fluentd/config/td-agent-aggregator.conf` as needed.

* Generate new client certificates
https://github.com/tagomoris/fluent-plugin-secure-forward#using-private-ca-file-and-key and replace existing files in `/fluentd/certs`

* Change `shared_key` in config file

* Change credentials for authentication in config file. Authentication can also be disabled by setting `authentication` to `false` or `no`

### Beware of default values
 Be aware that each plugin used has default values for certain configurable parameters and to avoid unwanted behavior or to tweak the system optimally you should refer to the github pages of the individual plugin.

 A good example is the elasticsearch plugin that by default has buffering enabled with a flush_interval of 60sec so if you were wondering why your log messages are popping up in elasticsearch with a delay...

So be sure to RTM:
 - [fluent-plugin-elasticsearch](https://github.com/uken/fluent-plugin-elasticsearch)
 - [fluent-plugin-secure-forward](https://github.com/tagomoris/fluent-plugin-secure-forward)
 - [fluent-plugin-rewrite-tag-filter](https://github.com/fluent/fluent-plugin-rewrite-tag-filter)



### 3. Start it up :v:

Run `docker-compose up` in `/ELK/` and once finished you can access Kibana on [http://localhost:80](http://localhost:80) and login with the credentials you created in the setup phase.

.. include:: FluentDShipper/README.md

### 4. Client fluentd configuration

>The steps for setting up the fluentd shipper that is provided in this repo see the corresponding [README.md](./FluentDShipper/README.md)

For setting up a stand-alone fluentd instance or the more easy to use [td-agent](http://docs.fluentd.org/articles/install-by-deb#what-is-td-agent) please follow these main steps.

To be able to send log messages to the aggregator instance, all fluentd shipper instances must be configured accordingly:
* Use the same `secure-forward` output plugin for sending log messages
* Set `secret_key` to the same value as aggregator
* Copy the `<certificate>.pem` that was used for the aggregator and use it in the configuration of the `secure-forward` output plugin of the shipper
* Set destination address and port according to the values set in the `docker-compose.yml` file.

Then configure the input that you will be sending. This can be anything that fluentd offers support for: http://www.fluentd.org/datasources

***
Recommended video to get up to speed on how fluend works:

[![Recommended Quick Ramp-up video](http://img.youtube.com/vi/sIVGsQgMHIo/0.jpg)](https://www.youtube.com/embed/sIVGsQgMHIo)
