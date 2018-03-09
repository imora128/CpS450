#include "stdio.h"
#include "stdlib.c"

void minusTests() {
	if (minus(5, 4) != 1) {
		printf("5 - 4 failed\n");
	}
	if (minus(1, 4) != -3) {
		printf("1 - 4 failed\n");
	}
}

void timesTests() {
	if (times(3,3) != 9) {
		printf("3 * 3 failed\n");
	}
	if (times(-3,3) != -9) {
		printf("-3 * 3 failed\n");
	}
	if (times(-3,-3) != 9) {
		printf("-3 * -3 failed\n");
	}
}

void divisionTests() {
		if (division(10, 5) != 2) {
		printf("10/5 failed\n");
	}
	if (division(-5, 5) != -1) {
		printf("-5/5 failed");
	}
	if (division(-20, -2) != 10) {
		printf("-20/-2 failed");
	}
	// if (division(-5, 0) != -1) {
	// 	printf("-5/0 failed");
	// }
}
int main() {
	minusTests();
	timesTests();
	divisionTests();
	printf("If there are no messages, the tests passed.\n");


	return 0;
}