#include "stdio.h"
#include "stdlib.c"

int main() {
	int result = minus(5, 4);
	if (result == 1) {
		printf("5 - 4 passed\n");
	}
	if (minus(1, 4) == -3) {
		printf("1 - 4 passed\n");
	}
	if (times(3,3) == 9) {
		printf("3 * 3 passed\n");
	}
		if (times(-3,3) == -9) {
		printf("-3 * 3 passed\n");
	}
		if (times(-3,-3) == 9) {
		printf("-3 * -3 passed\n");
	}
	return 0;
}