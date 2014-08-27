Jenkins CI
==========

This directory allows you to bring up a development environment for running Jenkins CI within a virtual machine on your local host.

Requirements
------------

Before experimenting locally, you must have the following items installed and working:

* [VirtualBox](https://www.virtualbox.org/) >= v4.3.12
* [Vagrant](http://vagrantup.com/) >= v1.6.x
* [Ansible](http://docs.ansible.com/intro_installation.html) >= v1.6.x

If you're using a Mac, it's easiest to just: `brew install ansible`

(But if that does not work, `pip install ansible` is an alternative.)

Working on Jenkins
------------------

### TL;DR

    $ cd vagrant/jenkins/
    $ vagrant up
    $ vagrant ssh

Then the admin dashboard should be available at http://192.168.111.99:8080/ and accessible from your own machine.

### Memory Usage

By default, the development VM is configured to use 2048 MB of RAM. If you'd like to change that, simply export the `$JENKINS_MEMORY` environment variable with a string of your desired amount (in MB) before bringing up the machine:

    $ export JENKINS_MEMORY='4096'
    $ vagrant up
