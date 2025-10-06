load("@contrib_rules_jvm//java:defs.bzl", "create_jvm_test_suite", "java_junit5_test", "java_test")
load("@rules_java//java:defs.bzl", "java_library")

DEFAULT_JAVA_VERSION = 21

def java_test_suite(
        name,
        srcs = ["src/test/java/**/*.java"],
        deps = [],
        test_runners = {},
        test_suffixes = ["Test.java"],
        plugins = [],
        tags = []):
    srcs = native.glob(srcs)

    if not srcs:
        # no test sources found, nothing to do here
        return

    if not test_runners:
        test_runners = {"": java_junit5_test}

    def _define_library(name, **kwargs):
        java_library(
            name = name,
            **kwargs
        )

    # call create_jvm_test_suite once per test runner, to allow for e.g.
    # defining/running test targets on different JDK versions
    for name_suffix, define_test_fn in test_runners.items():
        # create_jvm_test_suite expects the function passed in the 'define_test'
        # attr to return the name of the target

        # normally the define_test_fn would be passed to create_jvm_test_suite
        # directly, but we want to customize the logic: when we are creating
        # more than 1 test suite, we need to customize the name of each
        # individual test target to avoid reusing the same target names (which
        # will cause a Bazel error).
        #
        # Being able to customize the 'define_test' function is the entire
        # reason why we call create_jvm_test_suite() here, rather than
        # java_test_suite().
        def wrapped_test_fn(name, **kwargs):
            test_name = name if name_suffix == "" else name + "-" + name_suffix
            define_test_fn(name = test_name, **kwargs)
            return test_name

        create_jvm_test_suite(
            name = name if name_suffix == "" else name + "-" + name_suffix,
            srcs = srcs,
            plugins = plugins,
            package = None,  # set to None to have rule infer package name
            define_library = _define_library,
            define_test = wrapped_test_fn,
            test_suffixes = test_suffixes,
            # java_test_suite modifies this list, so make a copy here
            deps = [dep for dep in deps],
            jvm_flags = ["-Dsun.net.maxDatagramSockets=1024"],
            tags = tags,
        )
