# include function library
. $(dirname $0)/test_functions.sh


INSTANCE_ID=i-7c97aa82
KEY_PAIR_NAME=jenkins_testing
SECURITY_GROUP_ID=sg-7ba8b919

(save_job_env $INSTANCE_ID $KEY_PAIR_NAME $SECURITY_GROUP_ID)
