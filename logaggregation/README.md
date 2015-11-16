# Log Aggregation

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

### 3. Start it up :v:

Run `docker-compose up` in `/ELK/` and once finished you can access Kibana on [http://localhost:80](http://localhost:80) and login with the credentials you created in the setup phase.

### 4. Client fluentd configuration
This description makes references to the fluentd docker image within this repository but the same steps can be taken with a stand-alone `td-agent` installation that is to be used to push messages to the EFK installation previously created.  

To be able to send log messages to the aggregator instance, all fluentd shipper instances must be configured accordingly:
* Use the same `secure-forward` output plugin for sending log messages
* Set `secret_key` to the same value as aggregator
* Copy the `<certificate>.pem` that was used for the aggregator to the `FluentDShipper/certs` folder
* Set `FLUENTD_AGGREGATOR_ADDR` and `FLUENTD_AGGREGATOR_PORT` in `FluentDShipper/Dockerfile` to the address and port used by the aggregator instance.

Then configure the input that you will be sending. This can be anything that fluentd offers support for: http://www.fluentd.org/datasources

And depending on that you might also need to modify the `FluentDShipper/Dockerfile`.

With the example configuration file provided you must mount a volume mapped to `/fluentd/log` and modify the file path in the source plugin in the `td-agent-shipper.conf`.
