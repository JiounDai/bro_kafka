# bro_kafka
bro with kafka, add writers of kafka, in directory of src/logging/writers/kafka

the conf of kafka : scripts/base/frameworks/logging/writers/kafka.bro, config your kafka address

Bro is a powerful framework for network analysis and security monitoring.
You can download source and binary releases on:

    http://www.bro.org/download

To get the current development version, clone our master git
repository:

    git clone --recursive git://git.bro.org/bro

For more documentation, research publications, and community contact
information, please see Bro's home page:

    http://www.bro.org
    
Setup:
Before setup bro with kafka, you need setup librdkafka, here: https://github.com/edenhill/librdkafka.

After librdkafka has been setup, we can setup bro with kafka.
