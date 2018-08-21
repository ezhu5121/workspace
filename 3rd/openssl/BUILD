cc_library(
    name = "crypto",
    hdrs = glob(["include/openssl/*.h"]), # + ["include/openssl/opensslconf.h"],
    srcs = ["libcrypto.a"],
    includes = ["include"],
    linkopts = ["-lpthread", "-ldl"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "ssl",
    deps = [":crypto"],
    hdrs = glob(["include/openssl/*.h"]), # + ["include/openssl/opensslconf.h"],
    srcs = ["libssl.a"],
    includes = ["include"],
    visibility = ["//visibility:public"],
)
# https://docs.bazel.build/versions/master/be/c-cpp.html#cc_binary
cc_binary(
    name = "openssl-bin",
    srcs = ["openssl"],
    deps = [":ssl"],
    visibility = ["//visibility:public"],
)

genrule(
    local = 1,
    name = "openssl-build",
    srcs = glob(["**/*"], exclude=["bazel-*"]),
    outs = [
        "libcrypto.a",
        "libssl.a",
        "openssl",
        "include/openssl/opensslconf.h",
    ],
    cmd = """
        OPENSSL_ROOT=$$(dirname $$(readlink $(location Configure)))

        OPENSSL_CFG_OPTS="linux-x86_64"
        OPENSSL_CFG_OPTS+=" no-rc2"
        OPENSSL_CFG_OPTS+=" no-rc4"
        OPENSSL_CFG_OPTS+=" no-rc5"
        OPENSSL_CFG_OPTS+=" no-camellia"
        OPENSSL_CFG_OPTS+=" no-capienga"
        OPENSSL_CFG_OPTS+=" no-inline-asm"
        pushd $$OPENSSL_ROOT
            ./Configure $${OPENSSL_CFG_OPTS} --prefix=$$PWD/tmp
        popd
        mkdir -p $$OPENSSL_ROOT/tmp/ssl/
        cp -v $$OPENSSL_ROOT/apps/openssl.cnf $$OPENSSL_ROOT/tmp/ssl/openssl.cnf
        CC=$(CC) make -C $${OPENSSL_ROOT} depend -j1
        CC=$(CC) AR=$(AR) make -C $${OPENSSL_ROOT} -j1
        make -C $${OPENSSL_ROOT} install

        cp  $$OPENSSL_ROOT/tmp/lib/libcrypto.a $(location libcrypto.a) &&
        cp  $$OPENSSL_ROOT/tmp/lib/libssl.a $(location libssl.a) &&
        cp -r $$OPENSSL_ROOT/tmp/include/openssl/*  \
            $$(dirname $(location include/openssl/opensslconf.h))
        cp -v $$OPENSSL_ROOT/tmp/bin/openssl $(location openssl)
    """,
)
