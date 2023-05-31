source ${OET_PATH}/libs/locallibs/common_lib.sh
function pre_test() {
	LOG_INFO "Start to prepare the test environment."
	DNF_INSTALL gcc
	LOG_INFO "End to prepare the test environment."
}                        
function run_test() {
	LOG_INFO "Start to run test."
	gcc --version | head -n 1 | grep -E "gcc[[:space:]]*\(.*\)[[:space:]]*[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+" > /dev/null
	CHECK_RESULT $?
	LOG_INFO "End to run test."
}
function post_test() {
	LOG_INFO "Start to restore the test environment."
	DNF_REMOVE
	LOG_INFO "End to restore the test environment."
}                     
main "$@"                                  
