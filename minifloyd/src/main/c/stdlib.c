#include <syscall.h>
int andOp(int x, int y) {
  return x && y;
}



int orOp(int x, int y) {
  return x || y;
}

int eqTo(int x, int y) {
  return x == y;
}
int greaterEqual(int x, int y) {
  return x >= y;
}
int greaterThan(int x, int y) {
  return x > y;
}
int minus(int x, int y) {
  return x - y;
}

int times(int x, int y) {
  return x * y;
}

int division(int x, int y) {
  return x / y;
}
int unaryMinus(int x) {
  return -x;
}
int unaryPlus(int x) {
  return +x;
}
int unaryNot(int x) {
  return !x;
}

int readint() {
  char buffer[11];
  read(0, buffer, 11);
  int convertedNum = 0;
  int isNegative = 0;
  int i = 0;
  //if the number is negative, skip the first index and multiply the integer by -1 later
  if (buffer[0] == '-') {
    i = 1;
    isNegative = 1;
  }
  for (;i < 11; i++) {
    //if the ascii is not between 0 and 9 (inclusive) then stop
    if (buffer[i] >= '0' && buffer[i] <= '9') {
      //ascii of buffer[i] - ascii '0' should give the decimal form of the number
      convertedNum = convertedNum * 10 + buffer[i] - '0';
    } else {
      break;
    }
  }
  if (isNegative == 1) {
    convertedNum *= -1;
  }
  //printf("Converted num test: %i\n", convertedNum);

  return convertedNum;
}
void writeint(int num) {
  char buf[20];
  char result[20] = "0\n";
  char *pos = buf;
  char *writeptr = result;
  int numWritten;
 
  // Handle negative numbers
  if (num < 0) {
    *writeptr++ = '-';
    num = -num;
  }
  
  if (num > 0) {
      
    // Build the number in reverse order
    while (num > 0) {
      *pos++ = (num % 10) + '0';
      num /= 10;
    }
    pos--;
    
    // Now we need to copy the results into the output buffer, reversed
    while (pos > buf) {
      *writeptr++ = *pos--;
    }
    *writeptr++ = *pos;
    *writeptr++ = 10;
    *writeptr++ = 0;
  } else {
    // number is 0; use default result
    writeptr = result + 3;
  }
  
  write(1, result, (writeptr - result) - 1);
  
}
