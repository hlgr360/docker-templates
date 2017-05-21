# Fluentd Shipper

For each log source you must deploy a log shipper that would push the log messages to a centralized log aggregator instance.

## Sample fluentd shipper
In the sample provided you will find a configuration that would tail a log file


***

## Setup and Usage
For the shipper to communicate securely with the aggregator instance we use the `secure-forward` output plugin.

For more information about the plugin check: https://github.com/tagomoris/fluent-plugin-secure-forward

When setting up the aggregator a certificate is generated in `.pem` format. That certificate is also required for all shippers that will push messages to that aggregator.

Steps to set up the shipper:
1. Replace `/certs/ca_cert.pem` with the certificate used by the aggregator's `secure-forward` input plugin.
2. Create an **env-file** or modify the supplied `sampleEnvFile.properties` to provide the correct configuration input values.
3. Modify the `/config/td-agent-shipper.conf` file according to the needs of the log source to be monitored.
  *  By default the shipper is monitoring a log file called file.log that is found on the mountable volume `/fluentd/log/` and are issued with the tag set via `FLUENTD_TAIL_TAG`
  * To make sure that it would work straight out of the box there is a `<match default.**>` that rewrites the tags of log messages to tags that would be matched by the sample provided filter and output match tag. Feel free to change the tags and overall message pipeline as needed.
  * Be sure to also read up on the documentation for each filter to know the default values for certain parameters so that you can avoid unwanted behavior - [default values](../README.md#beware-of-default-values)

Build locally with `docker build --tag=<name_your_shipper> .` in the FluentDShipper folder.

Run with `docker run --env-file=sampleEnvFile.properties <the_name_given_before>`

If you need to check the values of the environment variables run `docker run --rm <image_name> env`.
