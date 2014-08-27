
function load_job_env()
{
    # assemble job environment file path
    my_directory=$(echo ${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/)
    env_file=$(echo ${BUILD_TAG}-env)
    env_path=${my_directory}${env_file}

    # load environment variables from file
    while read line; do export "$line";
    done < ${env_path}
}

function save_job_env()
{
    INSTANCE_ID=$1
    KEY_PAIR_NAME=$2
    SECURITY_GROUP_ID=$3

    # assemble job environment file path
    my_directory=$(echo ${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/)
    env_file=$(echo ${BUILD_TAG}-env)
    env_path=${my_directory}${env_file}

    # store job environments to file path
    echo "INSTANCE_ID=${INSTANCE_ID}" >> ${env_path}
    echo "KEY_PAIR_NAME=${KEY_PAIR_NAME}" >> ${env_path}
    echo "SECURITY_GROUP_ID=${SECURITY_GROUP_ID}" >> ${env_path}
}
