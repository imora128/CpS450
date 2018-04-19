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
import cps450.FloydParser.AddMinus_ExpContext;
import cps450.FloydParser.AddMulti_ExpContext;
import cps450.FloydParser.AddPlus_ExpContext;
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
import cps450.FloydParser.Relate_switch_expContext;
import cps450.FloydParser.RelationalEQ_ExpContext;
import cps450.FloydParser.RelationalGE_ExpContext;
import cps450.FloydParser.RelationalGT_ExpContext;
import cps450.FloydParser.Relational_expContext;
import cps450.FloydParser.StartContext;
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

/*
Function Name: SemanticChecker
Description: Performs semantic checks on the code the user provided.
*/
public class SemanticChecker extends FloydBaseListener {
	//instance scope is always 1, local scope is always 2.
	static int INSTANCE_SCOPE = 1;
	//singleton symbol table
	SymbolTable symTable;
	MyError print = new MyError(false);
	//needed for things like file name info.
	Option opt;
	//needed for code gen
	String currentClass = "";
	//necessary for calculating instance offsets 
	int instanceVarOffset = 8;
	
    /*
    Function Name: SemanticChecker (Constructor)
    Description: io_write and io_read need to be pushed into the symbol table at this time to prevent issues with
    in/out.
    */
	SemanticChecker(Option opt) {
		this.opt = opt;
		print.opt = opt;
		symTable = SymbolTable.getInstance();

		MethodDeclaration io_write = new MethodDeclaration(Type.VOID);
		MethodDeclaration io_read = new MethodDeclaration(Type.INT);
		io_write.appendParameter(Type.INT, "ch");
		symTable.push("io_write", io_write);
		symTable.push("io_read", io_read);
		
		
	}
    /*
    Function Name: doesTypeExist
    Description: Checks if the parameter type is either a predefined type or if it's an existing class type.
    */
	boolean doesTypeExist(Type t) {
		if (t == Type.INT || t == Type.BOOLEAN || t == Type.STRING || Type.getTypeForName(t.name) != null) {
			return true;
		}
		else {
			return false;
		}
	}
    /*
    Function Name: exprCompareTypes
    Description: Created to make life easier on some expression type comparisons.
    */
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
    /*
    Function Name: exprCompareTypes
    Description: Created to make life easier on unary type comparisons.
    */
	Type exprCompareTypes(Type expectedType, Type givenType, String errMsg, ParserRuleContext ctx) {
		if (expectedType == givenType && givenType != Type.ERROR) {
			return expectedType;
		} else {
			print.err(errMsg, ctx);
			return Type.ERROR;
		}
	}
    /*
    Function Name: exitVar_decl
    Description: Checks all the typing related to variable declarations. The variable offsets for instance variables
    and local variables are set here. 
    */
	@Override
	public void exitVar_decl(Var_declContext ctx) {
		//Assignment is not allowed within variable declaration.
		if (ctx.children.contains(ctx.ASSIGNMENT_OPERATOR())) {
			print.err(String.format(print.errMsgs.get("Unsupported"), 
					"Attempting to initialize a variable in the declaration section."),ctx);
			return;
		}
		
		//Making sure a type is beign given and that it exists
		if (ctx.ty != null && doesTypeExist(ctx.type().myType)) {
			Symbol sym = symTable.lookup(ctx.IDENTIFIER().toString());
			if (sym != null && sym.getScope() == symTable.getScope()) {
				print.err(String.format(print.errMsgs.get("RedefineVar"), 
						ctx.IDENTIFIER().toString()),ctx);
				return;
			}
			//If it's an instance variable, set its offset, put it into the class declaration and push it into the
			//symbol table
			if (symTable.getScope() == INSTANCE_SCOPE) {
				VarDeclaration classVariable = new VarDeclaration(ctx.type().myType, ctx.IDENTIFIER().toString());
				//setting offset of instance var
				classVariable.setOffset(instanceVarOffset);
				instanceVarOffset += 4;
				Type foo = Type.getTypeForName(currentClass);
				foo.getClassDecl().appendVar(classVariable);
				symTable.push(ctx.IDENTIFIER().toString(), classVariable);
				ctx.sym = symTable.lookup(ctx.IDENTIFIER().toString());
				return;
			}
			//Sets the offset for local variable and pushes them into the symbol table
			VarDeclaration variable = new VarDeclaration(ctx.type().myType, ctx.IDENTIFIER().toString());
			variable.setOffset(symTable.getLocalOffset());
			symTable.setLocalOffset(symTable.getLocalOffset() - 4);
			symTable.push(ctx.IDENTIFIER().toString(), variable);
			ctx.sym = symTable.lookup(ctx.IDENTIFIER().toString());
			
		}
		else {
			print.err(print.errMsgs.get("BadVarType"),ctx);
		}
		
		
		super.exitVar_decl(ctx);
	}
	
	
    /*
    Function Name: exitAssignment_stmt
    Description: Checks that the types match for assignment. 
    */
	@Override
	public void exitAssignment_stmt(Assignment_stmtContext ctx) {
		Type lhs = null;
		Type rhs = null;
		//LHS must be a variable that we're assigning to, so it needs to grab it from the symbol table.
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			for (int i = 0; i < ctx.expression().size(); i++) {
				lhs = ctx.expression(i).myType;
				rhs = sym.getDecl().type;
				if (Type.getTypeForName(lhs.name) != null) {
					lhs = Type.getTypeForName(lhs.name);
				}
				if (Type.getTypeForName(rhs.name) != null) {
					rhs = Type.getTypeForName(rhs.name);
				}
				if (lhs != Type.ERROR && rhs != lhs) {
					print.err(String.format(print.errMsgs.get("AssMismatch"), 
							sym.getDecl().type, ctx.expression(i).myType),ctx);
				}
			}
			ctx.sym = sym;
		}
		else {
			

			print.err(String.format(print.errMsgs.get("UndefinedVar"), 
					ctx.IDENTIFIER().getText()),ctx);
		}
		super.exitAssignment_stmt(ctx);
	}
	
    /*
    Function Name: exitExprCont_ParExp
    Description: Expression inside parentheses (exp). Sets the type to whatever its child was
    and moves along. No checks needed here.
    */
	@Override
	public void exitExprCont_ParExp(ExprCont_ParExpContext ctx) {
		ctx.myType = ctx.expression().myType;
		super.exitExprCont_ParExp(ctx);
	}
		
    /*
    Function Name: exitExprCont_Array
    Description: Arrays are not supported at this time.
    */
	@Override
	public void exitExprCont_Array(ExprCont_ArrayContext ctx) {
		ctx.myType = Type.ERROR;
		print.err(String.format(print.errMsgs.get("Unsupported"), "Array"),ctx);
		super.exitExprCont_Array(ctx);
	}

	
    /*
    Function Name: exitIf_stmt
    Description: If statement type check.. Just checking if the condition is a boolean.
    */
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
	
	
    /*
    Function Name: exitLoop_stmt
    Description: Once again, just checking that the conditional is a boolean.
    */
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

//    /*
//    Function Name: exitExprRelationalExpr
//    Description: Just pushing up the type up the tree for the functions that need it.
//    */
//	@Override
//	public void exitExprRelational_Expr(ExprRelational_ExprContext ctx) {
//		if (ctx.relational_exp().myType != null) {
//			ctx.myType = ctx.relational_exp().myType;
//		} else {
//			ctx.myType = Type.ERROR;
//			print.err("exitExprRelational_Expr: No type to pass up the tree",ctx);
//		}
//		super.exitExprRelational_Expr(ctx);
//	}

    /*
    Function Name: exitExprOr_Expr
    Description: Just pushing up the type up the tree for the functions that need it.
    */
	@Override
	public void exitExprOr_Expr(ExprOr_ExprContext ctx) {
		if (ctx.or_exp().myType != null) {
			ctx.myType = ctx.or_exp().myType;
		}
		else {
			ctx.myType = Type.ERROR;
			print.err("exitExprOr_Expr: No type to pass up the tree",ctx);
		}
		super.exitExprOr_Expr(ctx);
	}

    /*
    Function Name: exitRelationalGE_Exp
    Description: Type checking the operands used by >=. Only strings and ints are allowed, otherwise
    an error is thrown. NOTE: All relational operators must push up a boolean type.
    */
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

    /*
    Function Name: exitRelationalGT_Exp
    Description: Type checking the operands used by >. String and ints are the only types allowed.
    */
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

    /*
    Function Name: exitRelationalEQ_Exp
    Description: Type checking the operands used by =. 
    All types are allowed, including class types, but obviously ,they must match.
    */
	@Override
	public void exitRelationalEQ_Exp(RelationalEQ_ExpContext ctx) {
		//making sure equality tests can be don
		Type classTestType = Type.getTypeForName(ctx.e1.myType.name);
		if (classTestType != null && (classTestType == Type.getTypeForName(ctx.e2.myType.name)) ) {
			ctx.myType = Type.BOOLEAN;
			return;
		}
		
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
	
	
//    /*
//    Function Name: exitRelationalOr_Exp
//    Description: Pushing up the type for the functions that need it.
//    */
//	@Override
//	public void exitRelationalOr_Exp(RelationalOr_ExpContext ctx) {
//		if (ctx.or_exp().myType != null) {
//			ctx.myType = ctx.or_exp().myType;
//		}
//		else
//		{
//			ctx.myType = Type.ERROR;
//			print.err("exitRelationalOr_Exp: No type to pass up the tree",ctx);
//		}
//		super.exitRelationalOr_Exp(ctx);
//	}


    /*
    Function Name: exitOrX_Exp
    Description: Type checking for ors. Both operands need to be booleans.
    */
	@Override
	public void exitOrX_Exp(OrX_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.OR().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.e1.myType, ctx.e2.myType, ctx, foo);
	}
	
    /*
    Function Name: exitOrAnd_Exp
    Description: Pushing up the type for the functions that need it.
    */
	@Override
	public void exitOrAnd_Exp(OrAnd_ExpContext ctx) {
		if (ctx.and_exp().myType != null) {
			ctx.myType = ctx.and_exp().myType;
		}
		else{
			ctx.myType = Type.ERROR;
			print.err("exitOrAnd_Exp: No type to pass up the tree",ctx);
		}
		super.exitOrAnd_Exp(ctx);
	}

    @Override
	public void exitRelate_switch_exp(Relate_switch_expContext ctx) {
		if (ctx.concat_exp() != null) {
			ctx.myType = ctx.concat_exp().myType;
		} else if (ctx.relational_exp() != null) {
			ctx.myType = ctx.relational_exp().myType;
		} else {
			ctx.myType = Type.ERROR;
			print.err("exitRelate_switch_exp: No type to pass up the tree",ctx);
		}
		super.exitRelate_switch_exp(ctx);
	}
	/*
    Function Name: exitAndX_Exp
    Description: Type checking for Ands. Need to be booleans.
    */
	@Override
	public void exitAndX_Exp(AndX_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.AND().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitAndX_Exp(ctx);
	}
	
	
	
    /*
    Function Name: exitAndConcat_Exp
    Description: Pushing up the type for the functions that need it.
    */
	@Override
	public void exitAndConcat_Exp(AndConcat_ExpContext ctx) {
		if (ctx.relate_switch_exp()  != null) {
			ctx.myType = ctx.relate_switch_exp().myType;
		}
		else
		{
			ctx.myType = Type.ERROR;
			print.err("exitAndConcat_Exp: No type to pass up the tree",ctx);
		}
		super.exitAndConcat_Exp(ctx);
	}

    /*
    Function Name: exitConcatX_Exp
    Description: Type checking for the ampersand (concat) operator. The type is required to be a string. Not implemented
    into the language, but you could always use the floyd concat function.
    */
	@Override
	public void exitConcatX_Exp(ConcatX_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.AMPERSAND().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.STRING, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitConcatX_Exp(ctx);
	}
	
    /*
    Function Name: exitConcatAdd_Exp
    Description: Pushing up the type for the functions that need it.
    */
	@Override
	public void exitConcatAdd_Exp(ConcatAdd_ExpContext ctx) {
		if (ctx.add_exp().myType != null) {
			ctx.myType = ctx.add_exp().myType;
		}
		else
		{
			ctx.myType = Type.ERROR;
			print.err("exitConcatAdd_Exp: No type to pass up the tree",ctx);
		}
		super.exitConcatAdd_Exp(ctx);
	}

    /*
    Function Name: exitAddPlus_Exp
    Description: Type checking for the plus operator. The operands need to be integers.
    */
	@Override
	public void exitAddPlus_Exp(AddPlus_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.PLUS().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitAddPlus_Exp(ctx);
	}
	
    /*
    Function Name: exitAddMinus_Exp
    Description: Type checking for the minus operator. The operands need to be integers.
    */
	@Override
	public void exitAddMinus_Exp(AddMinus_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.MINUS().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitAddMinus_Exp(ctx);
	}

    /*
    Function Name: exitAddMulti_Exp
    Description: Pushing up the type for the functions that need it.
    */
	@Override
	public void exitAddMulti_Exp(AddMulti_ExpContext ctx) {
		if (ctx.multi_exp().myType != null) {
			ctx.myType = ctx.multi_exp().myType;
		}
		else
		{
			ctx.myType = Type.ERROR;
			print.err("exitAddMulti_Exp: No type to pass up the tree",ctx);
		}
		super.exitAddMulti_Exp(ctx);
	}
    /*
    Function Name: exitMultiTimes_Exp
    Description: Type checking for the * operator. Both operands must be integers.
    */
	@Override
	public void exitMultiTimes_Exp(MultiTimes_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.TIMES().toString(), ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitMultiTimes_Exp(ctx);
	}

    /*
    Function Name: exitMultiDIV_Exp
    Description: Type checking for the / operator. Both operands must be integers.
    */
	@Override
	public void exitMultiDIV_Exp(MultiDIV_ExpContext ctx) {
		List<String> foo = Arrays.asList("TypeMismatch", ctx.DIV().toString(),ctx.e1.myType.toString(), ctx.e2.myType.toString());
		ctx.myType = exprCompareTypes(Type.INT, ctx.e1.myType, ctx.e2.myType, ctx, foo);
		super.exitMultiDIV_Exp(ctx);
	}

    /*
    Function Name: exitMultiUnary_Exp
    Description: Pushing up the type for the functions that need it.
    */
	@Override
	public void exitMultiUnary_Exp(MultiUnary_ExpContext ctx) {
		if (ctx.unary_exp().myType != null) {
			ctx.myType = ctx.unary_exp().myType;
		}
		else
		{
			ctx.myType = Type.ERROR;
			print.err("exitMultiUnary_Exp: No type to pass up the tree",ctx);
		}
		super.exitMultiUnary_Exp(ctx);
	}

    /*
    Function Name: exitUnaryPlus_Exp
    Description: Checking the unary + operand. It needs to be an integer.
    */
	@Override
	public void exitUnaryPlus_Exp(UnaryPlus_ExpContext ctx) {
		String errorMsg = String.format(print.errMsgs.get("TypeMismatch"), 
				ctx.PLUS().toString(),"int", ctx.unary_exp().myType);
		ctx.myType = exprCompareTypes(Type.INT, ctx.unary_exp().myType, errorMsg, ctx);
		super.exitUnaryPlus_Exp(ctx);
	}

    /*
    Function Name: exitUnaryMinus_Exp
    Description: Checking the unary - operand. It needs to be an integer.
    */
	@Override
	public void exitUnaryMinus_Exp(UnaryMinus_ExpContext ctx) {
		String errorMsg = String.format(print.errMsgs.get("TypeMismatch"), 
				ctx.MINUS().toString(), "int", ctx.unary_exp().myType);
		ctx.myType = exprCompareTypes(Type.INT, ctx.unary_exp().myType, errorMsg, ctx);
	}

    /*
    Function Name: exitUnaryNot_Exp
    Description: Checking the unary not operand. It needs to be a bool
    */
	@Override
	public void exitUnaryNot_Exp(UnaryNot_ExpContext ctx) {
		String errorMsg = String.format(print.errMsgs.get("TypeMismatch"), 
				ctx.NOT().toString(), "boolean", ctx.unary_exp().myType);
		ctx.myType = exprCompareTypes(Type.BOOLEAN, ctx.unary_exp().myType,errorMsg, ctx);
		super.enterUnaryNot_Exp(ctx);
	}
	
    /*
    Function Name: exitUnaryMethod_Exp
    Description: Passing up the type for the functions that need it.
    */
	@Override
	public void exitUnaryMethod_Exp(UnaryMethod_ExpContext ctx) {
		if (ctx.method_exp().myType != null) {
			ctx.myType = ctx.method_exp().myType;
		}
		else
		{
			ctx.myType = Type.ERROR;
			print.err("exitUnaryMethod_Exp: No type to pass up the tree",ctx);
		}
		super.exitUnaryMethod_Exp(ctx);
	}

    /*
    Function Name: exitMethodExpr_Cont
    Description: Passing up the type for the functions that need it.
    */
	@Override
	public void exitMethodExpr_Cont(MethodExpr_ContContext ctx) {
		ctx.myType = ctx.expr_cont().myType;
		if (ctx.expr_cont().myType != null) {
			ctx.myType = ctx.expr_cont().myType;
		}
		else
		{
			ctx.myType = Type.ERROR;
			print.err("exitMethodExpr_Cont: No type to pass up the tree",ctx);
		}
		
		super.exitMethodExpr_Cont(ctx);
	}
	
    /*
    Function Name: exitExprCont_New
    Description: Makes sure the LHS type is a user defined class type, otherwise it's an error.
    */
@Override
	public void exitExprCont_New(ExprCont_NewContext ctx) {
	if (Type.getTypeForName(ctx.typ.getText()) != null ) {
		ctx.myType = Type.getTypeForName(ctx.typ.getText());
		ctx.paramNum = ctx.myType.getClassDecl().vars.size();
	} else {
		print.err(String.format("Invalid type %s on RHS of new.", ctx.typ.getText()),ctx);
		ctx.myType = Type.ERROR;
	}

		super.exitExprCont_New(ctx);
	}


	/*
	Function Name: exitExprCont_Null
	Description: A little tricky to do with the listener approach, so I have to loop up the to get the LHS and
	check it's a user defined class type.
	*/
	@Override
	public void exitExprCont_Null(ExprCont_NullContext ctx) {
	   Assignment_stmtContext nullAssign = null;
	   RelationalEQ_ExpContext equalityTest = null;
	   ParserRuleContext foo = ctx;
		while (foo != null) {
			if (foo.getParent() instanceof Assignment_stmtContext) {
				nullAssign = (Assignment_stmtContext)foo.getParent();
				break;
			} else if (foo.getParent() instanceof RelationalEQ_ExpContext) {
				equalityTest = (RelationalEQ_ExpContext)foo.getParent();
			}
			
			foo = foo.getParent();
		}
		//if its not null, check that it's a class type.
		if (nullAssign != null) {
			Type typerino = symTable.lookup(nullAssign.IDENTIFIER().getText()).getDecl().type;
			//if its not a class type, error.
			if (typerino == Type.INT ||typerino == Type.BOOLEAN ) {
			ctx.myType = Type.ERROR;
			print.err(String.format("Attempting to assign null to %s. Null can only be assigned to class types.", typerino),ctx);
			return;

			} else {
				//it's not null and it's a class type, so we're set.
				ctx.myType = typerino;
				return;
			}
		} else if (equalityTest != null) {
			if (Type.getTypeForName(equalityTest.e1.myType.name) == null) {
				ctx.myType = Type.ERROR;
				print.err(String.format("Cannot compare type %s to null", equalityTest.e1.myType),ctx);
				return;
			} else {
				ctx.myType = Type.getTypeForName(equalityTest.e1.myType.name);
				return;
			}
			
		}
		
		
			ctx.myType = Type.ERROR;
			print.err("Null failed. Could not find LHS",ctx);

	}
	/*
	Function Name: exitExprCont_ME
	Description: Annoying like new because I had to loop up the tree to get the type and make sure it was
	a user defined class type.
	*/
	@Override
	public void exitExprCont_ME(ExprCont_MEContext ctx) {
		Assignment_stmtContext meAssign = null;
		Call_stmtContext meCall = null;

		ParserRuleContext foo = ctx;
		while (foo != null) {
			if (foo.getParent() instanceof Assignment_stmtContext) {
				meAssign = (Assignment_stmtContext)foo.getParent();
				break;
			} else if (foo.getParent() instanceof Call_stmtContext) {
				meCall = (Call_stmtContext)foo.getParent();
				break;
			}
			
			foo = foo.getParent();
		}
		
		//type for assignment statements
		if (meAssign != null) {
			if (symTable.lookup(meAssign.IDENTIFIER().getText()) != null) {
			ctx.myType = symTable.lookup(meAssign.IDENTIFIER().getText()).getDecl().type;
			return;
			}
			//me type for call stmts
		} else if (meCall != null) {
			if (meCall.t1.myType != null) {
				ctx.myType = meCall.t1.myType;
				return;
			} else {
				ctx.myType = Type.ERROR;
				
				print.err("Call stmt obj expression type is null.",ctx);
				return;
			}
		}
		//if I make it here, then I never found the LHS type.
		ctx.myType = Type.ERROR;
		
		print.err("Me failed. No valid type found.",ctx);
		super.exitExprCont_ME(ctx);
	}

	/*
	Function Name: exitExprCont_Strlit
	Description: Just passes up the string type for the functions that need it up the tree.
	*/
	@Override
	public void exitExprCont_Strlit(ExprCont_StrlitContext ctx) {
		ctx.myType = Type.STRING;
		super.enterExprCont_Strlit(ctx);
	}
	
	/*
	Function Name: exitCall_stmt
	Description: Decorates the tree with the class name and symbol to be used in CodeGen. Checks that the function
	is either in a class declaration or currently in the symbol table.
	*/
	@Override
	public void exitCall_stmt(Call_stmtContext ctx) {

		//class name for codegen
		ctx.className = currentClass;
		List<VarDeclaration> info = new ArrayList<VarDeclaration>();
		int paramNum = 0;
		//setting the parameter number if there are any
		if (ctx.expression_list() != null) {
			paramNum = ctx.expression_list().expression().size();
		}
		//checking an object or type exists. If so, then it's a blank.function() kind of call.
		//If the type is the same as the current class name, then I need to look in the symbol table for the function definition.
		if (ctx.t1 != null && !(symTable.lookup(ctx.t1.getText()).getDecl().type.getClassDecl().name.equals(currentClass))) {
			Symbol foo = symTable.lookup(ctx.t1.getText());
			ctx.sym = foo;
			if (foo == null) {
				print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
						ctx.IDENTIFIER().getText()),ctx);
				return;
			}
				
				//checking inside of the class declaration to make sure the parameter number is correct
				//and that each parameter type matches
				if (foo.getDecl().type.getClassDecl().methods.containsKey(ctx.IDENTIFIER().getText())) {
					MethodDeclaration meth = foo.getDecl().type.getClassDecl().methods.get(ctx.IDENTIFIER().getText());
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
		

		if (symTable.lookup(ctx.IDENTIFIER().getText()) == null) {
			print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
					ctx.IDENTIFIER().getText()),ctx);

			return;
		} 
		
		
		//If I make it this far, then it's just a function call, with: functionCall()
		//I do the same type and parameter number checks.
		MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER().getText()).getDecl();
		info = mDecl.getParameters();
		if (symTable.lookup(ctx.IDENTIFIER().getText()) != null) {
			
			if (info.size() == paramNum) {
				for (int i = 0; i < info.size(); i++) {
					if (info.get(i).type == null) {
						VarDeclaration moo = info.get(i);
						moo.type = symTable.lookup(info.get(i).name).getDecl().type;
						info.set(i, moo);
					}
					if ( info.get(i).type == ctx.expression_list().expression().get(i).myType) {
					}
					else {
						print.err(String.format(print.errMsgs.get("ParameterMismatch"), 
								info.get(i).type.toString(), 
								ctx.expression_list().expression().get(i).myType.toString()),ctx);
						return;
					}
				}
				if (ctx.t1 != null) {
				ctx.sym = symTable.lookup(ctx.t1.getText());
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
	
	
	/*
	Function Name: exitExprCont_IDExpr
	Description: Expression call statement check is done here. Same checks as done up above on the
	call_stmt function. I have to check if it's just a regular function call, or if theres an obj/type associated with it.
	*/
	@Override
	public void exitExprCont_IDExpr(ExprCont_IDExprContext ctx) {
		int paramNum = 0;
		
		
		if (ctx.expression_list() != null) {
			paramNum = ctx.expression_list().expression().size();
		}
		
		List<VarDeclaration> info = new ArrayList<VarDeclaration>();
		MethodDeclaration mDecl = null;
		//if we are dealing with obj.function() then we need to do that here
		if (ctx.getParent() instanceof MethodDot_ExpContext) {
			MethodDot_ExpContext objCheck = (MethodDot_ExpContext)ctx.getParent();

			Type objType = objCheck.e1.myType;
		
			
			//checkikng if error so I don't propogate anymore error msgs
			if (objType == Type.ERROR) {
				ctx.myType = Type.ERROR;
				return;
			}
			//if it's null, then we have an issue. error an dleave.
			if (objType == null){
				print.err(String.format("The type of object %s is null.", objCheck.e1.getText()),ctx);
				ctx.myType = Type.ERROR;
				return;
			}
			//CHECKING if this function is in the current class, if so, then we look in symbol table
			if (objType.getClassDecl().name.equals(currentClass) && symTable.lookup(ctx.IDENTIFIER().getText()) != null) {
				mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER().getText()).getDecl();
				ctx.myType = mDecl.type;
			}
			//checking if function is in its type.classdecl
			else if (objType != null) {
				MethodDeclaration test = objType.getClassDecl().methods.get(ctx.IDENTIFIER().getText());
				if (test == null) {
					print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
							ctx.IDENTIFIER().getText()),ctx);
						ctx.myType = Type.ERROR;
				} else {
					mDecl = test;
					 ctx.myType = mDecl.type;
					
				}
				
				
				//if it's not null, then check if the method we'r elooking for exists in the class. if it does,
				//then put set mDecl to the method in the class
			}
		} else if (symTable.lookup(ctx.IDENTIFIER().getText()) == null) {
				print.err(String.format(print.errMsgs.get("UndefinedFunction"), 
					ctx.IDENTIFIER().getText()),ctx);
				ctx.myType = Type.ERROR;
				return;
		} else if (symTable.lookup(ctx.IDENTIFIER().getText()) != null) {
			ctx.classType = Type.getTypeForName(currentClass);
			 mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER().getText()).getDecl();
			 ctx.myType = mDecl.type;
			 
		}
	
			info = mDecl.getParameters();
			if (info.size() == paramNum) {
				for (int i = 0; i < info.size(); i++) {
					/*
					 * 
					 * recursion case
					 * If I don't do this, then I wont have the types during a recursion call. 
					 */
					if (info.get(i).type == null) {
						VarDeclaration moo = info.get(i);
						moo.type = symTable.lookup(info.get(i).name).getDecl().type;
						info.set(i, moo);
					}
					if ( info.get(i).type == ctx.expression_list().expression().get(i).myType) {
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
			
		super.exitExprCont_IDExpr(ctx);
	}

	/*
	Function Name: exitExprCont_Intlit
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitExprCont_Intlit(ExprCont_IntlitContext ctx) {
		ctx.myType = Type.INT;
		super.enterExprCont_Intlit(ctx);
	}
	
	
	/*
	Function Name: exitExprCont_True
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitExprCont_True(ExprCont_TrueContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_True(ctx);
	}
	/*
	Function Name: exitExprCont_False
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitExprCont_False(ExprCont_FalseContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_False(ctx);
	}
	
	/*
	Function Name: exitExprCont_ID
	Description: Passing the type up the tree. Need to look up in the symbol table first, of course.
	*/
	@Override
	public void exitExprCont_ID(ExprCont_IDContext ctx) {
		
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
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

	/*
	Function Name: exitTypeInt
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitTypeInt(TypeIntContext ctx) {
		ctx.myType = Type.INT;
	}
	
	/*
	Function Name: exitTypeString
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitTypeString(TypeStringContext ctx) {
		ctx.myType = Type.STRING;
		super.enterTypeString(ctx);
	}
	/*
	Function Name: exitTypeBool
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitTypeBool(TypeBoolContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.enterTypeBool(ctx);
	}
	
	/*
	Function Name: exitTypeID
	Description: Passing the type up the tree.
	*/
	@Override
	public void exitTypeID(TypeIDContext ctx) {
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			ctx.myType = sym.getDecl().type;
		}
		else {
			print.err(String.format(print.errMsgs.get("UndefinedVar"), 
					ctx.IDENTIFIER().getText()),ctx);
			ctx.myType = Type.ERROR;
		}
		super.exitTypeID(ctx);
	}

	/*
	Function Name: exitArgument_decl
	Description: Checking the parameter type the user is passing in. 
	*/
	@Override
	public void exitArgument_decl(Argument_declContext ctx) {
		if (doesTypeExist(ctx.type().myType)) {
		}
		else {
			print.err(String.format("Type %s does not exist", ctx.type().myType), ctx);
		}
		super.exitArgument_decl(ctx);
	}

	/*
	Function Name: exitArgument_decl_list
	Description: Parameter types get set here. They're also pushed into the symbol table.
	*/
	@Override
	public void exitArgument_decl_list(Argument_decl_listContext ctx) {
		int offset = 12;
		for (int i = 0; i < ctx.argument_decl().size(); i++) {
			VarDeclaration foo = new VarDeclaration(ctx.argument_decl(i).type().myType,ctx.argument_decl(i).IDENTIFIER().getText());
			foo.setOffset(offset);
			offset += 4;
			symTable.push(ctx.argument_decl(i).IDENTIFIER().getText(), foo);
			
		}
		
		super.exitArgument_decl_list(ctx);
	}
	
	
	/*
	Function Name: exitMethod_decl
	Description: Decorating this node with the class name for use in code gen. Adding the parameters to the 
	method and ending the scope to clean the locals off the symbol table.
	*/
	@Override
	public void exitMethod_decl(Method_declContext ctx) {
		ctx.className = currentClass;
		MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
		if (ctx.argument_decl_list() != null) {
			mDecl.clearParameters();
			for (int i = 0; i < ctx.argument_decl_list().argument_decl().size(); i++) {
				mDecl.appendParameter(ctx.argument_decl_list().argument_decl(i).type().myType,ctx.argument_decl_list().argument_decl(i).IDENTIFIER().getText());
			}
		}
		ctx.params = ctx.var_decl().size();
		
	
		symTable.endScope();
		super.exitMethod_decl(ctx);
	}

	/*
	Function Name: enterMethod_decl
	Description: Checking the type of the function so it can be pushed correctly onto the stack. Set the local offset
	to -8 so that it isn't giving offsets based on the last method declaration.
	*/
	@Override
	public void enterMethod_decl(Method_declContext ctx) {
		List<Type> types = Arrays.asList(Type.INT, Type.BOOLEAN, Type.STRING, Type.VOID);
		Type t = Type.VOID;
		
		for (Type i : types ) {
			if (ctx.typ != null && i.name.equals(ctx.typ.getText())) {
				t = i;
			}
		}
		//user defined types check
		if (t == Type.VOID && ctx.typ != null &&  Type.getTypeForName(ctx.typ.getText()) != null) {
			t = Type.getTypeForName(ctx.typ.getText());
		}

		symTable.push(ctx.IDENTIFIER(0).getText(), new MethodDeclaration(t));
		MethodDeclaration mDecl = (MethodDeclaration) symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
		//giving offsets to all parameters. (POSITIVE)
		if (ctx.argument_decl_list() != null) {
			for (int i = 0; i < ctx.argument_decl_list().argument_decl().size(); i++) {
				mDecl.appendParameter(ctx.argument_decl_list().argument_decl(i).type().myType,ctx.argument_decl_list().argument_decl(i).IDENTIFIER().getText());
			}
		}
		symTable.beginScope();
		//setting local offset to -8 because the function is beginning
		symTable.setLocalOffset(-8);
		super.enterMethod_decl(ctx);
	}

	/*
	Function Name: enterClass_
	Description:Need to push in the "in" and "out" variables as soon as the class shows up
	so that there are no issues with calling those functions. Setting th einstance variable offset to 8 so we don't
	give offsets based on the last class.
	*/
	@Override
	public void enterClass_(Class_Context ctx) {
		//instance variable offset set to 8;
		instanceVarOffset = 8;
		//keeping track of current class
		currentClass = ctx.IDENTIFIER(0).getText();
		//Create a new type for the class
		ClassDeclaration myClass = new ClassDeclaration(ctx.IDENTIFIER(0).getText());
		Type classType = Type.createType(myClass);
		myClass.type = classType;
		if (currentClass.equals("Reader")) {
			symTable.push("in", new VarDeclaration(classType, "in"));

		}
		if (currentClass.equals("Writer")) {
			symTable.push("out", new VarDeclaration(classType, "out"));
		}
		//Add the class name as a symbol in the current scope
		symTable.push(ctx.IDENTIFIER(0).getText(), myClass);
		//SymbolTable.BeginScope( )
		symTable.beginScope();
		super.enterClass_(ctx);
	}

	/*
	Function Name: exitClass_
	Description:Ending the scope to clear off all the methods/instance parameters, because we're done processing the class.
	*/
	@Override
	public void exitClass_(Class_Context ctx) {
		//Perform semantic processing on instance variable and method declarations (these symbols go in the new scope)
		if (ctx.INHERITS() != null) {
			print.err(String.format(print.errMsgs.get("Unsupported"), 
					"Inheritance"),ctx);
		}
		
		ClassDeclaration myClass = (ClassDeclaration)symTable.lookup(ctx.IDENTIFIER(0).getText()).getDecl();
		//METHODS
		for (FloydParser.Method_declContext func : ctx.method_decl()) {
			MethodDeclaration  classMethod = (MethodDeclaration)symTable.lookup(func.IDENTIFIER(0).getText()).getDecl();
			if (myClass != null) {
			myClass.appendMethod(func.IDENTIFIER(0).getText(), classMethod);
			}
			else {
				print.err("Class doesn't seem to be in the symbol table",ctx);
			}
		}
		
		//SymbolTable.EndScope( ) to remove the instance variable and method declarations from the symbol table
		symTable.endScope();
		//instanceVarOffset set to 8
		instanceVarOffset = 8;
		//Update the class declaration info in the symbol table
		
		super.exitClass_(ctx);
	}
	/*
	Function Name: exitMethodDot_Exp
	Description:If there's a variable on the LHS of the dot, then the symbol gets passed along. Otherwise just the function type.
	
	*/
	@Override
	public void exitMethodDot_Exp(MethodDot_ExpContext ctx) {
		
		Symbol sym = symTable.lookup(ctx.e1.getText());
		if (sym != null) {
			ctx.sym = sym;
		}

		ctx.myType = ctx.e2.myType;
		
		super.exitMethodDot_Exp(ctx);
	}
		
}
