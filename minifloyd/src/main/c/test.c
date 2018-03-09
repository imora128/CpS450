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

void greaterThanTests() {
	if (greaterThan(5, 4) != 1) {
		printf("failed 5 > 4\n");
	}
	if (greaterThan(4, 5) != 0) {
		printf("failed 4 > 5\n");
	}
	if (greaterThan(-5, 4) != 0) {
		printf("failed -5 > 4\n");
	}
	if (greaterThan(-5, -4) != 0) {
		printf("failed -5 > -4\n");
	}
		if (greaterThan(5, -4) != 1) {
		printf("failed -5 > -4\n");
	}
	if (greaterThan(5, 5) != 0) {
		printf("failed -5 > 5\n");
	}
		if (greaterThan(12, 0) != 1) {
		printf("failed 12 > 0\n");
	}
}

void unaryMinusTest() {
	if (unaryMinus(1) != -1) {
		printf("failed 1\n");
	}
	if (unaryMinus(-1)  != 1) {
		printf("failed -1\n");
	}
	if (unaryMinus(5) != -5) {
		printf("failed 5\n");
	}
}
int main() {
	minusTests();
	timesTests();
	divisionTests();
	greaterThanTests();
	unaryMinusTest();
	printf("If there are no messages, the tests passed.\n");


	return 0;
}