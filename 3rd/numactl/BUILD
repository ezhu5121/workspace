
_hdrs = ["include/numacompat1.h", "include/numa.h", "include/numaif.h"]
filegroup(
    name = "gen-headers",
    srcs = _hdrs,
)

_libs = ["lib/libnuma.a", "lib/libnuma.so"]
filegroup(
    name = "gen-libs",
    srcs = _libs,
)

cc_library(
    name = "libnuma",
    srcs = [":gen-libs"],
    hdrs = [":gen-headers"],
    includes = ["include"],
    linkstatic = 1,
    visibility = ["//visibility:public"],
)

_bins = ["memhog", "migratepages", "migspeed", "numactl", "numademo", "numastat"]
cc_binary(
    name = "numactl-bin",
    srcs = _bins,
    deps = [":libnuma"],
    visibility = ["//visibility:public"],
)
genrule(
    local = 1,
    name = "numa-build",
    srcs = ["autogen.sh"],
    outs = _hdrs + _libs + _bins,
    cmd = """
        SRCROOT=$$(dirname $$(readlink $(location autogen.sh)))
        DST=$$(dirname $(location lib/libnuma.a))
        TMP=$$SRCROOT/tmp
        pushd $$SRCROOT
        ./autogen.sh
        ./configure --prefix=$$TMP
        make
        make install
        popd
        cp -v $$TMP/lib/libnuma.a $(location lib/libnuma.a)
        cp -v $$TMP/lib/libnuma.so $(location lib/libnuma.so)
        cp -v $$TMP/include/* $$(dirname $(location include/numa.h))
        cp -v $$TMP/bin/* $$(dirname $(location numactl))
"""
)