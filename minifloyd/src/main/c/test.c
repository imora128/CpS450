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

void greaterEqualTests() {

	if (greaterEqual(5, 4) != 1) {
		printf("failed 5 >= 4\n");
	}
	if (greaterEqual(4, 5) != 0) {
		printf("failed 4 >= 5\n");
	}
	if (greaterEqual(-5, 4) != 0) {
		printf("failed -5 >= 4\n");
	}
	if (greaterEqual(-5, -4) != 0) {
		printf("failed -5 >= -4\n");
	}
		if (greaterEqual(5, -4) != 1) {
		printf("failed -5 >= -4\n");
	}
	if (greaterEqual(5, 5) != 1) {
		printf("failed -5 >= 5\n");
	}
		if (greaterEqual(12, 0) != 1) {
		printf("failed 12 > 0\n");
	}
}


void equalto() {
	if (eqTo(5, 4) != 0) {
		printf("failed 5 = 4\n");
	}
	if (eqTo(4, 5) != 0) {
		printf("failed 4 = 5\n");
	}
	if (eqTo(-5, 4) != 0) {
		printf("failed -5 = 4\n");
	}
	if (eqTo(-5, -4) != 0) {
		printf("failed -5 = -4\n");
	}
		if (eqTo(5, -4) != 0) {
		printf("failed -5 = -4\n");
	}
	if (eqTo(5, 5) != 1) {
		printf("failed -5 = 5\n");
	}
		if (eqTo(-5, 5) != 0) {
		printf("failed 5 = 5\n");
	}
		if (eqTo(-5, -5) != 1) {
		printf("failed -5 = -5\n");
	}
		if (eqTo(0, 0) != 1) {
		printf("failed 5 = 5\n");
	}
	if (eqTo(5, 0) != 0) {
		printf("failed 5 = 0\n");
	}
}


void andOpTest() {
	if (andOp(1, 1) != 1) {
		printf("failed 1 and 1\n");
	}
	if (andOp(1, 0) != 0) {
		printf("failed 1 and 0\n");
	}
	if (andOp(0, 0) != 0) {
		printf("failed 0 and 0\n");
	}
	if (andOp(0, 1) != 0) {
		printf("failed 0 and 1\n");
	}
	// if (andOp(-1, 1) != 0) {
	// 	printf("failed -1 and 1\n");
	// }
}

void orOpTest() {
	if (orOp(1, 1) != 1) {
		printf("failed 1 or 1\n");
	}
	if (orOp(1, 0) != 1) {
		printf("failed 1 or 0\n");
	}
	if (orOp(0, 0) != 0) {
		printf("failed 0 or 0\n");
	}
	if (orOp(0, 1) != 1) {
		printf("failed 0 or 1\n");
	}
	// if (andOp(-1, 1) != 0) {
	// 	printf("failed -1 and 1\n");
	// }
}

void notTest() {
	if (unaryNot(1) != 0) {
		printf("failed not 1\n");
	}
	if (unaryNot(0) != 1) {
		printf("failed not 0\n");
	}
}
//give it 5, -1, 1234567890. -5591
void readIntTest() {
	if (readint() != 5) {
		printf("failed not 5\n");
	}
	if (readint() != -1) {
		printf("failed not -1\n");
	}
	if (readint() != 1234567890) {
		printf("failed not 1234567890\n");
	}
		if (readint() != -5591) {
		printf("failed not -5591\n");
	}
}
int main() {
	minusTests();
	timesTests();
	divisionTests();
	greaterThanTests();
	unaryMinusTest();
	greaterEqualTests();
	equalto();
	andOpTest();
	orOpTest();
	notTest();
	readIntTest();
	printf("If there are no messages, the tests passed.\n");



	return 0;
}