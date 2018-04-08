/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: SemanticChecker.java
Description: Contains the class that checks for and prints semantic checks.
*/
package cps450;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

import javax.lang.model.element.TypeElement;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import cps450.FloydParser.AddMinus_ExpContext;
import cps450.FloydParser.AddMulti_ExpContext;
import cps450.FloydParser.AddPlus_ExpContext;
import cps450.FloydParser.Add_expContext;
import cps450.FloydParser.AndConcat_ExpContext;
import cps450.FloydParser.AndX_ExpContext;
import cps450.FloydParser.And_expContext;
import cps450.FloydParser.Argument_declContext;
import cps450.FloydParser.Argument_decl_listContext;
import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.Call_stmtContext;
import cps450.FloydParser.Class_Context;
import cps450.FloydParser.ConcatAdd_ExpContext;
import cps450.FloydParser.ConcatX_ExpContext;
import cps450.FloydParser.Concat_expContext;
import cps450.FloydParser.ExprCont_ArrayContext;
import cps450.FloydParser.ExprCont_FalseContext;
import cps450.FloydParser.ExprCont_IDContext;
import cps450.FloydParser.ExprCont_IDExprContext;
import cps450.FloydParser.Method_expContext;
import cps450.FloydParser.MultiDIV_ExpContext;
import cps450.FloydParser.MultiTimes_ExpContext;
import cps450.FloydParser.MultiUnary_ExpContext;
import cps450.FloydParser.OrAnd_ExpContext;
import cps450.FloydParser.OrX_ExpContext;
import cps450.FloydParser.Or_expContext;
import cps450.FloydParser.RelationalEQ_ExpContext;
import cps450.FloydParser.RelationalGE_ExpContext;
import cps450.FloydParser.RelationalGT_ExpContext;
import cps450.FloydParser.RelationalOr_ExpContext;
import cps450.FloydParser.Relational_expContext;
import cps450.FloydParser.TypeBoolContext;
import cps450.FloydParser.TypeContext;
import cps450.FloydParser.TypeIDContext;
import cps450.FloydParser.Var_declContext;
import cps450.FloydParser.TypeIntContext;
import cps450.FloydParser.TypeStringContext;
import cps450.FloydParser.UnaryMethod_ExpContext;
import cps450.FloydParser.UnaryMinus_ExpContext;
import cps450.FloydParser.Unary_expContext;
import cps450.FloydParser.ExprCont_StrlitContext;
import cps450.FloydParser.ExprCont_TrueContext;
import cps450.FloydParser.ExprOr_ExprContext;
import cps450.FloydParser.ExprRelational_ExprContext;
import cps450.FloydParser.If_stmtContext;
import cps450.FloydParser.Loop_stmtContext;
import cps450.FloydParser.MethodDot_ExpContext;
//import cps450.FloydParser.MethodDot_ExpContext;
import cps450.FloydParser.ExprCont_IntlitContext;
import cps450.FloydParser.ExprCont_MEContext;
import cps450.FloydParser.ExprCont_NewContext;
import cps450.FloydParser.ExprCont_NullContext;
import cps450.FloydParser.ExprCont_ParExpContext;
import cps450.FloydParser.UnaryNot_ExpContext;
import cps450.FloydParser.UnaryPlus_ExpContext;
import cps450.FloydParser.MethodExpr_ContContext;
import cps450.FloydParser.Method_declContext;
//FIXME(FIGURE OUT WHY CALLING A FUNCTION MESSES UP MY STACK)
//FIXME(Passing in a declared func as a parameter passes semantic checks. IE:out.writeint(meth1)
public class SemanticChecker extends FloydBaseListener {
	SymbolTable symTable;
	MyError print = new MyError(false);
	Option opt;
	ClassDeclaration mainClass = null;
	ClassDeclaration reader;
	ClassDeclaration writer;
	SemanticChecker(Option opt) {
		this.opt = opt;
		print.opt = opt;
		symTable = SymbolTable.getInstance();
		symTable.populatePredefinedTypes();
		
		//creating writer class
		writer = new ClassDeclaration(Type.WRITER);
		//writeint function
		MethodDeclaration writeint = new MethodDeclaration(Type.VOID);
		writeint.appendParameter(Type.INT, "num");
		writer.appendMethod("writeint", writeint);
		
		//creating reader class
		reader = new ClassDeclaration(Type.READER);
		//readint function
		MethodDeclaration readint = new MethodDeclaration(Type.INT);
		reader.appendMethod("readint", readint);
		symTable.types.get("reader").decl = reader;
		symTable.types.get("writer").decl = writer;
		
	}
	
	boolean doesTypeExist(Type t) {
		if (t == Type.INT || t == Type.BOOLEAN || t == Type.STRING || t ==Type.READER || t == Type.WRITER) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@Override
	public void exitVar_decl(Var_declContext ctx) {
			if (ctx.children.contains(ctx.ASSIGNMENT_OPERATOR())) {
				print.err(String.format(print.errMsgs.get("Unsupported"), 
						"Attempting to initialize a variable in the declaration section."),ctx);
				return;
			}
			
		
		if (ctx.ty != null && doesTypeExist(ctx.type().myType)) {
			Symbol sym = symTable.lookup(ctx.IDENTIFIER().toString());
			if (sym != null && sym.getScope() == symTable.getScope()) {
				print.err(String.format(print.errMsgs.get("RedefineVar"), 
						ctx.IDENTIFIER().toString()),ctx);
				return;
			}
			//FIXME(need to add offset to variable. question is, how in the world do i know how to calculate the right offset?)
			VarDeclaration variable = new VarDeclaration(ctx.type().myType, ctx.IDENTIFIER().toString());
			variable.setOffset(symTable.getLocalOffset());
			//System.out.println(String.format("%s: %s",variable.name, variable.getOffset()));
			symTable.setLocalOffset(symTable.getLocalOffset() - 4);
			
			symTable.push(ctx.IDENTIFIER().toString(), variable);
			
		}
		else {
			print.err(print.errMsgs.get("BadVarType"),ctx);
		}
		
		

		
		super.exitVar_decl(ctx);
	}
	
	
	@Override
	public void exitAssignment_stmt(Assignment_stmtContext ctx) {
		
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			for (int i = 0; i < ctx.expression().size(); i++) {
				if (ctx.expression(i).myType != Type.ERROR && sym.getDecl().type != ctx.expression(i).myType) {
					print.err(String.format(print.errMsgs.get("AssMismatch"), 
							sym.getDecl().type, ctx.expression(i).myType),ctx);
				}
			}
//			if (sym.getDecl() instanceof VarDeclaration) {
//			VarDeclaration foo = (VarDeclaration)sym.getDecl();
//			ctx.sym = foo;
//			System.out.println(String.format("Offset for %s is %s)", foo.name, foo.getOffset()));
//			} else if (sym.getDecl() instanceof MethodDeclaration) {
//				MethodDeclaration foo = (MethodDeclaration)sym.getDecl();
//				ctx.sym = foo;
//				System.out.println(String.format("Method %s has been decorated", sym.getName()));
//			}
			ctx.sym = sym;
		}
		else {

			print.err(String.format(print.errMsgs.get("UndefinedVar"), 
					ctx.IDENTIFIER().getText()),ctx);
		}
		super.exitAssignment_stmt(ctx);
	}
	
	
	

	@Override
	public void exitExprCont_ParExp(ExprCont_ParExpContext ctx) {
		ctx.myType = ctx.expression().myType;
		super.exitExprCont_ParExp(ctx);
	}
		

	@Override
	public void exitExprCont_Array(ExprCont_ArrayContext ctx) {
		ctx.myType = Type.ERROR;
		print.DEBUG("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
		super.exitExprCont_Array(ctx);
	}

	@Override
	public void exitIf_stmt(If_stmtContext ctx) {
		if (ctx.expression().myType == Type.BOOLEAN) {
		}
		else {
			print.err(String.format(print.errMsgs.get("TypeMismatch"), 
					ctx.IF(0).toString(), "boolean", ctx.expression().myType),ctx);
		}
		
		super.exitIf_stmt(ctx);
	}
	
	

	@Override
	public void exitLoop_stmt(Loop_stmtContext ctx) {
		if (ctx.expression().myType == Type.BOOLEAN) {
		}
		else {
			print.err(String.format(print.errMsgs.get("TypeMismatch"), 
					ctx.WHILE().toString(), "boolean", ctx.expression().myType),ctx);
		}
		
		super.exitLoop_stmt(ctx);
	}

	@Override
	public void exitExprRelational_Expr(ExprRelational_ExprContext ctx) {
		if (ctx.relational_exp().myType != null) {
			ctx.myType = ctx.relational_exp().myType;
		}
		else {
		}
		super.exitExprRelational_Expr(ctx);
	}

	@Override
	public void exitExprOr_Expr(ExprOr_ExprContext ctx) {
		if (ctx.or_exp().myType != null) {
			ctx.myType = ctx.or_exp().myType;
		}
		else {
			print.DEBUG("exitExprOr_Exprr: Got null");
		}
		super.exitExprOr_Expr(ctx);
	}

	@Override
	public void exitRelationalGE_Exp(RelationalGE_ExpContext ctx) {
		if (ctx.e1.myType == Type.STRING) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.GE().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.STRING, ctx.e1.myType, ctx.e2.myType, ctx, foo);
			if (ctx.myType == Type.STRING) {ctx.myType = Type.BOOLEAN;}
		}
		else if (ctx.e1.myType == Type.INT) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.GE().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
			if (ctx.myType == Type.INT) {ctx.myType = Type.BOOLEAN;}
		}
		else {
			print.err(String.format(print.errMsgs.get("TypeMismatch"), 
			ctx.GE().toString(), "int or string ", ctx.e1.myType),ctx);
			ctx.myType = Type.ERROR;
		}
		super.exitRelationalGE_Exp(ctx);
	}


	@Override
	public void exitRelationalGT_Exp(RelationalGT_ExpContext ctx) {
		if (ctx.e1.myType == Type.STRING) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.GT().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.STRING, ctx.e1.myType, ctx.e2.myType, ctx, foo);
			if (ctx.myType == Type.STRING) {ctx.myType = Type.BOOLEAN;}
		}
		else if (ctx.e1.myType == Type.INT) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.GT().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
			if (ctx.myType == Type.INT) {ctx.myType = Type.BOOLEAN;}
		}
		else {
			print.err(String.format(print.errMsgs.get("TypeMismatch"), 
			ctx.GT().toString(), "int or string ", ctx.e1.myType),ctx);
			ctx.myType = Type.ERROR;
		}
		
		super.exitRelationalGT_Exp(ctx);
	}

	@Override
	public void exitRelationalEQ_Exp(RelationalEQ_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.EQ().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
			if (ctx.myType == Type.INT) {ctx.myType = Type.BOOLEAN;}
		}
		else if (ctx.e1.myType == Type.STRING) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.EQ().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.STRING, ctx.e1.myType, ctx.e2.myType, ctx, foo);
			if (ctx.myType == Type.STRING) {ctx.myType = Type.BOOLEAN;}
		}
		else if (ctx.e1.myType == Type.BOOLEAN) {
			List<String> foo = Arrays.asList("TypeMismatch", ctx.EQ().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
			ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		} else {
			print.err(String.format(print.errMsgs.get("TypeMismatch"), 
			ctx.EQ().toString(), "int, string, or bool ", ctx.e1.myType),ctx);
			ctx.myType = Type.ERROR;
		}
		super.exitRelationalEQ_Exp(ctx);
	}
	
	@Override
	public void exitRelationalOr_Exp(RelationalOr_ExpContext ctx) {
		if (ctx.or_exp().myType != null) {
			ctx.myType = ctx.or_exp().myType;
		}
		else
		{
			//print.DEBUG("exitRelationalOr_Exp: shows previous func is null");
		}
		super.exitRelationalOr_Exp(ctx);
	}



	@Override
	public void exitOrX_Exp(OrX_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.OR().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.e1.myType, ctx.e2.myType, ctx, foo);
	}
	
	@Override
	public void exitOrAnd_Exp(OrAnd_ExpContext ctx) {
		if (ctx.and_exp().myType != null) {
			ctx.myType = ctx.and_exp().myType;
		}
		else{
			print.DEBUG("exitOrAnd_Exp: shows previous func is null");
		}
		super.exitOrAnd_Exp(ctx);
	}


	@Override
	public void exitAndX_Exp(AndX_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.AND().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitAndX_Exp(ctx);
	}
	
	@Override
	public void exitAndConcat_Exp(AndConcat_ExpContext ctx) {
		if (ctx.concat_exp().myType != null) {
			ctx.myType = ctx.concat_exp().myType;
		}
		else
		{
			print.DEBUG("exitAndConcat_Exp: shows previous func is null");
		}
		super.exitAndConcat_Exp(ctx);
	}


	@Override
	public void exitConcatX_Exp(ConcatX_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.AMPERSAND().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.STRING, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitConcatX_Exp(ctx);
	}
	
	@Override
	public void exitConcatAdd_Exp(ConcatAdd_ExpContext ctx) {
		if (ctx.add_exp().myType != null) {
			ctx.myType = ctx.add_exp().myType;
		}
		else
		{
			print.DEBUG("exitConcatAdd_Exp: shows previous func is: " + ctx.add_exp().myType);
		}
		super.exitConcatAdd_Exp(ctx);
	}


	@Override
	public void exitAddPlus_Exp(AddPlus_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.PLUS().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitAddPlus_Exp(ctx);
	}
	
	@Override
	public void exitAddMinus_Exp(AddMinus_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.MINUS().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitAddMinus_Exp(ctx);
	}

	@Override
	public void exitAddMulti_Exp(AddMulti_ExpContext ctx) {
		if (ctx.multi_exp().myType != null) {
			ctx.myType = ctx.multi_exp().myType;
		}
		else
		{
			print.DEBUG("exitAddMulti_Exp: shows previous func is null");
		}
		super.exitAddMulti_Exp(ctx);
	}
	
	@Override
	public void exitMultiTimes_Exp(MultiTimes_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.TIMES().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitMultiTimes_Exp(ctx);
	}

	@Override
	public void exitMultiDIV_Exp(MultiDIV_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.DIV().toString(),ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitMultiDIV_Exp(ctx);
	}


	@Override
	public void exitMultiUnary_Exp(MultiUnary_ExpContext ctx) {
		if (ctx.unary_exp().myType != null) {
			ctx.myType = ctx.unary_exp().myType;
		}
		else
		{
			print.DEBUG("exitMultiUnary_Exp shows previous func is null");
		}
		super.exitMultiUnary_Exp(ctx);
	}


	@Override
	public void exitUnaryPlus_Exp(UnaryPlus_ExpContext ctx) {
		String errorMsg = String.format(print.errMsgs.get("TypeMismatch"), 
				ctx.PLUS().toString(),"int", ctx.unary_exp().myType);
		ctx.myType = exprCompareTypes(Type.INT, ctx.unary_exp().myType, errorMsg, ctx);
		super.exitUnaryPlus_Exp(ctx);
	}


	@Override
	public void exitUnaryMinus_Exp(UnaryMinus_ExpContext ctx) {
		String errorMsg = String.format(print.errMsgs.get("TypeMismatch"), 
				ctx.MINUS().toString(), "int", ctx.unary_exp().myType);
		ctx.myType = exprCompareTypes(Type.INT, ctx.unary_exp().myType, errorMsg, ctx);
	}


	@Override
	public void exitUnaryNot_Exp(UnaryNot_ExpContext ctx) {
		String errorMsg = String.format(print.errMsgs.get("TypeMismatch"), 
				ctx.NOT().toString(), "boolean", ctx.unary_exp().myType);
		ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.unary_exp().myType,errorMsg, ctx);
		super.enterUnaryNot_Exp(ctx);
	}

	Type exprCompareTypes(Type expectedType, Type givenType1, Type givenType2,ParserRuleContext ctx, List<String> fields) {
		if (givenType1 == Type.ERROR || givenType2 == Type.ERROR) {
			return Type.ERROR;
		}
		if (expectedType == givenType1) {
			if (expectedType == givenType2) {
				return expectedType;
			} else {
				print.err(String.format(print.errMsgs.get(fields.get(0)), fields.get(1), expectedType, givenType2),ctx);
				return Type.ERROR;
			}
		} else {
			print.err(String.format(print.errMsgs.get(fields.get(0)), fields.get(1), expectedType, givenType1),ctx);
			return Type.ERROR;
		}
	}
	Type exprCompareTypes(Type expectedType, Type givenType, String errMsg, ParserRuleContext ctx) {
		if (expectedType == givenType && givenType != Type.ERROR) {
			return expectedType;
		} else {
			print.err(errMsg, ctx);
			return Type.ERROR;
		}
	}
	
	
	@Override
	public void exitUnaryMethod_Exp(UnaryMethod_ExpContext ctx) {
		if (ctx.method_exp().myType != null) {
			ctx.myType = ctx.method_exp().myType;
		}
		else
		{
			print.DEBUG("exitUnaryMethod_Exp: Type is null");
		}
		super.exitUnaryMethod_Exp(ctx);
	}

	@Override
	public void exitMethodExpr_Cont(MethodExpr_ContContext ctx) {
		ctx.myType = ctx.expr_cont().myType;
		if (ctx.expr_cont().myType != null) {
			ctx.myType = ctx.expr_cont().myType;
		}
		else
		{
			print.DEBUG("exitMethodExpr_Cont: Type is null");
		}
		
		super.exitMethodExpr_Cont(ctx);
	}
	
	
	
@Override
	public void exitExprCont_New(ExprCont_NewContext ctx) {
	ctx.myType = Type.ERROR;
	print.err(String.format(print.errMsgs.get("Unsupported"), 
			ctx.NEW().toString()),ctx);
		super.exitExprCont_New(ctx);
	}

@Override
	public void exitExprCont_Null(ExprCont_NullContext ctx) {
	ctx.myType = Type.ERROR;
	print.err(String.format(print.errMsgs.get("Unsupported"), 
			ctx.NULL().toString()),ctx);
		super.exitExprCont_Null(ctx);
	}

	@Override
	public void exitExprCont_ME(ExprCont_MEContext ctx) {
		ctx.myType = Type.ERROR;
		print.err(String.format(print.errMsgs.get("Unsupported"), 
				ctx.ME().toString()),ctx);
		super.exitExprCont_ME(ctx);
	}

	
	@Override
	public void exitExprCont_Strlit(ExprCont_StrlitContext ctx) {
		print.err(String.format(print.errMsgs.get("Unsupported"), 
				"string literal"),ctx);
		ctx.myType = Type.STRING;
		super.enterExprCont_Strlit(ctx);
	}
	
	
	@Override
	public void exitCall_stmt(Call_stmtContext ctx) {
		List<VarDeclaration> info = new ArrayList<VarDeclaration>();
		int paramNum = 0;
		if (ctx.expression_list() != null) {
			paramNum = ctx.expression_list().expression().size();
		}

		if (ctx.t1 != null ) {
			Symbol foo = symTable.lookup(ctx.t1.getText());
			if (foo.getDecl().type.decl instanceof ClassDeclaration) {
				if (foo.getDecl().type.decl.methods.containsKey(ctx.IDENTIFIER().getText())) {
					MethodDeclaration meth = foo.getDecl().type.decl.methods.get(ctx.IDENTIFIER().getText());
					if (meth.parameters.size() != paramNum) {
						print.err(String.format(print.errMsgs.get("ParameterNumberMismatch"), 
								meth.parameters.size(), paramNum),ctx);
						
						return;
					} else {
						for (int i = 0; i < meth.parameters.size(); i++) {
							if (meth.parameters.get(i).type == ctx.expression_list().expression().get(i).myType) {
							} else {
								print.err(String.format(print.errMsgs.get("TypeMismatch"), 
										ctx.t1.getText(), meth.parameters.get(i).type, ctx.expression_list().expression().get(i).myType),ctx);
								return;
							}
						}
						return;
					}
				}
				else {
					print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
							ctx.IDENTIFIER().getText()),ctx);
					return;
				}
			}
		}
		
		if (symTable.lookup(ctx.IDENTIFIER().getText()) == null) {
			print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
					ctx.IDENTIFIER().getText()),ctx);
			return;
		} 
		
		
		
		MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER().getText()).getDecl();
		info = mDecl.getParameters();

		
		if (symTable.lookup(ctx.IDENTIFIER().getText()) != null) {
			if (info.size() == paramNum) {
				for (int i = 0; i < info.size(); i++) {
					if ( info.get(i).type == ctx.expression_list().expression().get(i).myType) {
						//print.DEBUG("MATCHED Type: " + info.get(i).type);
					}
					else {
						print.err(String.format(print.errMsgs.get("ParameterMismatch"), 
								info.get(i).type.toString(), 
								ctx.expression_list().expression().get(i).myType.toString()),ctx);
						return;
					}
				}
			} else {
				print.err(String.format(print.errMsgs.get("ParameterNumberMismatch"), 
						info.size(), ctx.expression_list().expression().size()),ctx);
				return;
			}
			
		} else {
			print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
					ctx.IDENTIFIER().getText()),ctx);
			return;
		}
		super.exitCall_stmt(ctx);
	}
	//FIXME(Make sure to fix readint and write int)
	@Override
	public void exitExprCont_IDExpr(ExprCont_IDExprContext ctx) {
		int paramNum = 0;
		
		
		//System.out.println("I AM INSIDE OF EXIT EXPR CONT ID THING");
		if (ctx.expression_list() != null) {
			paramNum = ctx.expression_list().expression().size();
			//System.out.println("Param is this: " + paramNum);
		}
		if (ctx.IDENTIFIER().getText().equals("readint")) {
			if (paramNum != 0) {
				print.err(String.format(print.errMsgs.get("ParameterNumberMismatch"), 
						0, paramNum),ctx);
				ctx.myType = Type.ERROR;
				return;
			} else {
				ctx.myType = Type.INT;
				return;
			}
		} else if (ctx.IDENTIFIER().getText().equals("writeint")) {
			if (paramNum != 1) {
				print.err(String.format(print.errMsgs.get("ParameterNumberMismatch"), 
						1, paramNum),ctx);
				return;
			} else {
				for (int i = 0; i < paramNum; i++) {
					if (ctx.expression_list().expression().get(i).myType == Type.INT) {
						//we gucci
					} else {
						print.err(String.format(print.errMsgs.get("ParameterNumberMismatch"), 
								0, paramNum),ctx);
					}
				}
				ctx.myType = Type.VOID;
				return;
			}
		}
		List<VarDeclaration> info = new ArrayList<VarDeclaration>();
			if (symTable.lookup(ctx.IDENTIFIER().getText()) == null) {
				print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
					ctx.IDENTIFIER().getText()),ctx);
				ctx.myType = Type.ERROR;
				return;
			}
			MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER().getText()).getDecl();
	
			info = mDecl.getParameters();

		
		if (symTable.lookup(ctx.IDENTIFIER().getText()) != null) {
			System.out.println(String.format("Function: %s Parameters: %s", ctx.IDENTIFIER().getText(), info.size()));
			if (info.size() == paramNum) {
				for (int i = 0; i < info.size(); i++) {
					if ( info.get(i).type == ctx.expression_list().expression().get(i).myType) {
						//print.DEBUG("MATCHED Type: " + info.get(i).type);
					}
					else {
						print.err(String.format(print.errMsgs.get("ParameterMismatch"), 
								info.get(i).type.toString(), 
								ctx.expression_list().expression().get(i).myType.toString()),ctx);
						ctx.myType = Type.ERROR;
						return;
					}
				}
			} else {
				print.err(String.format(print.errMsgs.get("ParameterNumberMismatch"), 
						info.size(), paramNum),ctx);
				ctx.myType = Type.ERROR;
				return;
			}
			
		} else {
			print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
					ctx.IDENTIFIER().getText()),ctx);
			ctx.myType = Type.ERROR;
			return;
		}
		Symbol foo = symTable.lookup(ctx.IDENTIFIER().getText());
		ctx.myType = foo.getDecl().type;
		super.exitExprCont_IDExpr(ctx);
	}

	@Override
	public void exitExprCont_Intlit(ExprCont_IntlitContext ctx) {
		ctx.myType = Type.INT;
		super.enterExprCont_Intlit(ctx);
	}
	
	
	
	@Override
	public void exitExprCont_True(ExprCont_TrueContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_True(ctx);
	}

	@Override
	public void exitExprCont_False(ExprCont_FalseContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_False(ctx);
	}
	
	
	@Override
	public void exitExprCont_ID(ExprCont_IDContext ctx) {
		
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			if (sym.getDecl() instanceof VarDeclaration) {
				VarDeclaration test = (VarDeclaration) sym.getDecl();
				System.out.println("offset of " + sym.getName() + " is: " + test.getOffset());
			}
			//System.out.println(sym.getName() + " isn't null");
			ctx.sym = sym;
			ctx.myType = sym.getDecl().type;
		}
		else {
			print.err(String.format(print.errMsgs.get("UndefinedVar"), 
					ctx.IDENTIFIER().getText()),ctx);
			ctx.myType = Type.ERROR;
		}
		
		super.exitExprCont_ID(ctx);
	}

	@Override
	public void exitTypeInt(TypeIntContext ctx) {
		ctx.myType = Type.INT;
	}
	@Override
	public void exitTypeString(TypeStringContext ctx) {
		ctx.myType = Type.STRING;
		print.err(String.format(print.errMsgs.get("Unsupported"), 
				"string variable definition"),ctx);
		super.enterTypeString(ctx);
	}
	@Override
	public void exitTypeBool(TypeBoolContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.enterTypeBool(ctx);
	}

	@Override
	public void exitTypeID(TypeIDContext ctx) {
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			ctx.myType = sym.getDecl().type;
		}
		else {
			ctx.myType = Type.ERROR;
		}
		super.exitTypeID(ctx);
	}

	@Override
	public void exitArgument_decl(Argument_declContext ctx) {
		if (doesTypeExist(ctx.type().myType)) {
		}
		else {
			System.err.println("exitArgument_decl type does not exist. implement error.");
		}
		super.exitArgument_decl(ctx);
	}

	@Override
	public void exitArgument_decl_list(Argument_decl_listContext ctx) {
		int offset = 8;
		for (int i = 0; i < ctx.argument_decl().size(); i++) {
			VarDeclaration foo = new VarDeclaration(ctx.argument_decl(i).type().myType,ctx.argument_decl(i).IDENTIFIER().getText());
			foo.setOffset(offset);
			offset += 4;
			symTable.push(ctx.argument_decl(i).IDENTIFIER().getText(), foo);
			
		}
		
		super.exitArgument_decl_list(ctx);
	}
	
	

	@Override
	public void exitMethod_decl(Method_declContext ctx) {
		int paramOffset = 8;
		MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
		//giving offsets to all parameters. (POSITIVE)
		if (ctx.argument_decl_list() != null) {
			for (int i = 0; i < ctx.argument_decl_list().argument_decl().size(); i++) {
				mDecl.appendParameter(ctx.argument_decl_list().argument_decl(i).type().myType,ctx.argument_decl_list().argument_decl(i).IDENTIFIER().getText());
				paramOffset += 4;
			}
		}
		ctx.params = ctx.var_decl().size();
		//giving offsets to all locals (NEGATIVE)
//		if (ctx.var_decl().size() > 0) {
//			
//			for (int i = 0; i < ctx.var_decl().size(); i++) {
//				//System.out.println("var is: " + ctx.var_decl(i).IDENTIFIER().getText());
//				mDecl.appendVariable(ctx.var_decl(i).type().myType, ctx.var_decl(i).IDENTIFIER().getText(), localOffset);
//				localOffset = localOffset - 4;
//			}
//		}
//		MethodDeclaration mDecl1 = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
//		System.out.println("Printing out the parameters i just added to the metho dinside the syumbol table:");
//		for (int i = 0; i < mDecl1.getParameters().size(); i++) {
//			System.out.println(mDecl1.getParameters().get(i).name + " offset: " + mDecl1.getParameters().get(i).getOffset());
//		}
//		System.out.println("Printing out the locals i just added to the metho dinside the syumbol table:");
//		for (int i = 0; i < mDecl1.getVariables().size(); i++) {
//			System.out.println(mDecl1.getVariables().get(i).name + " offset: " +  mDecl1.getVariables().get(i).getOffset());
//		}
		
	
		
		symTable.endScope();
		super.exitMethod_decl(ctx);
	}

	@Override
	public void enterMethod_decl(Method_declContext ctx) {
		//dumb way of doing it since it doesn't include user defined types, but
		//it'll work for now
		List<Type> types = Arrays.asList(Type.INT, Type.BOOLEAN, Type.STRING, Type.READER, Type.VOID, Type.WRITER);
		Type t = Type.VOID;
		
		for (Type i : types ) {
			if (ctx.typ != null && i.name.equals(ctx.typ.getText())) {
				t = i;
			}
		}

		symTable.push(ctx.IDENTIFIER(0).getText(), new MethodDeclaration(t));
		symTable.beginScope();
		//setting local offset to -8 because the function is beginning
		symTable.setLocalOffset(-8);
		super.enterMethod_decl(ctx);
	}

	@Override
	public void enterClass_(Class_Context ctx) {
		//increment scope
		symTable.createType(ctx.IDENTIFIER(0).getText());
		symTable.push(ctx.IDENTIFIER(0).getText(), 
				new ClassDeclaration(symTable.types.get(ctx.IDENTIFIER(0).getText())));
		mainClass = (ClassDeclaration)symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
		symTable.beginScope();
		symTable.push("in", new VarDeclaration(Type.READER, "in"));
		symTable.push("out", new VarDeclaration(Type.WRITER, "out"));
		
		super.enterClass_(ctx);
	}

	
	@Override
	public void exitClass_(Class_Context ctx) {
		//decrement scope
		for (FloydParser.Method_declContext func : ctx.method_decl()) {
			MethodDeclaration  classMethod = (MethodDeclaration)symTable.lookup(func.IDENTIFIER(0).getText()).getDecl();
			mainClass.appendMethod(func.IDENTIFIER(0).getText(), classMethod);
		}
		symTable.endScope();
		super.exitClass_(ctx);
	}

	@Override
	public void exitMethodDot_Exp(MethodDot_ExpContext ctx) {
		System.out.println("NEED TO IMPLEMENT IT HEREIASOJOIASJDJOIASDIOJASJOIDIOASJ");
		Symbol sym = symTable.lookup(ctx.e1.getText());
		if (sym != null) {
			ctx.myType = Type.INT;
		}
		else {
			print.err("Error in methoddot_exp, implement in phase4. variable doesnt exist" + ctx.e1.getText(), ctx);
			ctx.myType = Type.ERROR;
			
		}
		
		super.exitMethodDot_Exp(ctx);
	}

	

	
	
	
	
	
	
	
	

}
