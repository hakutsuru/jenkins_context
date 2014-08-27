# include function library
. $(dirname $0)/test_functions.sh


echo "========== before load ============"
env
echo "=================================="

load_job_env

echo "========== after load ============"
env
echo "=================================="

