# bazel-java-test-suite-with_cfg-example

An example of using `create_jvm_test_suite` from
<https://github.com/bazel-contrib/rules_jvm> along with
<https://github.com/fmeum/with_cfg.bzl> to define a macro that creates Java test
suites which can run tests on multiple versions of JDK, without having to define
individual test targets for each test.

## Demo

`example/src/test/java` has two Java source files containing JUnit tests:

```
❯ tree example/src/test/java/
example/src/test/java/
└── com
    └── mattnworb
        └── bazel
            ├── FailsOnJava17Test.java
            └── VersionTest.java
```

but Bazel sees variants of these two tests for running on jdk17 and jdk21:

```
❯ bazel query //example/... | grep -v _
...
//example:lib
//example:src/test/java/com/mattnworb/bazel/FailsOnJava17Test-jdk17
//example:src/test/java/com/mattnworb/bazel/FailsOnJava17Test-jdk21
//example:src/test/java/com/mattnworb/bazel/VersionTest-jdk17
//example:src/test/java/com/mattnworb/bazel/VersionTest-jdk21
//example:test-suite-jdk17
//example:test-suite-jdk21
```

in [example/BUILD.bazel](example/BUILD.bazel) we define the tests with a
`java_test_suite` macro which lives in [tools/java/test_suite.bzl](tools/java/test_suite.bzl):

```bazel
java_test_suite(
    name = "test-suite",
    test_runners = {
        "jdk21": java_21_junit5_test,
        "jdk17": java_17_junit5_test,
    },
    deps = JUNIT5_DEPS + [
        "lib",
        "@maven//:org_hamcrest_hamcrest",
        "@maven//:org_junit_jupiter_junit_jupiter_api",
    ],
)
```

this macro calls `create_jvm_test_suite` from `contrib-rules-jvm` once per entry
in the `test_runners` attr, which allows for passing a custom `java_test`-like
rule to define the test target to wrap the `*Test.java` file in via its
`define_test` attr.

Normally `create_jvm_test_suite` would define the test with a name that is set
based on the name and path of `*Test.java` file, but for this demo, we want to
define multiple test variants for the same `*Test.java` file, so we apply a
patch to `create_jvm_test_suite` in
[tools/java/contrib_rules_jvm_create_jvm_test_suite.patch](tools/java/contrib_rules_jvm_create_jvm_test_suite.patch)
which allows us to apply a suffix to the `name` attribute.

### Running the demo

Note that the `FailsOnJava17Test.java` is intentionally set up to fail when run on version of the JDK, to demonstrate that the toolchain selection is working as we want:

```
❯ bazel test //example/... -t-
...
//example:src/test/java/com/mattnworb/bazel/FailsOnJava17Test-jdk21      PASSED in 0.5s
//example:src/test/java/com/mattnworb/bazel/VersionTest-jdk17            PASSED in 0.4s
//example:src/test/java/com/mattnworb/bazel/VersionTest-jdk21            PASSED in 0.5s
//example:src/test/java/com/mattnworb/bazel/FailsOnJava17Test-jdk17      FAILED in 0.5s
```

Running just the `VersionTest`, which prints out the `java.specification.version` and `java.home` properties shows different values for each JDK toolchain the test is run on:

```
❯ bazel test -t- --test_output=streamed \
  //example:src/test/java/com/mattnworb/bazel/VersionTest-jdk17 \
  //example:src/test/java/com/mattnworb/bazel/VersionTest-jdk21 \
...
java.specification.version: 21
java.vm.vendor: Amazon.com Inc.
java.home: /private/var/tmp/_bazel_mattbrown/54a55802995faae513241d7180d2e906/external/example_remotejdk_21_macos_aarch64
Failures: 0
java.specification.version: 17
java.vm.vendor: Amazon.com Inc.
java.home: /private/var/tmp/_bazel_mattbrown/54a55802995faae513241d7180d2e906/external/example_remotejdk_17_macos_aarch64
Failures: 0
INFO: Found 2 test targets...
INFO: Elapsed time: 0.779s, Critical Path: 0.32s
INFO: 3 processes: 1 internal, 2 darwin-sandbox.
INFO: Build completed successfully, 3 total actions
//example:src/test/java/com/mattnworb/bazel/VersionTest-jdk17            PASSED in 0.3s
//example:src/test/java/com/mattnworb/bazel/VersionTest-jdk21            PASSED in 0.3s
```