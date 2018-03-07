package cps450;
/*
 * http://javarevisited.blogspot.com/2012/06/builder-design-pattern-in-java-example.html
 */
class TargetInstruction {
	   private final String label;
	   private final String instruction;
	   private final String operand1;
	   private final String operand2;
	   private final String comment;
	   private final String directive;
	   
	   public static class Builder {
		   private String label = "";
		   private String instruction = "";
		   private String operand1 = "";
		   private String operand2 = "";
		   private String comment = "";
		   private String directive = "";
		   public Builder label(String x) {this.label = x; return this;}
		   public Builder instruction (String x) {this.instruction = x; return this;}
		   public Builder operand1(String x) {this.operand1 = x; return this;}
		   public Builder operand2(String x) {this.operand2 = x; return this;}
		   public Builder comment(String x) {this.comment = x; return this;}
		   public Builder directive(String x) {this.directive = x; return this;}
		   
		   public TargetInstruction build() {
			   return new TargetInstruction(this);
		   }
	   }
	   
	   private TargetInstruction(Builder builder) {
		   this.label = builder.label;
		   this.instruction = builder.instruction;
		   this.operand1 = builder.operand1;
		   this.operand2 = builder.operand2;
		   this.comment = builder.comment;
		   this.directive = builder.directive;
	   }

	@Override
	public String toString() {
		return String.format("TargetInstruction: Label: %s, Instruction: %s,  Operand1: %s, Operand2: %s, Comment: %s,"
				+ "Directive: %s", this.label, this.instruction, this.operand1, this.operand2, this.comment, this.directive);
	}

	public String getLabel() {
		return label;
	}

	public String getInstruction() {
		return instruction;
	}

	public String getOperand1() {
		return operand1;
	}

	public String getOperand2() {
		return operand2;
	}

	public String getComment() {
		return comment;
	}

	public String getDirective() {
		return directive;
	}
	   
	
	   
	}
