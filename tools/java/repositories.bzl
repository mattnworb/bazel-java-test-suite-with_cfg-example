load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/jdk:remote_java_repository.bzl", "remote_java_repository")

def remote_java_repositories():
    """Adds remote_java_repository rules for every Java version / OS / CPU arch combination we support."""

    # note: to easily find the checksums, look at
    # https://github.com/corretto/corretto-17/releases,
    # https://github.com/corretto/corretto-21/releases, etc
    # we want the tar.gz checksums, not .deb or .pkg or .rpm

    for java_version, corretto_version, os, arch, sha256 in [
        ("21", "21.0.3.9.1", "macosx", "aarch64", "db1df7a3fe5d481a2ec52ea3c12b51ba7e9121cdb3dd39e0cf7bc77fba88cd98"),
        ("21", "21.0.3.9.1", "macosx", "x64", "2c6497ced7b926d584243d512b3732a345eb1b5afefd416e6588c33a43c0fa70"),
        ("21", "21.0.3.9.1", "linux", "aarch64", "5a5a1cff3ddfbe55a3c96fd58eda568811564258f5a00777b8b5d75c59e39a94"),
        ("21", "21.0.3.9.1", "linux", "x64", "8b4550c7cbbe3ae8b00adaafe5513d1236eec8183ce28f99698450f4f802c597"),
        ("17", "17.0.11.9.1", "macosx", "aarch64", "e2d4b5e34f4903278c8a8ba0582072a862fc6d6923ec6ce9f90130cf3cf787f8"),
        ("17", "17.0.11.9.1", "macosx", "x64", "b447e0c5e121c3f912c72bc8cdc86569a5d198d86a979b87948ac908fe1c7520"),
        ("17", "17.0.11.9.1", "linux", "aarch64", "f31068d3fbec7d71d4c30b5b71493a7a630d07f1f37f70c6510f84f129cd1f38"),
        ("17", "17.0.11.9.1", "linux", "x64", "7629d3446ebeaf7517a90a4f170d38fc8628725430d2300153b5981872e1223a"),
    ]:
        short_os = "macos" if os == "macosx" else os
        platform_arch = "x86_64" if arch == "x64" else arch

        if os == "linux":
            strip_prefix = "amazon-corretto-%s-%s-%s" % (corretto_version, os, arch)
        else:
            strip_prefix = "amazon-corretto-%s.jdk/Contents/Home" % java_version

        maybe(
            remote_java_repository,
            name = "example_remotejdk_%s_%s_%s" % (java_version, short_os, arch),
            prefix = "example_remotejdk",
            sha256 = sha256,
            strip_prefix = strip_prefix,
            target_compatible_with = [
                "@platforms//os:%s" % short_os,
                "@platforms//cpu:%s" % platform_arch,
            ],
            urls = [
                "https://corretto.aws/downloads/resources/%s/amazon-corretto-%s-%s-%s.tar.gz" % (corretto_version, corretto_version, os, arch),
            ],
            version = java_version,
        )
