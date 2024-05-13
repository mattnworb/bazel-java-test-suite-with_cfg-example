package com.mattnworb.bazel;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.not;

import org.junit.jupiter.api.Test;

public class FailsOnJava17Test {
  @Test
  public void testFailsOn17() {
    assertThat(System.getProperty("java.specification.version"), not(equalTo("17")));
  }
}
