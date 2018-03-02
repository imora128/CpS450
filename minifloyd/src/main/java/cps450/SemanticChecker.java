package cps450;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

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

public class SemanticChecker extends FloydBaseListener {
	SymbolTable symTable = SymbolTable.getInstance();
	MyError print = new MyError(true);
	Option opt;
	SemanticChecker(Option opt) {
		this.opt = opt;
		print.opt = opt;
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
				String msg = "Unsupported feature: Attempting to initialize";
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				return;
			}
			
		
		if (ctx.ty != null && doesTypeExist(ctx.type().myType)) {
			Symbol sym = symTable.lookup(ctx.IDENTIFIER().toString());
			if (sym != null && sym.getScope() == symTable.getScope()) {
				String msg = "Attempting to redefine variable " + ctx.IDENTIFIER().toString() + " in the same scope.";
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);	
				return;
			}
			
//			if (symTable.lookup(ctx.IDENTIFIER().toString()).getScope() == symTable.getScope()) {
//				String msg = "Attempting to redefine variable " + ctx.IDENTIFIER().toString() + " in the name scope.";
//				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
//						ctx.start.getCharPositionInLine() + ":" + msg);
//			}
			symTable.push(ctx.IDENTIFIER().toString(),new VarDeclaration(ctx.type().myType, ctx.IDENTIFIER().toString()));
//			print.DEBUG("Variable declared: " + ctx.IDENTIFIER().toString() +
//			" Type: " + ctx.type().myType);
			
		}
		else {
			String msg = "Variable type does not exist or is not provided";
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
		}
		

		
		super.exitVar_decl(ctx);
	}
	
	
	@Override
	public void exitAssignment_stmt(Assignment_stmtContext ctx) {
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		
		if (sym != null) {
//			print.DEBUG("LHS is: " + sym.getDecl().type);
//			print.DEBUG("RHS: " + ctx.expression(0).myType);
			for (int i = 0; i < ctx.expression().size(); i++) {
				if (sym.getDecl().type == ctx.expression(i).myType) {
//					print.DEBUG("LHS:" + sym.getName() + "(" + sym.getDecl().type + ")" +  
//							"matches the RHS: " + ctx.expression(i).getText()+ "(" + ctx.expression(i).myType + ")");
				}
				else {
					String msg = "Type  mismatch in assignment statement: expected " + sym.getDecl().type + 
							" on RHS, got "  +  ctx.expression(i).myType;
					print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
							ctx.start.getCharPositionInLine() + ":" + msg);
				}
			}
		}
		else {
			String msg = "Trying to use undeclared variable " + ctx.IDENTIFIER().getText();
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
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
		String msg = "Feature unsupported: Array";
		print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
				ctx.start.getCharPositionInLine() + ":" + msg);
		super.exitExprCont_Array(ctx);
	}

	@Override
	public void exitIf_stmt(If_stmtContext ctx) {
		Type exprType = ctx.expression().myType;
		if (exprType == Type.BOOLEAN) {
			//print.DEBUG("Sucess. Expression is bool");
		}
		else {
			String msg = "Type  mismatch in if statement: expected boolean but got " + exprType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
		}
		
		super.exitIf_stmt(ctx);
	}
	
	

	@Override
	public void exitLoop_stmt(Loop_stmtContext ctx) {
		Type exprType = ctx.expression().myType;
		if (exprType == Type.BOOLEAN) {
			//print.DEBUG("Sucess. Expression is bool");
		}
		else {
			String msg = "Type  mismatch in while statement: expected boolean but got " + exprType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
		}
		
		super.exitLoop_stmt(ctx);
	}

	@Override
	public void exitExprRelational_Expr(ExprRelational_ExprContext ctx) {
		if (ctx.relational_exp().myType != null) {
			//System.out.println("###########Here's the type at teh top:" + ctx.relational_exp().myType);
			ctx.myType = ctx.relational_exp().myType;
		}
		else {
			//print.DEBUG("exitExprRelational_Expr: Got null");
		}
		super.exitExprRelational_Expr(ctx);
	}

	@Override
	public void exitExprOr_Expr(ExprOr_ExprContext ctx) {
		if (ctx.or_exp().myType != null) {
			//print.DEBUG("###########Here's the type at teh top:" + ctx.or_exp().myType);
			ctx.myType = ctx.or_exp().myType;
		}
		else {
			print.DEBUG("exitExprOr_Exprr: Got null");
		}
		super.exitExprOr_Expr(ctx);
	}

	@Override
	public void exitRelationalGE_Exp(RelationalGE_ExpContext ctx) {
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT || ctx.e1.myType == Type.STRING ) {
			if (ctx.e1.myType == ctx.e2.myType) {
				//print.DEBUG("got 2" + ctx.e1.myType);
				ctx.myType = Type.BOOLEAN;
				
			} else {
				String msg = "Incorrect type for >=:" + "requires " + ctx.e1.myType +  ", got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}	
		else {
			String msg = "Incorrect type for >=:" + "requires int or string got " + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		super.exitRelationalGE_Exp(ctx);
	}


	@Override
	public void exitRelationalGT_Exp(RelationalGT_ExpContext ctx) {
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT || ctx.e1.myType == Type.STRING ) {
			if (ctx.e1.myType == ctx.e2.myType) {
				//print.DEBUG("got 2" + ctx.e1.myType);
				ctx.myType = Type.BOOLEAN;
				
			} else {
				String msg = "Incorrect type for >:" + "requires " + ctx.e1.myType +  ", got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}	
		else {
			String msg = "Incorrect type for >:" + "requires int or string got " + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		
		super.exitRelationalGT_Exp(ctx);
	}


	@Override
	public void exitRelationalEQ_Exp(RelationalEQ_ExpContext ctx) {
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT || ctx.e1.myType == Type.STRING  || ctx.e1.myType == Type.BOOLEAN) {
			if (ctx.e1.myType == ctx.e2.myType) {
				//print.DEBUG("got 2" + ctx.e1.myType);
				ctx.myType = Type.BOOLEAN;
				
			} else {
				String msg = "Incorrect type for =:" + "requires " + ctx.e1.myType +  ", got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for =:" + "requires int, string, or bool got " + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
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
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.BOOLEAN) {
			if (ctx.e2.myType == Type.BOOLEAN) {
				ctx.myType = Type.BOOLEAN;
				//print.DEBUG("ExitOrX: 2 Booleans, we're ok");
			}
			else {
				String msg = "Incorrect type for " + ctx.OR().toString() + ": requires booleans, got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for " + ctx.OR().toString() + ": requires booleans, got "  + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		super.exitOrX_Exp(ctx);
	}
	
	@Override
	public void exitOrAnd_Exp(OrAnd_ExpContext ctx) {
		if (ctx.and_exp().myType != null) {
			ctx.myType = ctx.and_exp().myType;
		}
		else
		{
			print.DEBUG("exitOrAnd_Exp: shows previous func is null");
		}
		super.exitOrAnd_Exp(ctx);
	}


	@Override
	public void exitAndX_Exp(AndX_ExpContext ctx) {
	
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.BOOLEAN) {
			if (ctx.e2.myType == Type.BOOLEAN) {
				ctx.myType = Type.BOOLEAN;
				print.DEBUG("exitAndX: 2 Booleans, we're ok");
			}
			else {
				String msg = "Incorrect type for " + ctx.AND().toString() + ": requires booleans, got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for " + ctx.AND().toString() + ": requires booleans, got "  + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
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
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.STRING) {
			if (ctx.e2.myType == Type.STRING) {
				ctx.myType = Type.STRING;
				print.DEBUG("exitConcatX: 2 strings, we're ok");
			}
			else {
				String msg = "Incorrect type for " + ctx.AMPERSAND().toString() + ": requires strings, got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for " + ctx.AMPERSAND().toString() + ": requires strings, got "  + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
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
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT) {
			if (ctx.e2.myType == Type.INT) {
				ctx.myType = Type.INT;
				print.DEBUG("exitAddPlus_Exp: 2 ints, we're ok");
			}
			else {
				String msg = "Incorrect type for " + ctx.PLUS().toString() + ": requires ints, got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for " + ctx.PLUS().toString() + ": requires ints, got "  + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		super.exitAddPlus_Exp(ctx);
	}


	@Override
	public void exitAddMinus_Exp(AddMinus_ExpContext ctx) {
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT) {
			if (ctx.e2.myType == Type.INT) {
				ctx.myType = Type.INT;
				//print.DEBUG("exitAddMinus_Exp: 2 ints, we're ok");
			}
			else {
				String msg = "Incorrect type for -:" + "requires ints, got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for -:" + "requires ints, got " + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
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
	
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT ) {
			if (ctx.e2.myType == Type.INT) {
				//print.DEBUG("exitMultiTimes_Exp: 2 ints, we're ok");
				ctx.myType = Type.INT;
			}
			else {
				String msg = "Incorrect type for *:" + "requires ints, got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}
		else {
			String msg = "Incorrect type for *:" + "requires ints, got " + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		super.exitMultiTimes_Exp(ctx);
	}


	@Override
	public void exitMultiDIV_Exp(MultiDIV_ExpContext ctx) {
		if (ctx.e1.myType == Type.ERROR || ctx.e2.myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.e1.myType == Type.INT ) {
			if (ctx.e1.myType == ctx.e2.myType) {
				print.DEBUG("got 2" + ctx.e1.myType);
				ctx.myType = Type.INT;
				
			} else {
				String msg = "Incorrect type for /:" + "requires " + ctx.e1.myType +  ", got " + ctx.e2.myType;
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
			}
		}	
		else {
			String msg = "Incorrect type for /:" + "requires int got " + ctx.e1.myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		
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
		if (ctx.unary_exp().myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.unary_exp().myType == Type.INT) {
			ctx.myType = Type.INT;
			print.DEBUG("enterUnaryPlus_Exp: It's an int, we're ok.");
		}
		else {
			String msg = "Incorrect type for +:" + "requires int, got " + ctx.unary_exp().myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		super.exitUnaryPlus_Exp(ctx);
	}


	@Override
	public void exitUnaryMinus_Exp(UnaryMinus_ExpContext ctx) {
		if (ctx.unary_exp().myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.unary_exp().myType == Type.INT) {
			ctx.myType = Type.INT;
			print.DEBUG("enterUnaryMinus_Exp: It's an int, we're ok.");
		}
		else {
			String msg = "Incorrect type for -:" + "requires int, got " + ctx.unary_exp().myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		super.enterUnaryMinus_Exp(ctx);
	}


	@Override
	public void exitUnaryNot_Exp(UnaryNot_ExpContext ctx) {
		if (ctx.unary_exp().myType == Type.ERROR) {
			ctx.myType = Type.ERROR;
			return;
		}
		if (ctx.unary_exp().myType == Type.BOOLEAN) {
			ctx.myType = Type.BOOLEAN;
			print.DEBUG("exitUnaryNot: It's a boolean, we're ok.");
		}
		else {
			ctx.myType = Type.ERROR;
			String msg = "Incorrect type for not:" + "requires boolean, got " + ctx.unary_exp().myType;
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
		}
		super.enterUnaryNot_Exp(ctx);
	}
	
	
	@Override
	public void exitUnaryMethod_Exp(UnaryMethod_ExpContext ctx) {
//		print.DEBUG("exitUnaryMethod. ctx.method_exp is: " + ctx.method_exp().myType);
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
		//print.DEBUG("in exitmethodexpr_cont. type: " + ctx.expr_cont().myType);
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
	String msg = "Feature unsupported: new";
	print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
			ctx.start.getCharPositionInLine() + ":" + msg);
		super.exitExprCont_New(ctx);
	}

@Override
	public void exitExprCont_Null(ExprCont_NullContext ctx) {
	ctx.myType = Type.ERROR;
	String msg = "Feature unsupported: NULL";
	print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
			ctx.start.getCharPositionInLine() + ":" + msg);
		super.exitExprCont_Null(ctx);
	}

	@Override
	public void exitExprCont_ME(ExprCont_MEContext ctx) {
		ctx.myType = Type.ERROR;
		String msg = "Feature unsupported: ME";
		print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
				ctx.start.getCharPositionInLine() + ":" + msg);
		super.exitExprCont_ME(ctx);
	}

	
	@Override
	public void exitExprCont_Strlit(ExprCont_StrlitContext ctx) {
		//print.DEBUG("ExprCont_Strlit passing the type");
		String msg = "Feature unsuported: string literal";
		print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
				ctx.start.getCharPositionInLine() + ":" + msg);
		ctx.myType = Type.STRING;
		super.enterExprCont_Strlit(ctx);
	}
	
	//FIXME(expr function call )
	@Override
	public void exitExprCont_IDExpr(ExprCont_IDExprContext ctx) {

		List<VarDeclaration> info = new ArrayList<VarDeclaration>();
			if (symTable.lookup(ctx.IDENTIFIER().getText()) == null) {
				String msg = "Undefined function '" + ctx.IDENTIFIER().getText() + "'";
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
				return;
			}
			MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER().getText()).getDecl();
	
			info = mDecl.getParameters();
		
		if (symTable.lookup(ctx.IDENTIFIER().getText()) != null) {
//			print.DEBUG("Size of given parameters: " + ctx.expression_list().expression().size());
//			print.DEBUG("Size of expected parameters: " + info.size());
			if (info.size() == ctx.expression_list().expression().size()) {
				for (int i = 0; i < info.size(); i++) {
					if ( info.get(i).type == ctx.expression_list().expression().get(i).myType) {
						print.DEBUG("MATCHED Type: " + info.get(i).type);
					}
					else {
						String msg = "Expected variable type " + info.get(i).type.toString() + " got " + 
								ctx.expression_list().expression().get(i).myType.toString();
						print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
								ctx.start.getCharPositionInLine() + ":" + msg);
						ctx.myType = Type.ERROR;
						return;
					}
				}
			} else {
				String msg = "Expected " + info.size() + " parameters. Got " +ctx.expression_list().expression().size();
				print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
						ctx.start.getCharPositionInLine() + ":" + msg);
				ctx.myType = Type.ERROR;
				return;
			}
			
		} else {
			String msg = "Attempting to call a function that has not been declared.";
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
			return;
		}
		Symbol foo = symTable.lookup(ctx.IDENTIFIER().getText());
//		print.DEBUG("return asdfsdfasdfasdfsdfsdfasdfasdfasdfastype is " + foo.getDecl().type);
		ctx.myType = foo.getDecl().type;
		super.exitExprCont_IDExpr(ctx);
	}

	@Override
	public void exitExprCont_Intlit(ExprCont_IntlitContext ctx) {
		//print.DEBUG("ExprCont_Intlit passing the type");
		ctx.myType = Type.INT;
		super.enterExprCont_Intlit(ctx);
	}
	
	
	
	@Override
	public void exitExprCont_True(ExprCont_TrueContext ctx) {
		//print.DEBUG("ExprCont_True passing the type");
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_True(ctx);
	}

	@Override
	public void exitExprCont_False(ExprCont_FalseContext ctx) {
		//print.DEBUG("ExprCont_False passing the type");
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_False(ctx);
	}
	
	
	//TODO(Fix this temporary error msg system. pass token & use it in error class)
	@Override
	public void exitExprCont_ID(ExprCont_IDContext ctx) {
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			//print.DEBUG("FOUND THE SYMBOL." + ctx.IDENTIFIER().getText() + " type: " + sym.getDecl().type);
			ctx.myType = sym.getDecl().type;
		}
		else {
			String msg = "Use of undeclared variable " + ctx.IDENTIFIER().getText();
			print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
					ctx.start.getCharPositionInLine() + ":" + msg);
			ctx.myType = Type.ERROR;
		}
		
		super.exitExprCont_ID(ctx);
	}

	//TODO(typeID)
	@Override
	public void exitTypeInt(TypeIntContext ctx) {
		ctx.myType = Type.INT;
	}
	@Override
	public void exitTypeString(TypeStringContext ctx) {
		ctx.myType = Type.STRING;
		String msg = "Feature unsuported: string variable definition";
		print.error(opt.fileName.get(0) + ":" + ctx.start.getLine() + "," + 
				ctx.start.getCharPositionInLine() + ":" + msg);
		super.enterTypeString(ctx);
	}
	@Override
	public void exitTypeBool(TypeBoolContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.enterTypeBool(ctx);
	}

//	//TODO(Fix error msg)
	@Override
	public void exitTypeID(TypeIDContext ctx) {
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			//print.DEBUG("FOUND THE SYMBOL");
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
			//print.DEBUG("exitArgument_decl: passing up: " + ctx.type().myType);
		}
		else {
			System.err.println("exitArgument_decl type does not exist. implement error.");
		}
		super.exitArgument_decl(ctx);
	}

	@Override
	public void exitArgument_decl_list(Argument_decl_listContext ctx) {
		
		for (int i = 0; i < ctx.argument_decl().size(); i++) {
			//print.DEBUG("exitArgument_decl_list inside list: " + ctx.argument_decl(i).IDENTIFIER().getText());
			//print.DEBUG("exitArgument_decl_list inside list: " + ctx.argument_decl(i).type().myType);
			symTable.push(ctx.argument_decl(i).IDENTIFIER().getText(), new VarDeclaration(ctx.argument_decl(i).type().myType,ctx.argument_decl(i).IDENTIFIER().getText() ));
			
		}
		
		super.exitArgument_decl_list(ctx);
	}
	
	

	@Override
	public void exitMethod_decl(Method_declContext ctx) {
		List<VarDeclaration> li = new ArrayList<VarDeclaration>();
		MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
		//print.DEBUG("my anme is " + ctx.IDENTIFIER());
		if (ctx.argument_decl_list() != null) {
			for (int i = 0; i < ctx.argument_decl_list().argument_decl().size(); i++) {
				mDecl.appendList(ctx.argument_decl_list().argument_decl(i).type().myType,ctx.argument_decl_list().argument_decl(i).IDENTIFIER().getText());
			}
		}
		symTable.endScope();
		super.exitMethod_decl(ctx);
	}

	@Override
	public void enterMethod_decl(Method_declContext ctx) {
		List<Type> types = Arrays.asList(Type.INT, Type.BOOLEAN, Type.STRING, Type.READER, Type.VOID, Type.WRITER);
		Type t = Type.VOID;
		
		for (Type i : types ) {
			if (ctx.typ != null && i.name.equals(ctx.typ.getText())) {
				t = i;
			}
		}
		//print.DEBUG("Identifier:" + ctx.IDENTIFIER(0));

		symTable.push(ctx.IDENTIFIER(0).getText(), new MethodDeclaration(t));
		symTable.beginScope();
		super.enterMethod_decl(ctx);
	}


	
	
	

	
	
	
	
	
	
	
	

}
