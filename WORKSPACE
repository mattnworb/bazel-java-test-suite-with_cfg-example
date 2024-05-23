load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_jvm_external

RULES_JVM_EXTERNAL_TAG = "6.0"

http_archive(
    name = "rules_jvm_external",
    sha256 = "85fd6bad58ac76cc3a27c8e051e4255ff9ccd8c92ba879670d195622e7c0a9b7",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    url = "https://github.com/bazelbuild/rules_jvm_external/releases/download/%s/rules_jvm_external-%s.tar.gz" % (RULES_JVM_EXTERNAL_TAG, RULES_JVM_EXTERNAL_TAG),
)

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "org.junit.jupiter:junit-jupiter:jar:5.10.2",
        "org.junit.jupiter:junit-jupiter-api:jar:5.10.2",
        "org.junit.jupiter:junit-jupiter-engine:jar:5.10.2",
        "org.junit.jupiter:junit-jupiter-migrationsupport:jar:5.10.2",
        "org.junit.jupiter:junit-jupiter-params:jar:5.10.2",
        "org.junit.platform:junit-platform-commons:jar:1.10.2",
        "org.junit.platform:junit-platform-console:jar:1.10.2",
        "org.junit.platform:junit-platform-engine:jar:1.10.2",
        "org.junit.platform:junit-platform-jfr:jar:1.10.2",
        "org.junit.platform:junit-platform-launcher:jar:1.10.2",
        "org.junit.platform:junit-platform-reporting:jar:1.10.2",
        "org.junit.platform:junit-platform-runner:jar:1.10.2",
        "org.junit.platform:junit-platform-suite:jar:1.10.2",
        "org.junit.platform:junit-platform-suite-api:jar:1.10.2",
        "org.junit.platform:junit-platform-suite-commons:jar:1.10.2",
        "org.junit.platform:junit-platform-suite-engine:jar:1.10.2",
        "org.junit.platform:junit-platform-testkit:jar:1.10.2",
        "org.junit.vintage:junit-vintage-engine:jar:5.10.2",
        "org.hamcrest:hamcrest:jar:2.2",
    ],
    duplicate_version_warning = "error",
    fail_if_repin_required = True,
    fetch_sources = True,
    maven_install_json = "//:maven_install.json",
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
    # maven_install_json = "@//:maven_install.json",
    version_conflict_policy = "pinned",
)

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

# rules_java
http_archive(
    name = "rules_java",
    sha256 = "f8ae9ed3887df02f40de9f4f7ac3873e6dd7a471f9cddf63952538b94b59aeb3",
    urls = ["https://github.com/bazelbuild/rules_java/releases/download/7.6.1/rules_java-7.6.1.tar.gz"],
)

load("@rules_java//java:repositories.bzl", "rules_java_dependencies")

rules_java_dependencies()

# # java toolchain setup
load("//tools/java:repositories.bzl", "remote_java_repositories")

remote_java_repositories()

# contrib_rules_jvm

http_archive(
    name = "contrib_rules_jvm",
    sha256 = "2412e22bc1eb9d3a5eae15180f304140f1aad3f8184dbd99c845fafde0964559",
    strip_prefix = "rules_jvm-0.24.0",
    url = "https://github.com/bazel-contrib/rules_jvm/releases/download/v0.24.0/rules_jvm-v0.24.0.tar.gz",
)

load("@contrib_rules_jvm//:repositories.bzl", "contrib_rules_jvm_deps")

contrib_rules_jvm_deps()

load("@contrib_rules_jvm//:setup.bzl", "contrib_rules_jvm_setup")

contrib_rules_jvm_setup()

# with_cfg.bzl
http_archive(
    name = "with_cfg.bzl",
    sha256 = "06a2b1b56a58c471ab40d8af166c4d51f0982e1c6bc46375b805915b3fc0658e",
    strip_prefix = "with_cfg.bzl-0.2.4",
    url = "https://github.com/fmeum/with_cfg.bzl/releases/download/v0.2.4/with_cfg.bzl-v0.2.4.tar.gz",
)
