twitter-kinesis-kafka-storm_vagrant
====

"Twitter Stream -> **Producer** -> (AWS Kinesis | Apache Kafka) -> Apache Storm[**WordCounter**] -> Redis" example.

This is vagrant project for VirtualBox.

## Description

This Vagrantfile and Berksfile constructs two VMs on VirtualBox.

* VM1 : Apache Kafka and Apache Zookeeper
* VM2 : Apache Storm and Redis

## Related Project

* Berksfile and Vagrantfile(**this project**) : https://github.com/nmatsui/twitter-kinesis-kafka-storm_vagrant
* WordCounter : https://github.com/nmatsui/twitter-kinesis-kafka-storm_wordcounter
* Producer : https://github.com/nmatsui/twitter-kinesis-kafka-storm_producer
* Kinesis-storm-spout : https://github.com/nmatsui/kinesis-storm-spout

## Requirements

This project depends on "vagrant 1.6.x" and "berkshelf 3.1.x".  
And this vagrantfile depends on "vagrant-omnibus 1.4.x" and "vagrant-vbguest 0.10.x".

## Install

### Clone this project

1. `git clone https://github.com/nmatsui/twitter-kinesis-kafka-storm_vagrant.git`

## Usage

1. `berks vendor cookbooks`
1. `vagrant up --provision`

## License
Apache License, Version 2.0
 
## Author
Nobuyuki Matsui (nobuyuki.matsui@gmail.com)
