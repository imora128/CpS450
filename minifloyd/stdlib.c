#include <syscall.h>
#include <stdlib.h>
#include "stdlib.h"


//writes <ch> to standard output (<out> is the predefined Floyd Writer object)
void Writer_io_write(void *out, int ch) {
  char c = ch;
  
  write(1, &c, 1);  
}

// // // reads a character from stdin and returns it (<in> is the predefined Floyd Reader object)
int Reader_io_read(void *in) {
  char c;

  read(0, &c, 1);

  return c;
}

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

// ----------------------------------------------------------------------
// String Management Functions
// ----------------------------------------------------------------------

//Constructs and returns an Floyd String using chars in <lit>, which must be null terminated
struct String *string_fromlit(char *lit)
{
  struct String *newstr = (struct String *)calloc(sizeof(struct String), 1);
  struct CharNode *cur = NULL;
  while (*lit) {
    struct CharNode *node = (struct CharNode *)calloc(sizeof(struct CharNode), 1);
    node->ch = *lit;
    if (cur == NULL) {
      newstr->list = node;
    } else {
      cur->next = node;
    }
    cur = node;
    lit++;
  }
  return newstr; 
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

void nullpointertest(int lineno, void* ptr) {
  const char msg[] = "Null pointer exception on line ";
  if (ptr == NULL ) {
    write(1, msg, sizeof(msg)-1);
    //Who am I to waste a perfectly good writeint function? jajaja
    writeint(lineno);
    exit(1);
  }
}

