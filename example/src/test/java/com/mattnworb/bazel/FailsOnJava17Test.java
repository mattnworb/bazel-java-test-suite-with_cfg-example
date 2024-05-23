package com.mattnworb.bazel;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;
import static org.hamcrest.Matchers.nullValue;
import static org.junit.Assume.assumeThat;

import org.junit.jupiter.api.Test;

public class FailsOnJava17Test {
  @Test
  public void testFailsOn17() {
    assumeThat("Not running purposefully failing test in CI", System.getenv("CI"), is(nullValue()));
    assertThat(System.getProperty("java.specification.version"), not(equalTo("17")));
  }
}
