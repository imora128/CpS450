package cps450;

import java.util.ArrayList;
import java.util.List;

public class CodeGen extends FloydBaseVisitor<CodeGen> {
	List<TargetInstruction> instructions = new ArrayList<TargetInstruction>();
	
	void emit(TargetInstruction t) {
		instructions.add(t);
	}
}
