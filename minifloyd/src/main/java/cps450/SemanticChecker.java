package cps450;
import java.util.HashMap;
import java.util.Scanner;

import org.antlr.v4.runtime.Token;

import cps450.FloydParser.AddMinus_ExpContext;
import cps450.FloydParser.AddMulti_ExpContext;
import cps450.FloydParser.AddPlus_ExpContext;
import cps450.FloydParser.Add_expContext;
import cps450.FloydParser.AndConcat_ExpContext;
import cps450.FloydParser.AndX_ExpContext;
import cps450.FloydParser.And_expContext;
import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.ConcatAdd_ExpContext;
import cps450.FloydParser.ConcatX_ExpContext;
import cps450.FloydParser.Concat_expContext;
import cps450.FloydParser.ExprCont_FalseContext;
import cps450.FloydParser.ExprCont_IDContext;
import cps450.FloydParser.ExpressionContext;
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
import cps450.FloydParser.ExprCont_IntlitContext;
import cps450.FloydParser.UnaryNot_ExpContext;
import cps450.FloydParser.UnaryPlus_ExpContext;
import cps450.FloydParser.MethodExpr_ContContext;


public class SemanticChecker extends FloydBaseListener {
	SymbolTable symTable = SymbolTable.getInstance();
	MyError print = new MyError(true);
	
	//TODO(:= Expr version of var_decl & Errors)
	@Override
	public void exitVar_decl(Var_declContext ctx) {
		symTable.push(ctx.IDENTIFIER().toString(),new VarDeclaration(ctx.type().myType));
//		print.DEBUG("Variable declared: " + ctx.IDENTIFIER().toString() +
//				" Type: " + ctx.type().myType);
		
		super.exitVar_decl(ctx);
	}
	
	
	//TODO(Assignment statement, which requires expression & errors)
	@Override
	public void exitAssignment_stmt(Assignment_stmtContext ctx) {
		super.exitAssignment_stmt(ctx);
	}
	//TODO(Return type from expression. & Errors)
	@Override
	public void exitExpression(ExpressionContext ctx) {
		
		super.exitExpression(ctx);
	}


	
	
	@Override
	public void exitRelationalGE_Exp(RelationalGE_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("exitRelationalGE_Exp: 2 INTs, we're ok");
		}
		else if (ctx.e1.myType == Type.STRING && ctx.e2.myType == Type.STRING ) {
			print.DEBUG("exitRelationalGE_Exp: 2 Strings, we're ok");
		}
		else {
			print.error("exitRelationalGE_Exp: Did not get 2 ints or 2 strings");
		}
		super.exitRelationalGE_Exp(ctx);
	}


	@Override
	public void exitRelationalGT_Exp(RelationalGT_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("exitRelationalGT_Exp: 2 INTs, we're ok");
		}
		else if (ctx.e1.myType == Type.STRING && ctx.e2.myType == Type.STRING ) {
			print.DEBUG("exitRelationalGT_Exp: 2 Strings, we're ok");
		}
		else {
			print.error("exitRelationalGT_Exp: Did not get 2 ints or 2 strings");
		}
		super.exitRelationalGT_Exp(ctx);
	}


	@Override
	public void exitRelationalEQ_Exp(RelationalEQ_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("exitRelationalEQ_Exp: 2 INTs, we're ok");
		}
		else if (ctx.e1.myType == Type.STRING && ctx.e2.myType == Type.STRING ) {
			print.DEBUG("exitRelationalEQ_Exp: 2 Strings, we're ok");
		}
		else if (ctx.e1.myType == Type.BOOLEAN && ctx.e2.myType == Type.BOOLEAN ) {
			print.DEBUG("exitRelationalEQ_Exp: 2 Booleans, we're ok");
		}
		else {
			print.error("exitRelationalEQ_Exp: Did not get 2 ints,2 strings, or 2 booleans");
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
			print.error("exitRelationalOr_Exp: shows previous func is null");
		}
		super.exitRelationalOr_Exp(ctx);
	}



	@Override
	public void exitOrX_Exp(OrX_ExpContext ctx) {
		if (ctx.e1.myType == Type.BOOLEAN && ctx.e2.myType == Type.BOOLEAN) {
			print.DEBUG("exitOrX_Exp: 2 BOOLEANS, we're ok");
		}
		else {
			print.error("exitOrX_Exp: Did not get 2 BOOLEANS");
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
			print.error("exitOrAnd_Exp: shows previous func is null");
		}
		super.exitOrAnd_Exp(ctx);
	}


	@Override
	public void exitAndX_Exp(AndX_ExpContext ctx) {
		if (ctx.e1.myType == Type.BOOLEAN && ctx.e2.myType == Type.BOOLEAN) {
			print.DEBUG("exitAndX_Exp: 2 BOOLEANS, we're ok");
		}
		else {
			print.error("exitAndX_Exp: Did not get 2 BOOLEANS");
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
			print.error("exitAndConcat_Exp: shows previous func is null");
		}
		super.exitAndConcat_Exp(ctx);
	}


	@Override
	public void exitConcatX_Exp(ConcatX_ExpContext ctx) {
		if (ctx.e1.myType == Type.STRING && ctx.e2.myType == Type.STRING) {
			print.DEBUG("exitConcat_Exp: 2 strings, we're ok");
		}
		else {
			print.error("exitConcat_Exp: Did not get 2 strings");
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
			print.error("exitConcatAdd_Exp: shows previous func is null");
		}
		super.exitConcatAdd_Exp(ctx);
	}


	@Override
	public void exitAddPlus_Exp(AddPlus_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("AddPlus_Exp: 2 ints, we're ok");
		}
		else {
			print.error("exitAddMinus_Exp: Did not get 2 ints");
		}
		super.exitAddPlus_Exp(ctx);
	}


	@Override
	public void exitAddMinus_Exp(AddMinus_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("exitAddMinus_Exp: 2 ints, we're ok");
		}
		else {
			print.error("exitAddMinus_Exp: Did not get 2 ints");
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
			print.error("exitAddMulti_Exp: shows previous func is null");
		}
		super.exitAddMulti_Exp(ctx);
	}

	@Override
	public void exitMultiTimes_Exp(MultiTimes_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("exitMultiTimes_Exp: 2 ints, we're ok");
		}
		else {
			print.error("exitMultiTimes_Exp: Did not get 2 ints");
		}
		super.exitMultiTimes_Exp(ctx);
	}


	@Override
	public void exitMultiDIV_Exp(MultiDIV_ExpContext ctx) {
		if (ctx.e1.myType == Type.INT && ctx.e2.myType == Type.INT) {
			print.DEBUG("exitMultiDIV_Exp: 2 ints, we're ok");
		}
		else {
			print.error("exitMultiDIV_Exp: Did not get 2 ints");
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
			print.error("exitMultiUnary_Exp shows previous func is null");
		}
		super.exitMultiUnary_Exp(ctx);
	}


	@Override
	public void exitUnaryPlus_Exp(UnaryPlus_ExpContext ctx) {
		if (ctx.unary_exp().myType == Type.INT) {
			print.DEBUG("enterUnaryPlus_Exp: It's an int, we're ok.");
		}
		else {
			print.error("enterUnaryMinus_Exp: Not the type we want. Type given: " + ctx.unary_exp().myType);
		}
		super.exitUnaryPlus_Exp(ctx);
	}


	@Override
	public void exitUnaryMinus_Exp(UnaryMinus_ExpContext ctx) {
		if (ctx.unary_exp().myType == Type.INT) {
			print.DEBUG("enterUnaryMinus_Exp: It's an int, we're ok.");
		}
		else {
			print.error("enterUnaryMinus_Exp: Not the type we want. Type given: " + ctx.unary_exp().myType);
		}
		super.enterUnaryMinus_Exp(ctx);
	}


	@Override
	public void exitUnaryNot_Exp(UnaryNot_ExpContext ctx) {
		if (ctx.unary_exp().myType == Type.BOOLEAN) {
			print.DEBUG("exitUnaryNot: It's a boolean, we're ok.");
		}
		else {
			print.error("exitUnaryNot: Not a boolean, error.");
		}
		super.enterUnaryNot_Exp(ctx);
	}
	
	
	//TODO(checking the methods. skipped them)
	@Override
	public void exitUnaryMethod_Exp(UnaryMethod_ExpContext ctx) {
//		print.DEBUG("exitUnaryMethod. ctx.method_exp is: " + ctx.method_exp().myType);
		if (ctx.method_exp().myType != null) {
			ctx.myType = ctx.method_exp().myType;
		}
		else
		{
			print.error("exitUnaryMethod shows previous func is null");
		}
		super.exitUnaryMethod_Exp(ctx);
	}

	@Override
	public void exitMethodExpr_Cont(MethodExpr_ContContext ctx) {
		//print.DEBUG("in exitmethodexpr_cont. type: " + ctx.expr_cont().myType);
		ctx.myType = ctx.expr_cont().myType;
		
		super.exitMethodExpr_Cont(ctx);
	}
	

	//TODO(ExprCont_ID, exprCont_Null, ExprCont_ME,ExprCont_ParExp, ExprCont_Array, ExprCont_IDExpr)
	@Override
	public void exitExprCont_Strlit(ExprCont_StrlitContext ctx) {
		//print.DEBUG("ExprCont_Strlit passing the type");
		ctx.myType = Type.STRING;
		super.enterExprCont_Strlit(ctx);
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
			print.DEBUG("FOUND THE SYMBOL. type: " + sym.getDecl().type);
			ctx.myType = sym.getDecl().type;
		}
		else {
			throw new RuntimeException("Use of undeclared variable" + ctx.IDENTIFIER().getText());
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
		super.enterTypeString(ctx);
	}
	@Override
	public void exitTypeBool(TypeBoolContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.enterTypeBool(ctx);
	}

//	//TODO(Fix error msg)
//	@Override
//	public void exitTypeID(TypeIDContext ctx) {
//		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
//		if (sym != null) {
//			print.DEBUG("FOUND THE SYMBOL");
//			ctx.myType = sym.getDecl().type;
//		}
//		else {
//			throw new RuntimeException("Use of undeclared variable" + ctx.IDENTIFIER().getText());
//		}
//		super.exitTypeID(ctx);
//	}
//	
	
	
	
	
	

}
