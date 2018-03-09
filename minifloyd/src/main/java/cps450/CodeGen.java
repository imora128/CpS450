package cps450;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Stack;
import java.lang.ProcessBuilder;

import cps450.FloydParser.AddMinus_ExpContext;
import cps450.FloydParser.AddPlus_ExpContext;
import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.Call_stmtContext;
import cps450.FloydParser.Class_Context;
import cps450.FloydParser.ExprCont_FalseContext;
import cps450.FloydParser.ExprCont_IDContext;
import cps450.FloydParser.ExprCont_IDExprContext;
import cps450.FloydParser.ExprCont_IntlitContext;
import cps450.FloydParser.ExprCont_TrueContext;
import cps450.FloydParser.Method_declContext;
import cps450.FloydParser.Var_declContext;

public class CodeGen extends FloydBaseVisitor<Void> {
	List<TargetInstruction> instructions = new ArrayList<TargetInstruction>();
	Stack<String> registers = new Stack<String>();
	Option opt;
	
	CodeGen(Option opt) {
		registers.push("%edx");
		registers.push("%ecx");
		registers.push("%ebx");
		registers.push("%eax");
		this.opt = opt;
	}
	
	void println() {
		emit(new TargetInstruction.Builder().directive("\n").build());
	}
	void emit(TargetInstruction t) {
		instructions.add(t);
	}
	
	void emitExit() {
		emit(new TargetInstruction.Builder().comment("Calling exit because the program is finished").build());
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("$0").build());
		emit(new TargetInstruction.Builder().instruction("call").operand1("exit").build());
	}
	
	void printInstructions() {
		for (TargetInstruction i: instructions) {
			System.out.println(i);
		}
	}
	
	void writeToFile(boolean s) {
		//FIXME(Make suere to do error handling)
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
		//PrintWriter writer = new PrintWriter(opt.fileName.get(0), )
	}
	
	void compile(String fileName, boolean s) {
		//building the object file
		ProcessBuilder buildObject = new ProcessBuilder("gcc", "-c", fileName + ".s");
		invokeGCC(buildObject, fileName + " object file");
		if (!s) {
		ProcessBuilder buildExecutable = new ProcessBuilder("gcc", fileName + ".o", "stdlib.o", "-o", fileName);
		invokeGCC(buildExecutable, fileName + " executable");
		}
	}
	
	void invokeGCC(ProcessBuilder procBuilder, String jobName) {
		int exitCode;
		try {
			//System.out.println("Inside of invokeGCC. Filename: " + fileName);
			Process proc = procBuilder.start();
			proc.waitFor();
			exitCode = proc.exitValue();
			if (exitCode == 0) {
				System.out.println(String.format("Sucessful compilation of %s", jobName));
			} else {
				 BufferedReader buf = new BufferedReader(new InputStreamReader(proc.getErrorStream()));
				 String out;
				 while ((out = buf.readLine()) != null) {
					 System.out.println(out);
				 }
			}
		} catch (Exception e) {
			//TODO("exception hadnelr body")
			System.out.println(String.format("Error while invoking process: %s", e));
		}
		
	}
	@Override
	public Void visitExprCont_Intlit(ExprCont_IntlitContext ctx) {
		TargetInstruction foo = new TargetInstruction.Builder().instruction("pushl").operand1(String.format("$%s", ctx.INTEGER_LITERAL().getText())).build();		
		emit(foo);
		//System.out.println("visitExprCont_Intlit: " + foo);
		return null;
	}

	@Override
	public Void visitExprCont_ID(ExprCont_IDContext ctx) {
		String name = ctx.IDENTIFIER().getText();
		TargetInstruction foo = new TargetInstruction.Builder()
				.instruction("pushl")
				.operand1(String.format("_%s", name)).build();		
		emit(foo);
		return null;
	}

	@Override
	public Void visitExprCont_True(ExprCont_TrueContext ctx) {
		
		TargetInstruction instruction = new TargetInstruction.Builder().instruction("pushl").operand1("1").build();		
		emit(instruction);
		//System.out.println("visitExprCont_True: " + foo);
		return null;
	}

	@Override
	public Void visitExprCont_False(ExprCont_FalseContext ctx) {
		TargetInstruction instruction = new TargetInstruction.Builder().instruction("pushl").operand1("0").build();		
		emit(instruction);
		//System.out.println("visitExprCont_False: " + foo);
		return null;
	}

	@Override
	public Void visitVar_decl(Var_declContext ctx) {
		TargetInstruction instruction = new TargetInstruction.Builder().
				directive(String.format(".comm _%s,4,4", ctx.IDENTIFIER().getText())).build();
		emit(instruction);
		//System.out.println("visitVar_decl: " + foo);
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
		System.out.println("here: " + sourceReg + destReg);
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
		TargetInstruction callMinus = new TargetInstruction.Builder().
				instruction(String.format("call %s", "minus")).build();
		emit(callMinus);
		TargetInstruction cleanUp = new TargetInstruction.Builder().
				instruction("addl").operand1("$8,").operand2("%esp").build();
		emit(cleanUp);
		emit(new TargetInstruction.Builder().instruction("pushl").operand1("%eax").build());
		return null;
	}

	@Override
	public Void visitClass_(Class_Context ctx) {
		TargetInstruction fileName = new TargetInstruction.Builder().directive(String.format(".file \"%s\"", opt.fileName.get(0))).build();
		emit(fileName);
		return super.visitClass_(ctx);
	}

	@Override
	public Void visitMethod_decl(Method_declContext ctx) {
		emit(new TargetInstruction.Builder().directive(String.format(".global %s", "main")).build());
		emit(new TargetInstruction.Builder().directive("main:").build());
		return super.visitMethod_decl(ctx);
	}

	@Override
	public Void visitCall_stmt(Call_stmtContext ctx) {
		emit(new TargetInstruction.Builder().comment(String.format("Line %s: %s",ctx.start.getLine(), ctx.getText())).build());
		//only functions allowed are writeint and readint for this phase, so dont need to visit
		//visit(ctx.t1);
		visit(ctx.t2);
		//FIXME(How do i figure out exactly how many arguments are pushed? For this phase, it'll be 1 or 0.)
		int paramNum = ctx.expression_list().expression().size();
		emit(new TargetInstruction.Builder().instruction("call").operand1(ctx.IDENTIFIER().getText()).build());
		if (paramNum > 0) {
		emit(new TargetInstruction.Builder().instruction("addl").operand1(String.format("$%s,", paramNum * 4)).operand2("%esp").build());
		}
		println();
		
		return null;
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
	

	
	
	
	
}
