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
        "org.junit.jupiter:junit-jupiter:5.11.0",
        "org.junit.jupiter:junit-jupiter-api:5.11.0",
        "org.junit.jupiter:junit-jupiter-engine:5.11.0",
        "org.junit.jupiter:junit-jupiter-migrationsupport:5.11.0",
        "org.junit.jupiter:junit-jupiter-params:5.11.0",
        "org.junit.platform:junit-platform-commons:1.11.0",
        "org.junit.platform:junit-platform-console:1.11.0",
        "org.junit.platform:junit-platform-engine:1.11.0",
        "org.junit.platform:junit-platform-jfr:1.11.0",
        "org.junit.platform:junit-platform-launcher:1.11.0",
        "org.junit.platform:junit-platform-reporting:1.11.0",
        "org.junit.platform:junit-platform-runner:1.11.0",
        "org.junit.platform:junit-platform-suite:1.11.0",
        "org.junit.platform:junit-platform-suite-api:1.11.0",
        "org.junit.platform:junit-platform-suite-commons:1.11.0",
        "org.junit.platform:junit-platform-suite-engine:1.11.0",
        "org.junit.platform:junit-platform-testkit:1.11.0",
        "org.junit.vintage:junit-vintage-engine:5.11.0",
        "org.hamcrest:hamcrest:2.2",
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
    sha256 = "41131de4417de70b9597e6ebd515168ed0ba843a325dc54a81b92d7af9a7b3ea",
    urls = ["https://github.com/bazelbuild/rules_java/releases/download/7.9.0/rules_java-7.9.0.tar.gz"],
)

load("@rules_java//java:repositories.bzl", "rules_java_dependencies")

rules_java_dependencies()

# # java toolchain setup
load("//tools/java:repositories.bzl", "remote_java_repositories")

remote_java_repositories()

# contrib_rules_jvm

http_archive(
    name = "contrib_rules_jvm",
    sha256 = "e6cd8f54b7491fb3caea1e78c2c740b88c73c7a43150ec8a826ae347cc332fc7",
    strip_prefix = "rules_jvm-0.27.0",
    url = "https://github.com/bazel-contrib/rules_jvm/releases/download/v0.27.0/rules_jvm-v0.27.0.tar.gz",
)

load("@contrib_rules_jvm//:repositories.bzl", "contrib_rules_jvm_deps")

contrib_rules_jvm_deps()

load("@contrib_rules_jvm//:setup.bzl", "contrib_rules_jvm_setup")

contrib_rules_jvm_setup()

# with_cfg.bzl
http_archive(
    name = "with_cfg.bzl",
    sha256 = "6a3fd69a532ed2e592a5f0f1b5b88b574c34f1f01d54976745d5065129858287",
    strip_prefix = "with_cfg.bzl-0.4.2",
    url = "https://github.com/fmeum/with_cfg.bzl/releases/download/v0.4.2/with_cfg.bzl-v0.4.2.tar.gz",
)
