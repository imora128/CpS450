# Report
**Hours spent:**  28 hours <br/>
**Known bugs:**  <br/>
**Academic Integrity Statement:** All code is my own. I used javarevisted.blogspot.com for information on a Builder design pattern for my targetinstruction class. 
Link: http://javarevisited.blogspot.com/2012/06/builder-design-pattern-in-java-example.html
I asked Sam Henry and Izaac Morales questions regarding the specifications and how certain things should work, but no code was shared or looked at.


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

