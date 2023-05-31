source ${OET_PATH}/libs/locallibs/common_lib.sh
function pre_test() {
	LOG_INFO "Start to prepare the test environment."
	DNF_INSTALL gcc
	mkdir tmp
	cat << EOF > ./tmp/test.c
#include <stdio.h>
int main(){
	printf("Hello world!");
}
EOF
	cd ./tmp
	LOG_INFO "End to prepare the test environment."

}                        
function run_test() {
	LOG_INFO "Start to run test."
	gcc test.c -o test
	CHECK_RESULT $?
	./test | grep "Hello world!" > /dev/null
	CHECK_RESULT $?
	readelf -s ./test | grep "main" > /dev/null
	CHECK_RESULT $?
	LOG_INFO "End to run test."
}
function post_test() {
	LOG_INFO "Start to restore the test environment."
	cd ..
	rm -rf ./tmp
	DNF_REMOVE
	LOG_INFO "End to restore the test environment."
}                     
main "$@"                                  
