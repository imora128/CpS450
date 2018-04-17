/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: CodeGen.java
Description: Contains CodeGen class that generates all the code for the program
*/
package cps450;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;

import java.util.HashMap;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Stack;

import org.antlr.v4.runtime.ParserRuleContext;

import java.lang.ProcessBuilder;

import cps450.FloydParser.AddMinus_ExpContext;
import cps450.FloydParser.AddPlus_ExpContext;
import cps450.FloydParser.AndX_ExpContext;
import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.Call_stmtContext;
import cps450.FloydParser.Class_Context;
import cps450.FloydParser.ExprCont_FalseContext;
import cps450.FloydParser.ExprCont_IDContext;
import cps450.FloydParser.ExprCont_IDExprContext;
import cps450.FloydParser.ExprCont_IntlitContext;
import cps450.FloydParser.ExprCont_MEContext;
import cps450.FloydParser.ExprCont_NewContext;
import cps450.FloydParser.ExprCont_NullContext;
import cps450.FloydParser.ExprCont_StrlitContext;
import cps450.FloydParser.ExprCont_TrueContext;
import cps450.FloydParser.If_stmtContext;
import cps450.FloydParser.Loop_stmtContext;
import cps450.FloydParser.MethodDot_ExpContext;
import cps450.FloydParser.Method_declContext;
import cps450.FloydParser.MultiDIV_ExpContext;
import cps450.FloydParser.MultiTimes_ExpContext;
import cps450.FloydParser.OrX_ExpContext;
import cps450.FloydParser.RelationalEQ_ExpContext;
import cps450.FloydParser.RelationalGE_ExpContext;
import cps450.FloydParser.RelationalGT_ExpContext;
import cps450.FloydParser.StartContext;
import cps450.FloydParser.UnaryMinus_ExpContext;
import cps450.FloydParser.UnaryNot_ExpContext;
import cps450.FloydParser.UnaryPlus_ExpContext;
import cps450.FloydParser.Var_declContext;
/*FIXME(TO DO FOR SUNDAY)
 * NEXT:
 * Work on concat the library file and the given file. Make sure they do not lose their own line num.
 * (Note: Collisn said something about putting them together and returning a stream?)
 * Remove the writeint ducttape code for stuff like writeint that was used for testing
 * Test library stuff to make sure it works.
 * 
 * LAST:
 *
 * Do when library is being added:
 * null reference checks
 * Fix tree precedence issue between relational operators and or/and
 */
public class CodeGen extends FloydBaseVisitor<Void> {
	List<TargetInstruction> instructions = new ArrayList<TargetInstruction>();
	Stack<String> registers = new Stack<String>();
	Option opt;
	int labelCounter;
	static int LOCAL_SCOPE = 2;
	MyError PRINT = new MyError(true);
	SymbolTable symTable;
	
	CodeGen(Option opt, int labelCounterValue) {
		labelCounter = labelCounterValue;
		registers.push("%edx");
		registers.push("%ecx");
		registers.push("%ebx");
		registers.push("%eax");
		symTable = SymbolTable.getInstance();
		this.opt = opt;
	}

    /*
    Function Name: println
    Parameters: 
    Description: Prints a new line. (for comments)
    */
	void println() {
		emit(new TargetInstruction.Builder().directive("\n").build());
	}
	
    /*
    Function Name: emit
    Parameters: TargetInstruction t
    Description: Adds <t> to the list of instructions
    */
	void emit(TargetInstruction t) {
		instructions.add(t);
	}
	
    /*
    Function Name: emitExit
    Parameters:
    Description: Pushes 0 and calls exit to end the prog
    */
	void emitExit() {
		//emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s", startEndLine, "end start()")).build());
		emit(new TargetInstruction.Builder().comment("Calling exit because the program is finished").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("$0").build());
		emit(new TargetInstruction.Builder().instruction("call").operand1("exit").build());
	}
	
    /*
    Function Name: printInstructions
    Parameters:
    Description: For debugging purposes: prints out the instructions
    */
	void printInstructions() {
		for (TargetInstruction i: instructions) {
			System.out.println(i);
		}
	}
	
    /*
    Function Name: writeToFile
    Parameters: boolean s
    Description: Creates a file and writes all the instructions to it. If s is true,
    then it stops at creating the .s file. If s is false, it links it with stdlib and compiles.
    */
	void writeToFile(boolean s) {
		String fileName = opt.fileName.get(0);
		fileName = fileName.substring(0, fileName.lastIndexOf('.'));
		try {
		PrintWriter w = new PrintWriter(fileName + ".s");
		for (TargetInstruction i: instructions) {
			w.println(i);
		}
		w.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		compile(fileName, s);
	}
	
    /*
    Function Name: compile
    Parameters: String fileName, boolean s
    Description: Creates a processbuilder object and then calls invokeGCC
    */
	
	void compile(String fileName, boolean s) {
		//building the object file
		if (!s) {
		ProcessBuilder buildObject = new ProcessBuilder("gcc", "-c", fileName + ".s");
		invokeGCC(buildObject, fileName + " object file");
		ProcessBuilder buildExecutable = new ProcessBuilder("gcc", fileName + ".o", "stdlib.o", "-o", fileName);
		invokeGCC(buildExecutable, fileName + " executable");
		}
	}
	
    /*
    Function Name: invokeGCC
    Parameters: ProcessBuilder procBuilder, String jobname
    Description: Invokes GCC using procbuilder and prints out errors if it fails
    */
	void invokeGCC(ProcessBuilder procBuilder, String jobName) {
		int exitCode;
		try {
			Process proc = procBuilder.start();
			proc.waitFor();
			exitCode = proc.exitValue();
			if (exitCode == 0) {
			} else {
				 BufferedReader buf = new BufferedReader(new InputStreamReader(proc.getErrorStream()));
				 String out;
				 while ((out = buf.readLine()) != null) {
					 System.out.println(out);
				 }
			}
		} catch (Exception e) {
			System.out.println(String.format("Error while invoking process: %s", e));
		}
		
	}
    /*
    Function Name: emitComment
    Parameters: ParserRUleContext ctx
    Description: prints a conmment using the given context
    */
	void emitComment(ParserRuleContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		//===============DEBUGGING============================
		//.stabn 68,0,%s,.line%s-main
		//.line%s:
		if (opt.g) {
		emit(new TargetInstruction.Builder().directive(String.format(".stabn 68,0,%s,.line%s-main", 
				ctx.start.getLine(), ctx.start.getLine())).build());
		emit(new TargetInstruction.Builder().directive(String.format(".line%s:", 
				ctx.start.getLine())).build());
		}
		//===============DEBUGGING============================
	}
	
	@Override
	public Void visitExprCont_Intlit(ExprCont_IntlitContext ctx) {
		TargetInstruction foo = new TargetInstruction.Builder().instruction("pushl").operand1(String.format("$%s", ctx.INTEGER_LITERAL().getText())).build();		
		emit(foo);
		return null;
	}

	@Override
	public Void visitExprCont_ID(ExprCont_IDContext ctx) {
		String name = ctx.IDENTIFIER().getText();
		Symbol sym = ctx.sym;
		if (sym.getDecl() instanceof VarDeclaration) {
		if (sym.getScope() == LOCAL_SCOPE) {
			VarDeclaration variable = (VarDeclaration)sym.getDecl();
			int offset = variable.getOffset();
			//printing comment so i know which local is getting pushed
			emit(new TargetInstruction.Builder().comment(String.format("pushl %s", sym.getName())).build());
			emit(new TargetInstruction.Builder().instruction("pushl").operand1(String.format("%s(%%ebp)", offset)).build());
		} else {
//			VarDeclaration variable = (VarDeclaration)sym.getDecl();
//			int offset = variable.getOffset();
			VarDeclaration lhs = (VarDeclaration)sym.getDecl();
//			TargetInstruction foo = new TargetInstruction.Builder()
//			.instruction("pushl")
//			.operand1(String.format("%s", name)).build();		
//			emit(foo);
			emit(new TargetInstruction.Builder().comment("get reference to me").build());
			emit(new TargetInstruction.Builder().instruction("movl 8(%ebp), %ebx").build());
			emit(new TargetInstruction.Builder().comment("push value inside of the reference").build());
			emit(new TargetInstruction.Builder().instruction(String.format("pushl %s(%%ebx)", lhs.getOffset())).build());
			
		}
		} else {
			MethodDeclaration variable = (MethodDeclaration)sym.getDecl();
			int offset = variable.getOffset();
			emit(new TargetInstruction.Builder().comment(String.format("pushl %s", sym.getName())).build());
			emit(new TargetInstruction.Builder().instruction("pushl").operand1(String.format("%s(%%ebp)", offset)).build());
		}

		return null;
	}

	@Override
	public Void visitExprCont_True(ExprCont_TrueContext ctx) {
		
		TargetInstruction instruction = new TargetInstruction.Builder().instruction("pushl").operand1("$1").build();		
		emit(instruction);
		return null;
	}

	@Override
	public Void visitExprCont_False(ExprCont_FalseContext ctx) {
		TargetInstruction instruction = new TargetInstruction.Builder().instruction("pushl").operand1("$0").build();		
		emit(instruction);
		return null;
	}

	@Override
	public Void visitVar_decl(Var_declContext ctx) {
		
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		//checking if it's a class obj, if so, need to go ahead and make it null (which is 0)
		VarDeclaration newVar = (VarDeclaration)ctx.sym.getDecl();
		if (Type.getTypeForName(ctx.ty.getText()) != null) {
			//initializing variable to 0 (null) at declaration
			emit(new TargetInstruction.Builder().instruction(String.format("movl $0, %s(%%ebp)", newVar.getOffset())).build());
			
		}
		return null;
	}
	
	
	@Override
	public Void visitAssignment_stmt(Assignment_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		//===============DEBUGGING============================
		//.stabn 68,0,%s,.line%s-main
		//.line%s:
		if (opt.g) {
		emit(new TargetInstruction.Builder().directive(String.format(".stabn 68,0,%s,.line%s-main", 
				ctx.start.getLine(), ctx.start.getLine())).build());
		emit(new TargetInstruction.Builder().directive(String.format(".line%s:", 
				ctx.start.getLine())).build());
		}
		//===============DEBUGGING============================
		visit(ctx.e1);
		Symbol sym = ctx.sym;
		//check if its a variable
		if (sym.getDecl() instanceof VarDeclaration) {
			VarDeclaration lhs = (VarDeclaration)sym.getDecl();
			//local variable
			if (sym.getScope() == LOCAL_SCOPE) {
				emit(new TargetInstruction.Builder().comment(String.format("popl %s", sym.getName())).build());
				//emit(new TargetInstruction.Builder().instruction("popl %edx").build());
				//emit(new TargetInstruction.Builder().instruction(String.format("movl %%edx, %s(%%ebp)", lhs.getOffset())).build());
				emit(new TargetInstruction.Builder().instruction(String.format("popl %s(%%ebp)", lhs.getOffset())).build());
			} else {
				emit(new TargetInstruction.Builder().comment("put param value into eax").build());
				emit(new TargetInstruction.Builder().instruction("popl %eax").build());
				
				emit(new TargetInstruction.Builder().comment("get reference to me").build());
				emit(new TargetInstruction.Builder().instruction("movl 8(%ebp), %ebx").build());
				emit(new TargetInstruction.Builder().comment("store new value in offset inside of me").build());
				emit(new TargetInstruction.Builder().instruction(String.format("movl %%eax, %s(%%ebx)", lhs.getOffset())).build());
				
			}
			//check if its a function
		} else if (sym.getDecl() instanceof MethodDeclaration) {
			//i set the function offset at -4 when it is created, since that's where in the stack the ret value goes
			MethodDeclaration lhs = (MethodDeclaration) sym.getDecl();
			emit(new TargetInstruction.Builder().comment(String.format("popl %s", sym.getName())).build());
			emit(new TargetInstruction.Builder().instruction(String.format("popl %s(%%ebp)", lhs.getOffset())).build());
		}
		

		println();
		return null;
	}
	

	@Override
	public Void visitAddPlus_Exp(AddPlus_ExpContext ctx) {
		visit(ctx.e1);
		visit(ctx.e2);
		String sourceReg = registers.pop();
		String destReg = registers.pop();
		TargetInstruction pop1 = new TargetInstruction.Builder().
				instruction(String.format("popl %s", sourceReg)).build();		
		TargetInstruction pop2 = new TargetInstruction.Builder().
				instruction(String.format("popl %s", destReg)).build();	
		emit(pop1);
		emit(pop2);
		TargetInstruction add = new TargetInstruction.Builder().
				instruction("addl ").operand1(String.format("%s,", sourceReg)).operand2(destReg).build();
		emit(add);
		TargetInstruction pushResult = new TargetInstruction.Builder().
				instruction(String.format("pushl %s", destReg)).build();
		emit(pushResult);
		registers.push(destReg);
		registers.push(sourceReg);
		return null;
	}

	@Override
	public Void visitAddMinus_Exp(AddMinus_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("minus");
		return null;
	}
	
	

	@Override
	public Void visitMultiTimes_Exp(MultiTimes_ExpContext ctx) {
		visit(ctx.e1);
		visit(ctx.e2);
		callFunction("times");
		return null;
	}
	
	

	@Override
	public Void visitMultiDIV_Exp(MultiDIV_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("division");
		return null;
	}

	
	
	@Override
	public Void visitRelationalGT_Exp(RelationalGT_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("greaterThan");
		return null;
	}

	
	
	@Override
	public Void visitUnaryMinus_Exp(UnaryMinus_ExpContext ctx) {
		visit(ctx.e1);
		//needs only $4 because unary only uses 1 argument
		emit(new TargetInstruction.Builder().instruction("call").operand1("unaryMinus").build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1("$4,").operand2("%esp").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		return null;
	}
	

	@Override
	public Void visitRelationalGE_Exp(RelationalGE_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("greaterEqual");
		return null;
	}

	@Override
	public Void visitRelationalEQ_Exp(RelationalEQ_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("eqTo");
		return null;
	}
	
	

	@Override
	public Void visitAndX_Exp(AndX_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("andOp");
		return null;
	}
	
	
	

	@Override
	public Void visitOrX_Exp(OrX_ExpContext ctx) {
		visit(ctx.e2);
		visit(ctx.e1);
		callFunction("orOp");
		return null;
	}

	@Override
	public Void visitUnaryPlus_Exp(UnaryPlus_ExpContext ctx) {
		//needs only $4 because unary only uses 1 argument
		visit(ctx.e1);
		emit(new TargetInstruction.Builder().instruction("call").operand1("unaryPlus").build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1("$4,").operand2("%esp").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		return null;
	}

	@Override
	public Void visitUnaryNot_Exp(UnaryNot_ExpContext ctx) {
		visit(ctx.e1);
		//needs only $4 because unary only uses 1 argument
		emit(new TargetInstruction.Builder().instruction("call").operand1("unaryNot").build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1("$4,").operand2("%esp").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		return null;
	}

	void callFunction(String functionName) {
		emit(new TargetInstruction.Builder().instruction("call").operand1(functionName).build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1("$8,").operand2("%esp").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
	}
	
	@Override
	public Void visitStart(StartContext ctx) {
		//necessary for the program to run
		if (opt.fileName.get(0).equals("stdlib.floyd")) {
			for (int i = 0; i < ctx.class_().size(); i++) {
				visit(ctx.class_(i));
			}
			opt.labelCounter = labelCounter;
			return null;
		}
		emit(new TargetInstruction.Builder().label(String.format(".global %s", "main")).build());
		emit(new TargetInstruction.Builder().directive(String.format(".file \"%s\"", opt.fileName.get(0))).build());
		
		//going to use this to make sure the class defined class has defined a start method
		Class_Context lastClass = ctx.class_().get(ctx.class_().size()-1);
		boolean startDefined = false;
		//checking all the methods of the last defined class. If it has start, we're good
		for (int i = 0; i < lastClass.method_decl().size(); i++) {
			if (lastClass.method_decl().get(i).IDENTIFIER(0).getText().equals("start")) {
				startDefined = true;
			}
		}
		if (startDefined) {
			//Creating a main method to instantiate the main clas object and then call the start function
			int instanceVars = lastClass.var_decl().size();
			emit(new TargetInstruction.Builder().comment("Main method. Creates obj instance of the last class and calls its start method").build());
			emit(new TargetInstruction.Builder().label(String.format("main:")).build());
			//Number of instance vars * 4 (because each var is 4 bytes) + 8 (8 extra bytes for every object instanc)
			//calling calloc to make the object
			emit(new TargetInstruction.Builder().instruction(String.format("pushl $%s", (instanceVars * 4) + 8)).build());
			emit(new TargetInstruction.Builder().instruction("pushl $1").build());
			emit(new TargetInstruction.Builder().instruction("call").operand1("calloc").build());
			emit(new TargetInstruction.Builder().instruction("addl").operand1("$8,").operand2("%esp").build());
			//setting instance vars to 0
			if (instanceVars > 0) {
				emit(new TargetInstruction.Builder().comment(String.format("Initializing %s instance vars to 0", instanceVars)).build());
				//put 0 in each memory offset
				for (int i = 8; i < (instanceVars * 4) + 8; i += 4 ) {
					emit(new TargetInstruction.Builder().instruction(String.format("movl $0, %s(%%eax)", i)).build());	
				}
			}
			
			//pushing pointer to the class obj onto the stack
			emit(new TargetInstruction.Builder().instruction("pushl %eax").build());
			//calling the start method
			String startName = String.format("%s_%s", lastClass.IDENTIFIER(0).getText(), "start");
			//calling the start method
			emit(new TargetInstruction.Builder().instruction(String.format("call %s", startName)).build());
			//when we return from the start method, the program should exit, so that code goes here
			emit(new TargetInstruction.Builder().comment("Calling exit because the program is finished").build());
			emit(new TargetInstruction.Builder().instruction("pushl").operand1("$0").build());
			emit(new TargetInstruction.Builder().instruction("call").operand1("exit").build());
			//visiting all the classes
			for (int i = 0; i < ctx.class_().size(); i++) {
				visit(ctx.class_(i));
			}
			
		} else {
			String ansi_reset = "\u001B[0m";
			String ansi_red = "\u001B[31m";
			System.out.println(String.format("%sThe start method was not defined in the last class %s. Exiting.%s",ansi_red, lastClass.IDENTIFIER(0).getText(), ansi_reset));
			System.exit(1);
		}
				


		
		return null;
	}

	@Override
	public Void visitClass_(Class_Context ctx) {	
		//TargetInstruction fileName = new TargetInstruction.Builder().directive(String.format(".file \"%s\"", opt.fileName.get(0))).build();
		//===============DEBUGGING============================
		//.stabs  "demo.floyd",100,0,0,.Ltext0
		if (opt.g) {
		emit(new TargetInstruction.Builder().directive(String.format(".stabs \"%s\",100,0,0,.Ltext0", opt.fileName.get(0))).build());
		emit(new TargetInstruction.Builder().directive(".text").build());
		emit(new TargetInstruction.Builder().directive(".Ltext0:").build());
		emit(new TargetInstruction.Builder().directive(".stabs  \"int:t(0,1)=r(0,1);-2147483648;2147483647;\",128,0,0,0").build());
		}
		//===============DEBUGGING============================
		//emit(fileName);
		emit(new TargetInstruction.Builder().comment("CLASS BEGINNIGN HERE").build());
		for (int i = 0; i < ctx.var_decl().size(); i++) {
			visit(ctx.var_decl(i));
		}
		for(int i = 0; i < ctx.method_decl().size(); i++) {
			visit(ctx.method_decl(i));
		}
		
		
		
		return null;
	}

	@Override
	public Void visitMethod_decl(Method_declContext ctx) {
		//only allowed method is main in minifloyd
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s() %s", ctx.start.getLine(), 
				ctx.IDENTIFIER(0).getText(), ctx.IS().getText())).build());

		//===============DEBUGGING============================
		if (opt.g) {
		emit (new TargetInstruction.Builder().directive(String.format(".stabs  \"%s\",36,0,0,%s", ctx.IDENTIFIER(0).getText(),ctx.IDENTIFIER(0).getText())).build());
		}
		//===============DEBUGGING============================
		//printing out the function name
		//if it's start, print the main directive to know where to start prog
//		if (ctx.IDENTIFIER(0).getText().equals("start")) {
//		emit(new TargetInstruction.Builder().label(String.format(".global %s", "main")).build());
//		emit(new TargetInstruction.Builder().label(String.format("main:")).build());
//		} else {
		String funcName = String.format("%s_%s", ctx.className, ctx.IDENTIFIER(0).getText());
		emit(new TargetInstruction.Builder().label(String.format(("%s:"), funcName)).build());
		//}
		//FUNCTION PREAMBLE
		emit(new TargetInstruction.Builder().comment("Function preamble").build());
		emit(new TargetInstruction.Builder().instruction("pushl %ebp").build());
		emit(new TargetInstruction.Builder().instruction("movl %esp, %ebp").build());
		//return value
		emit(new TargetInstruction.Builder().comment("Making space for return value").build());
		emit(new TargetInstruction.Builder().instruction("pushl $0").build());
		//locals
		for (int i =  0; i < ctx.params; i++) {
			emit(new TargetInstruction.Builder().comment(String.format("making space for %s locals", ctx.params)).build());
			emit(new TargetInstruction.Builder().instruction("pushl $0").build());
		}
		//folowed by visiting the statement list to print the instructions for the content of the function
		visit(ctx.statement_list());
		
		//at the end of the function, put the value inside the return value area into eax
		if (ctx.typ != null) {
		emit(new TargetInstruction.Builder().comment("Moving the value inside the return value section of the stack into eax").build());
		emit(new TargetInstruction.Builder().instruction(("movl -4(%ebp), %eax")).build());
		}
		
		//cleaning up the stack
		emit(new TargetInstruction.Builder().comment("cleaning up the stack and returnig").build());
		emit(new TargetInstruction.Builder().instruction("leave").build());
		emit(new TargetInstruction.Builder().instruction(("ret")).build());
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s", ctx.stop.getLine(), "end " + ctx.IDENTIFIER(0).getText())).build());
		return null;
	}

	@Override
	public Void visitCall_stmt(Call_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		//===============DEBUGGING============================
		//.stabn 68,0,%s,.line%s-main
		//.line%s:
		if (opt.g) {
		emit(new TargetInstruction.Builder().directive(String.format(".stabn 68,0,%s,.line%s-main", 
				ctx.start.getLine(), ctx.start.getLine())).build());
		emit(new TargetInstruction.Builder().directive(String.format(".line%s:", 
				ctx.start.getLine())).build());
		}
		//===============DEBUGGING============================
//		if (ctx.t2 != null) {
//		visit(ctx.t2);
//		}
		//righ tto left para passing
		int paramNum = 0;
		if (ctx.t2 != null) {
			paramNum = ctx.expression_list().expression().size();
			for (int i = ctx.expression_list().expression().size() - 1; i > -1; i--) {
				visit(ctx.expression_list().expression().get(i));
			}
		}
		
		
		
		
		//offset for LHS to pass in "this"
		//only if sym is not null, meaning there's an object there
		if (ctx.t1 != null) {
		VarDeclaration test = (VarDeclaration)ctx.sym.getDecl();
		//pushing "this"
		emit(new TargetInstruction.Builder().comment("reference to the object").build());
		//FIX(MAKE SURE THIS OUT STUFF IS SORTED OUT)
//		if (!test.name.equals("out")) {
		emit(new TargetInstruction.Builder().comment(String.format("pushl %s", test.name)).build());
		emit(new TargetInstruction.Builder().instruction(String.format("pushl %s(%%ebp)", test.getOffset())).build());
//		}
		//derp, i also need to pass "this" even if it doesnt have
		} else {
			emit(new TargetInstruction.Builder().comment("reference to the object (this)").build());
			emit(new TargetInstruction.Builder().instruction("pushl 8(%ebp)").build());
		}
		
//		int paramNum = 0;
//		if (ctx.expression_list() != null) {
//		paramNum = ctx.expression_list().expression().size();
//		}
		String functionName = "FunctionNameFailed";
		if (ctx.t1 != null ) {
		//getting the right fnuctino name (with the class name prefix
			
			//FIXME(Temporary ducttape until I get the library functions in here)
//			if (ctx.t1.myType.name.equals("writer") || ctx.t1.myType.name.equals("reader")) {
//				functionName = ctx.IDENTIFIER().getText();
//			} else {
			functionName = String.format("%s_%s", ctx.t1.myType.name, ctx.IDENTIFIER().getText());
//			}
		} else {
			functionName = String.format("%s_%s", ctx.className, ctx.IDENTIFIER().getText());
			//print location
		}
		emit(new TargetInstruction.Builder().instruction("call").operand1(functionName).build());
		if (paramNum > 0) {
			emit(new TargetInstruction.Builder().comment(String.format("Clean up parameters: %s * 4", paramNum)).build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", paramNum * 4)).operand2("%esp").build());
		}
	
		//FIXME(another writer duct tape to test basic objs)
		//if func doesnt have t1, it has no obj that we need to pass "me" for
		if(ctx.t1 != null) {
		emit(new TargetInstruction.Builder().comment("Clean up this reference pushed on last: 4").build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,",4)).operand2("%esp").build());
		}
		println();
		
		return null;
	}
	
	

	@Override
	public Void visitExprCont_IDExpr(ExprCont_IDExprContext ctx) {
		int paramNum = 0;
		if (ctx.expression_list() != null) {
			paramNum = ctx.expression_list().expression().size();
			for (int i = ctx.expression_list().expression().size() - 1; i > -1; i--) {
				visit(ctx.expression_list().expression().get(i));
			}
		}
		String functionName = String.format("%s_%s", ctx.classType.name, ctx.IDENTIFIER().getText());
//		emit(new TargetInstruction.Builder().instruction("call").operand1(ctx.IDENTIFIER().getText()).build());
		//I PRAY, PLEASE WORK!
		emit(new TargetInstruction.Builder().instruction("pushl 8(%ebp)").build());
		emit(new TargetInstruction.Builder().instruction("call").operand1(functionName).build());
		if (paramNum > 0) {
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", paramNum * 4)).operand2("%esp").build());
		}
		emit(new TargetInstruction.Builder().comment("cleaning up the obj ref").build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", 4)).operand2("%esp").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		println();
		return null;
	}
	
	@Override
	public Void visitMethodDot_Exp(MethodDot_ExpContext ctx) {
		int paramNum = 0;
		ExprCont_IDExprContext foo = null;
		//it SHOULD be exprcont_IDExprcontext if it ever reaches here....
		if (ctx.expr_cont() instanceof ExprCont_IDExprContext) {
			foo = (ExprCont_IDExprContext) ctx.expr_cont();
			//parameter pushing right to left
			if (foo.expression_list() != null) {
				paramNum = foo.expression_list().expression().size();
				for (int i = foo.expression_list().expression().size() - 1; i > -1; i--) {
					visit(foo.expression_list().expression().get(i));
					
				}
			}
			
			//pushing reference to "this"
			//this should always run because this visit only ever happens when theres an object on the LHS
//			if (ctx.e1. instanceof ExprCont_NewContext) {
//				PRINT.DEBUG("JAJAJAJJAJAJA");
//			}
			visit(ctx.e1);
			//VarDeclaration lhsVar = (VarDeclaration)ctx.sym.getDecl();
//			emit(new TargetInstruction.Builder().comment(String.format("pushl %s", lhsVar.name)).build());
//			emit(new TargetInstruction.Builder().instruction(String.format("pushl %s(%%ebp)", lhsVar.getOffset())).build());
			String functionName = String.format("%s_%s", ctx.e1.myType, foo.IDENTIFIER().getText());
			emit(new TargetInstruction.Builder().instruction("call").operand1(functionName).build());
			if (paramNum > 0) {
				emit(new TargetInstruction.Builder().comment(String.format("Clean up parameters: (%s * 4) + 4 (this ptr)", paramNum)).build());
				emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", (paramNum * 4) + 4)).operand2("%esp").build());
			} else {
				emit(new TargetInstruction.Builder().comment("Clean up THIS obj reference param").build());
				emit(new TargetInstruction.Builder().instruction("addl $4, %esp").build());
			}
			
			emit(new TargetInstruction.Builder().comment("Pushing the result from the called function").build());
			emit(new TargetInstruction.Builder().instruction("pushl %eax").build());
		}
		//return super.visitMethodDot_Exp(ctx);
		return null;
	}

	@Override
	public Void visitIf_stmt(If_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s %s %s",ctx.start.getLine(), ctx.IF().get(0).getText(),ctx.cond_expr.getText(),
				ctx.THEN().getText())).build());
		//===============DEBUGGING============================
		//.stabn 68,0,%s,.line%s-main
		//.line%s:
		if (opt.g) {
		emit(new TargetInstruction.Builder().directive(String.format(".stabn 68,0,%s,.line%s-main", 
				ctx.start.getLine(), ctx.start.getLine())).build());
		emit(new TargetInstruction.Builder().directive(String.format(".line%s:", 
				ctx.start.getLine())).build());
		}
		//===============DEBUGGING============================
		visit(ctx.cond_expr);
		labelCounter = labelCounter + 2;
		int currentIf = labelCounter;
		//the result of the expression should be on top of the stack
		//popping it into eax
		emit(new TargetInstruction.Builder().instruction("popl").operand1("%eax").build());
		//pushing 1 to EDX so I can compare it to the result of the expression and do the logical jumps
		emit(new TargetInstruction.Builder().instruction("movl").operand1("$1,").operand2("%edx").build());
		//comparison
		emit(new TargetInstruction.Builder().instruction("cmpl").operand1("%eax,").operand2("%edx").build());
		//+1 is false, + 2 is true
		//-2 is false, -1 is true
		//jump to +1 if false
		emit(new TargetInstruction.Builder().instruction("jne").operand1(String.format(".L%s", (currentIf - 1))).build());
		//emit tru stmt list
		visit(ctx.truestm);
		//emit jmp to +2
		emit(new TargetInstruction.Builder().instruction("jmp").operand1(String.format(".L%s", currentIf)).build());
		//emit +1 label and then false stmtlist
		emit(new TargetInstruction.Builder().directive(String.format(".L%s:", (currentIf - 1))).build());
		if (ctx.falsestm != null) {
			emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s", (ctx.falsestm.start.getLine() - 1), "Else")).build());
			visit(ctx.falsestm);
		}
		//emit +2 label
		emit(new TargetInstruction.Builder().directive(String.format(".L%s:", currentIf)).build());
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s %s",ctx.stop.getLine(), ctx.END().getText(),
				ctx.IF(0).getText())).build());
	

		return null;
	}

	@Override
	public Void visitLoop_stmt(Loop_stmtContext ctx) {
		labelCounter = labelCounter + 2;
		int currentWhile = labelCounter;
//		emit(new TargetInstruction.Builder().instruction("jmp").operand1(".L" + (currentWhile - 1)).build());
		emit(new TargetInstruction.Builder().instruction("jmp").operand1(String.format(".L%s", (currentWhile - 1))).build());
		//emit(new TargetInstruction.Builder().directive(".L" + (currentWhile) + ":").build());
		emit(new TargetInstruction.Builder().directive(String.format(".L%s:", currentWhile)).build());
		visit(ctx.loop_body);
		//emit(new TargetInstruction.Builder().directive(".L" + (currentWhile - 1) + ":").build());
		emit(new TargetInstruction.Builder().directive(String.format(".L%s:", (currentWhile - 1))).build());
		emitComment(ctx.exp);
		visit(ctx.exp);
		emit(new TargetInstruction.Builder().instruction("pop").operand1("%eax").build());
		emit(new TargetInstruction.Builder().instruction("cmpl").operand1("$0,").operand2("%eax").build());
		//emit(new TargetInstruction.Builder().instruction("jne").operand1(".L" + (currentWhile)).build());
		emit(new TargetInstruction.Builder().instruction("jne").operand1(String.format(".L%s", (currentWhile))).build());
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s", ctx.stop.getLine(), "end loop")).build());
//		//===============DEBUGGING============================
//		//.stabn 68,0,%s,.line%s-main
//		//.line%s:
//		if (opt.g) {
//		emit(new TargetInstruction.Builder().directive(String.format(".stabn 68,0,%s,.line%s-main", 
//				ctx.stop.getLine(), ctx.stop.getLine())).build());
//		emit(new TargetInstruction.Builder().directive(String.format(".line%s:", 
//				ctx.stop.getLine())).build());
//		}
//		//===============DEBUGGING============================
		
		return null;
	}

	
	@Override
	public Void visitExprCont_New(ExprCont_NewContext ctx) {
		//Allocate memory from the heap to hold the instance variables for Point
		//NumberOfParameters*4 + 8 reserved bytes
		int reserveBytes = (ctx.paramNum * 4) + 8;
		emit(new TargetInstruction.Builder().instruction(String.format("pushl $%s", reserveBytes)).build());
		emit(new TargetInstruction.Builder().instruction("pushl $1").build());
		emit(new TargetInstruction.Builder().instruction("call").operand1("calloc").build());
		emit(new TargetInstruction.Builder().instruction("addl").operand1("$8,").operand2("%esp").build());
		
		
		//Initialize the values of the instance variables to 0
		if (ctx.paramNum > 0) {
			emit(new TargetInstruction.Builder().comment(String.format("Initializing %s instance vars to 0", ctx.paramNum)).build());
			//put 0 in each memory offset
			for (int i = 8; i < (ctx.paramNum * 4) + 8; i += 4 ) {
				emit(new TargetInstruction.Builder().instruction(String.format("movl $0, %s(%%eax)", i)).build());	
			}
		}

		
		//Leave a reference to the memory on the top of the stack
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		
		
	
	

		//return super.visitExprCont_New(ctx);
		return null;
	}

	@Override
	public Void visitExprCont_Null(ExprCont_NullContext ctx) {
		//null is 0
		emit(new TargetInstruction.Builder().instruction("pushl $0").build());
		//return super.visitExprCont_Null(ctx);
		return null;
	}

	@Override
	public Void visitExprCont_ME(ExprCont_MEContext ctx) {
		emit(new TargetInstruction.Builder().instruction("pushl 8(%ebp)").build());
		return null;
		//return super.visitExprCont_ME(ctx);
	}

	@Override
	public Void visitExprCont_Strlit(ExprCont_StrlitContext ctx) {
		String stringLitLabel = String.format("stringlit%s", symTable.stringLabelCounter); 
		emit(new TargetInstruction.Builder().label(".data").build());
		emit(new TargetInstruction.Builder().label(stringLitLabel + ":").build());
		emit(new TargetInstruction.Builder().directive(String.format(".string %s", ctx.getText())).build());
		println();
		emit(new TargetInstruction.Builder().label(".text").build());
		emit(new TargetInstruction.Builder().instruction(String.format("pushl $%s", stringLitLabel)).build());
		emit(new TargetInstruction.Builder().instruction("call string_fromlit").build());
		emit(new TargetInstruction.Builder().instruction("addl $4, %esp").build());
		emit(new TargetInstruction.Builder().instruction("pushl %eax").build());
		symTable.stringLabelCounter++;
		return null;
	}
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	

	
	
	
	
}
