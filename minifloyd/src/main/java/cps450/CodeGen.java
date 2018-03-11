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
import cps450.FloydParser.ExprCont_TrueContext;
import cps450.FloydParser.If_stmtContext;
import cps450.FloydParser.Loop_stmtContext;
import cps450.FloydParser.Method_declContext;
import cps450.FloydParser.MultiDIV_ExpContext;
import cps450.FloydParser.MultiTimes_ExpContext;
import cps450.FloydParser.OrX_ExpContext;
import cps450.FloydParser.RelationalEQ_ExpContext;
import cps450.FloydParser.RelationalGE_ExpContext;
import cps450.FloydParser.RelationalGT_ExpContext;
import cps450.FloydParser.UnaryMinus_ExpContext;
import cps450.FloydParser.UnaryNot_ExpContext;
import cps450.FloydParser.UnaryPlus_ExpContext;
import cps450.FloydParser.Var_declContext;

public class CodeGen extends FloydBaseVisitor<Void> {
	List<TargetInstruction> instructions = new ArrayList<TargetInstruction>();
	Stack<String> registers = new Stack<String>();
	Option opt;
	String startEndLine = "";
	int labelCounter;
	
	CodeGen(Option opt) {
		registers.push("%edx");
		registers.push("%ecx");
		registers.push("%ebx");
		registers.push("%eax");
		labelCounter = 0;
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
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s", startEndLine, "end start()")).build());
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
				//System.out.println(String.format("Successfully built %s", jobName));
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
		//temporary bandaid until invoking class methods is set in stone
		//otherwise the linker will say: "HEY, WHERE'S IN AND OUT DEFINED, BRO? I CANT PUSH THAT
		if(ctx.IDENTIFIER().getText().equals("out") || ctx.IDENTIFIER().getText().equals("in")) {
			return null;
		}
		TargetInstruction foo = new TargetInstruction.Builder()
				.instruction("pushl")
				.operand1(String.format("_%s", name)).build();		
		emit(foo);
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
		TargetInstruction instruction = new TargetInstruction.Builder().
				directive(String.format(".comm _%s,4,4", ctx.IDENTIFIER().getText())).build();
		emitComment(ctx);
		emit(instruction);
		return null;
	}
	
	

	@Override
	public Void visitAssignment_stmt(Assignment_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		visit(ctx.e1);
		TargetInstruction instruction = new TargetInstruction.Builder().
				instruction(String.format("popl _%s", ctx.IDENTIFIER().getText())).build();		
		emit(instruction);
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
	public Void visitClass_(Class_Context ctx) {
		//emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s %s %s",ctx.start.getLine(), 
				//ctx.CLASS().getText(), ctx.IDENTIFIER(0).getText(), ctx.IS().getText())).build());
		
		TargetInstruction fileName = new TargetInstruction.Builder().directive(String.format(".file \"%s\"", opt.fileName.get(0))).build();
		emit(fileName);
		return super.visitClass_(ctx);
	}

	@Override
	public Void visitMethod_decl(Method_declContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s() %s", ctx.start.getLine(), 
				ctx.IDENTIFIER(0).getText(), ctx.IS().getText())).build());
		emit(new TargetInstruction.Builder().directive(String.format(".global %s", "main")).build());
		emit(new TargetInstruction.Builder().directive("main:").build());
		startEndLine = Integer.toString(ctx.stop.getLine());
		return super.visitMethod_decl(ctx);
	}

	@Override
	public Void visitCall_stmt(Call_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		//only functions allowed are writeint and readint for this phase, so dont need to visit
		//visit(ctx.t1);
		visit(ctx.t2);
		int paramNum = 0;
		if (ctx.expression_list() != null) {
		paramNum = ctx.expression_list().expression().size();
		}
		
		emit(new TargetInstruction.Builder().instruction("call").operand1(ctx.IDENTIFIER().getText()).build());
		if (paramNum > 0) {
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", paramNum * 4)).operand2("%esp").build());
		}
		println();
		
		return null;
	}
	
	

	@Override
	public Void visitExprCont_IDExpr(ExprCont_IDExprContext ctx) {
		
		int paramNum = 0;
		if (ctx.expression_list() != null) {
			paramNum = ctx.expression_list().expression().size();
		}
		
		emit(new TargetInstruction.Builder().instruction("call").operand1(ctx.IDENTIFIER().getText()).build());
		if (paramNum > 0) {
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", paramNum * 4)).operand2("%esp").build());
		}
		//If I'm thinking about this correctly, then expr function calls should always return something..
		//you can't really have for example x := in.voidfunction, right?
			emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		println();
		return null;
	}

	@Override
	public Void visitIf_stmt(If_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s %s %s",ctx.start.getLine(), ctx.IF().get(0).getText(),ctx.cond_expr.getText(),
				ctx.THEN().getText())).build());
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
		//emit(new TargetInstruction.Builder().instruction("jne").operand1(".L" + (currentIf - 1)).build());
		emit(new TargetInstruction.Builder().instruction("jne").operand1(String.format(".L%s", (currentIf - 1))).build());
		//emit tru stmt list
		visit(ctx.truestm);
		//emit jmp to +2
		//emit(new TargetInstruction.Builder().instruction("jmp").operand1(".L" + (currentIf)).build());
		emit(new TargetInstruction.Builder().instruction("jmp").operand1(String.format(".L%s", currentIf)).build());
		//emit +1 label and then false stmtlist
		//emit(new TargetInstruction.Builder().directive(".L" + (currentIf - 1 + ":")).build());
		emit(new TargetInstruction.Builder().directive(String.format(".L%s:", (currentIf - 1))).build());
		if (ctx.falsestm != null) {
		visit(ctx.falsestm);
		}
		//emit +2 label
		//emit(new TargetInstruction.Builder().directive(".L" + (currentIf+ ":")).build());
		emit(new TargetInstruction.Builder().directive(String.format(".L%s:", currentIf)).build());
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s %s",ctx.stop.getLine(), ctx.END().getText(),
				ctx.IF(0).getText())).build());
	

		return null;
	}

	@Override
	public Void visitLoop_stmt(Loop_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), 
				"While loop: Jumping to conditional check")).build());
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
		
		return null;
	}
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	

	
	
	
	
}
