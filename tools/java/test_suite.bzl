load("@contrib_rules_jvm//java:defs.bzl", "create_jvm_test_suite", "java_junit5_test", "java_test")
load("@rules_java//java:defs.bzl", "java_library")

DEFAULT_JAVA_VERSION = 21

def java_test_suite(
        name,
        srcs = ["src/test/java/**/*.java"],
        deps = [],
        resources = ["src/test/resources/**/*"],
        data = ["src/main/resources/**/*", "src/test/resources/**/*"],
        runner = "junit5",
        test_runners = {},
        test_suffixes = ["Test.java"],
        plugins = [],
        tags = []):
    srcs = _maybe_glob(srcs)

    if not srcs:
        # no test sources found, nothing to do here
        return

    if not test_runners:
        if runner == "junit5":
            test_runners = {"": java_junit5_test}
        else:
            test_runners = {"": java_test}

    def _define_library(name, **kwargs):
        java_library(
            name = name,
            **kwargs
        )

    for name_suffix, define_test_fn in test_runners.items():
        # create_jvm_test_suite expects the function passed in the 'define_test'
        # attr to return the name of the target
        def wrapped_test_fn(name, **kwargs):
            define_test_fn(name = name, **kwargs)
            return name

        create_jvm_test_suite(
            name = name + "-" + name_suffix,
            srcs = _maybe_glob(srcs),
            data = _maybe_glob(data),
            plugins = plugins,
            resources = native.glob(resources),
            runner = runner,
            package = None,  # set to None to have rule infer package name
            define_library = _define_library,
            define_test = wrapped_test_fn,
            test_suffixes = test_suffixes,
            # java_test_suite modifies this list, so make a copy here
            deps = [dep for dep in deps],
            jvm_flags = ["-Dsun.net.maxDatagramSockets=1024"],
            tags = tags,
            # this is a custom patch we made to contrib-rules-jvm to allow
            # defining a test from a certain file more than once, as otherwise
            # the target name is based on the test's filename
            test_name_suffix = "-" + name_suffix,
        )

# handle the case where some list may be a mix of file globs and target labels
def _maybe_glob(inputs):
    out = []

    for input in inputs:
        if "*" in input:
            out += native.glob([input])
        else:
            out.append(input)
    return out
