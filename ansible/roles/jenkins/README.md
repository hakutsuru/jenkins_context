Jenkins CI
==========

An extensible open source continuous integration server.

Testing with Vagrant
--------------------

Jenkins supports an architecture consisting of a master server with additional build slaves. This Jenkins playbook only configures the master server with default settings.

Adding New Jobs
---------------

Jenkins uses XML files to define jobs. It's easiest to use the web interface to configure your new jobs, and then copy their configuration files from your VM to the local host before checking them into Git.

1. Copy the *config.xml* file for your job to the local host
2. Rename it to have the title of your job and give it the extension *.xml.j2*
3. Put the file under the *roles/jenkins/templates/jobs/* directory
4. Ansible will handle the rest during provisioning

For example, if you've launched the *jenkins* VM and created a job named "new-job", you could copy it off of the VM and put it into the proper place with:

    $ cd infrastructure/vagrant/jenkins/
    $ vagrant ssh
    $ cd /var/lib/jenkins/jobs/new-job
    $ more config.xml

Then copy the contents of config.xml to your job template, inserting variables and includes where appropriate.

References
----------

* [Upstream Documentation](http://jenkins-ci.org/)
