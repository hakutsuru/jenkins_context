Jenkins Build Task Context Sharing
==================================

I was working with a team to make continuous integration happen, but not as an approved member of that team. Hence, I was reluctant to add technology, or make suggestions that would require debate.

The project lead already had Jenkins set up, and a testing script which provisioned cloud resources and tested the web application. I was to create an AMI from the tested resource.

I integrated this into the testing script, but it was deemed too complex. I would normally chain parameterized jobs together, but the plug-in was not installed. Also, it made sense to consider image-generation part of testing.

So I devised a hack to share Jenkins context between shell tasks.

The solution is to store important variables and their values in a text file in the build folder, and load these variables in another task environment where required. Example task scripts are stored in the default shared directory of the vagrant environment for simplicity.


While I am sure this could be much improved by a bash scripting expert, or made "general", it suited the purpose.


Testing with Vagrant
--------------------

First, launch and provision the jenkins environment:

    $ cd jenkins_context/vagrant/jenkins
    $ vagrant up

You may then access Jenkins via http://192.168.111.99:8080/


Job Testing
-----------

Explore the example_job and its configuration.

Click `Build Now`, and then the link for #1 under Build History.

Clicking Console Output, you should see something similar to this:

```
Started by user anonymous
Building in workspace /var/lib/jenkins/workspace/example_job
[example_job] $ /bin/sh -xe /tmp/hudson7227557787717119547.sh
+ /bin/bash -x /vagrant/test_01.sh
++ dirname /vagrant/test_01.sh
+ . /vagrant/test_functions.sh
+ INSTANCE_ID=i-7c97aa82
+ KEY_PAIR_NAME=jenkins_testing
+ SECURITY_GROUP_ID=sg-7ba8b919
+ save_job_env i-7c97aa82 jenkins_testing sg-7ba8b919
+ INSTANCE_ID=i-7c97aa82
+ KEY_PAIR_NAME=jenkins_testing
+ SECURITY_GROUP_ID=sg-7ba8b919
++ echo /var/lib/jenkins/jobs/example_job/builds/1/
+ my_directory=/var/lib/jenkins/jobs/example_job/builds/1/
++ echo jenkins-example_job-1-env
+ env_file=jenkins-example_job-1-env
+ env_path=/var/lib/jenkins/jobs/example_job/builds/1/jenkins-example_job-1-env
+ echo INSTANCE_ID=i-7c97aa82
+ echo KEY_PAIR_NAME=jenkins_testing
+ echo SECURITY_GROUP_ID=sg-7ba8b919
[example_job] $ /bin/sh -xe /tmp/hudson7426556713366106201.sh
+ /bin/bash -x /vagrant/test_02.sh
++ dirname /vagrant/test_02.sh
+ . /vagrant/test_functions.sh
+ echo '========== before load ============'
========== before load ============
+ env
XDG_SESSION_ID=2
HUDSON_SERVER_COOKIE=f8767e3d8fd2cc7b
SHELL=/bin/bash
TERM=unknown
BUILD_TAG=jenkins-example_job-1
WORKSPACE=/var/lib/jenkins/workspace/example_job
USER=jenkins
JENKINS_HOME=/var/lib/jenkins
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
MAIL=/var/mail/jenkins
PWD=/var/lib/jenkins/workspace/example_job
LANG=en_US.UTF-8
JOB_NAME=example_job
BUILD_DISPLAY_NAME=#1
BUILD_ID=2014-08-25_23-31-24
HOME=/var/lib/jenkins
SHLVL=2
EXECUTOR_NUMBER=0
JENKINS_SERVER_COOKIE=f8767e3d8fd2cc7b
NODE_LABELS=master
LOGNAME=jenkins
HUDSON_HOME=/var/lib/jenkins
NODE_NAME=master
BUILD_NUMBER=1
XDG_RUNTIME_DIR=/run/user/1000
HUDSON_COOKIE=d9c20b74-8945-4df7-a333-65b8a73535c5
_=/usr/bin/env
+ echo ==================================
==================================
+ load_job_env
++ echo /var/lib/jenkins/jobs/example_job/builds/1/
+ my_directory=/var/lib/jenkins/jobs/example_job/builds/1/
++ echo jenkins-example_job-1-env
+ env_file=jenkins-example_job-1-env
+ env_path=/var/lib/jenkins/jobs/example_job/builds/1/jenkins-example_job-1-env
+ read line
+ export INSTANCE_ID=i-7c97aa82
+ INSTANCE_ID=i-7c97aa82
+ read line
+ export KEY_PAIR_NAME=jenkins_testing
+ KEY_PAIR_NAME=jenkins_testing
+ read line
+ export SECURITY_GROUP_ID=sg-7ba8b919
+ SECURITY_GROUP_ID=sg-7ba8b919
+ read line
+ echo '========== after load ============'
========== after load ============
+ env
XDG_SESSION_ID=2
HUDSON_SERVER_COOKIE=f8767e3d8fd2cc7b
SHELL=/bin/bash
TERM=unknown
BUILD_TAG=jenkins-example_job-1
SECURITY_GROUP_ID=sg-7ba8b919
WORKSPACE=/var/lib/jenkins/workspace/example_job
USER=jenkins
JENKINS_HOME=/var/lib/jenkins
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
MAIL=/var/mail/jenkins
KEY_PAIR_NAME=jenkins_testing
PWD=/var/lib/jenkins/workspace/example_job
LANG=en_US.UTF-8
JOB_NAME=example_job
BUILD_DISPLAY_NAME=#1
BUILD_ID=2014-08-25_23-31-24
HOME=/var/lib/jenkins
SHLVL=2
EXECUTOR_NUMBER=0
JENKINS_SERVER_COOKIE=f8767e3d8fd2cc7b
NODE_LABELS=master
LOGNAME=jenkins
HUDSON_HOME=/var/lib/jenkins
NODE_NAME=master
BUILD_NUMBER=1
XDG_RUNTIME_DIR=/run/user/1000
HUDSON_COOKIE=d9c20b74-8945-4df7-a333-65b8a73535c5
INSTANCE_ID=i-7c97aa82
_=/usr/bin/env
+ echo ==================================
==================================
Finished: SUCCESS
```

While it may not seem miraculous, we have made INSTANCE_ID available to an independent task shell, which is normally impossible.

If I am misguided and there is a standard way to do this in Jenkins, please send me an email. I will update this document with your corrections.


References
----------

I have included references for Jenkins pipelining and launching standard parameterized builds via web POST. We used web calls to launch a job to purge cloud resources -- but the technique is not a replacement for build pipelines (which clearly track status for every related task).

* [How to use Jenkins for Job Chaining and Visualizations](http://zeroturnaround.com/rebellabs/how-to-use-jenkins-for-job-chaining-and-visualizations/)
* [Parameterized Build (Jenkins Wiki)](https://wiki.jenkins-ci.org/display/JENKINS/Parameterized+Build)
* [Jenkins: The Definitive Guide](http://shop.oreilly.com/product/0636920010326.do)


Acknowledgments
---------------

The basic project structure follows that devised by my teammate @elasticdog (author of transcrypt). I choose to keep the structure, as it emphasizes the technologies involved.
