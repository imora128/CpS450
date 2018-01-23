# Report
**Hours spent:** 10 hours <br/>
**Known bugs:** None known. <br/>
**Academic Integrity Statement:** All code is my own. I visited websites to brush up on regular expression rules, ANTLR rules, and Java library methods.



# Readme

This project contains a demonstration scanner for a small ANTLR grammar.

## Install and Run

To build this project, execute:

```
gradlew install
```

To run this project, execute:

```
build/install/lexer/bin/lexer demo.floyd
```

## Project Structure

* **/src/main/antlr/cps450/Arithmetic.g4** contains an ANTLR grammar
* **/src/main/java/cps450/Main.java** contains the main Java entry point
* **/src/test/java/cps450/LexerTest.java** contains a unit test
* **/src/test/resources/cps450/lexertest.txt** contains a data file read by the unit test
* **/src/main/java/cps450/Option.java** contains the Option class that parses and stores cmdline arguments into its instance variables.

