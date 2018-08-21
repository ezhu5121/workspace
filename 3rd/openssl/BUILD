_hdrs = [
"include/openssl/ssl2.h"
,"include/openssl/kssl.h"
,"include/openssl/mdc2.h"
,"include/openssl/pkcs7.h"
,"include/openssl/hmac.h"
,"include/openssl/whrlpool.h"
,"include/openssl/err.h"
,"include/openssl/cast.h"
,"include/openssl/ocsp.h"
,"include/openssl/ui.h"
,"include/openssl/lhash.h"
,"include/openssl/pkcs12.h"
,"include/openssl/asn1.h"
,"include/openssl/srtp.h"
,"include/openssl/rsa.h"
,"include/openssl/evp.h"
,"include/openssl/dh.h"
,"include/openssl/x509.h"
,"include/openssl/cmac.h"
,"include/openssl/dtls1.h"
,"include/openssl/ecdsa.h"
,"include/openssl/srp.h"
,"include/openssl/ssl3.h"
,"include/openssl/ssl23.h"
,"include/openssl/tls1.h"
,"include/openssl/des_old.h"
,"include/openssl/opensslv.h"
,"include/openssl/sha.h"
,"include/openssl/ebcdic.h"
,"include/openssl/idea.h"
,"include/openssl/bio.h"
,"include/openssl/rand.h"
,"include/openssl/pem2.h"
,"include/openssl/safestack.h"
,"include/openssl/pqueue.h"
,"include/openssl/e_os2.h"
,"include/openssl/ossl_typ.h"
,"include/openssl/krb5_asn.h"
,"include/openssl/cms.h"
,"include/openssl/crypto.h"
,"include/openssl/des.h"
,"include/openssl/buffer.h"
,"include/openssl/objects.h"
,"include/openssl/blowfish.h"
,"include/openssl/ec.h"
,"include/openssl/conf.h"
,"include/openssl/obj_mac.h"
,"include/openssl/x509_vfy.h"
,"include/openssl/md5.h"
,"include/openssl/ripemd.h"
,"include/openssl/aes.h"
,"include/openssl/symhacks.h"
,"include/openssl/pem.h"
,"include/openssl/bn.h"
,"include/openssl/ts.h"
,"include/openssl/comp.h"
,"include/openssl/x509v3.h"
,"include/openssl/txt_db.h"
,"include/openssl/dsa.h"
,"include/openssl/stack.h"
,"include/openssl/ssl.h"
,"include/openssl/dso.h"
,"include/openssl/md4.h"
,"include/openssl/seed.h"
,"include/openssl/modes.h"
,"include/openssl/conf_api.h"
,"include/openssl/ui_compat.h"
,"include/openssl/ecdh.h"
,"include/openssl/asn1t.h"
,"include/openssl/engine.h"
,"include/openssl/asn1_mac.h"
]
filegroup(
    name = "gen_hdrs",
    srcs = _hdrs,
)
cc_library(
    name = "crypto",
    hdrs = [":gen_hdrs",
            "include/openssl/opensslconf.h"],
    srcs = ["libcrypto.a"],
    includes = ["include"],
    linkopts = ["-lpthread", "-ldl"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "ssl",
    deps = [":crypto"],
    hdrs = [":gen_hdrs",
            "include/openssl/opensslconf.h"],
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
    srcs = ["Configure"],
    outs = [
        "libcrypto.a",
        "libssl.a",
        "openssl",
        "include/openssl/opensslconf.h",
    ] + _hdrs,
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

        cp  -v $$OPENSSL_ROOT/tmp/lib/libcrypto.a $(location libcrypto.a) &&
        cp  -v $$OPENSSL_ROOT/tmp/lib/libssl.a $(location libssl.a) &&
        cp -r $$OPENSSL_ROOT/tmp/include/openssl/*  \
            $$(dirname $(location include/openssl/opensslconf.h))
        cp -v $$OPENSSL_ROOT/tmp/bin/openssl $(location openssl)
    """,
)
