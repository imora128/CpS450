package cps450;

import static org.junit.Assert.*;

import org.junit.Test;

public class TargetInstructionTest {

	@Test
	public void testToString() {
		TargetInstruction foo = new TargetInstruction.Builder().label("test1").build();
		TargetInstruction boo = new TargetInstruction.Builder().label("test1").directive("lel").build();
		assertTrue(foo.getLabel().equals("test1"));
		assertTrue(foo.getDirective().equals(""));
		assertFalse(foo.getOperand1().equals("56"));
	}

}
