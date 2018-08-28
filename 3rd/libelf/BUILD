
_hdrs = [
"include/gelf.h",
"include/nlist.h",
"include/libelf/gelf.h",
"include/libelf/nlist.h",
"include/libelf/sys_elf.h",
"include/libelf/elf_repl.h",
"include/libelf/libelf.h",
"include/libelf.h",
]
filegroup(
    name = "gen-headers",
    srcs = _hdrs,
)
_libs = ["lib/libelf.a", "lib/libelf.so", "lib/libelf.so.0", "lib/libelf.so.0.8.13"]
filegroup(
    name = "gen-libs",
    srcs = _libs,
)

cc_library(
    name = "libelf",
    srcs = [":gen-libs"],
    hdrs = [":gen-headers"],
    includes = ["include"],
    linkstatic = 1,
    visibility = ["//visibility:public"],
)

genrule(
    local = 1,
    name = "libelf-build",
    srcs = ["configure"],
    outs = _hdrs + _libs,
    cmd = """
        SRCROOT=$$(dirname $$(readlink $(location configure)))
        LIBDST=$$(dirname $(location lib/libelf.a))
        INCDST=$$(dirname $(location include/libelf.h))
        TMP=$$SRCROOT/tmp
        pushd $$SRCROOT
        ./configure --prefix=$$TMP
        make
        make install
        popd
        cp -v $$TMP/lib/libelf.a $(location lib/libelf.a)
        cp -v -P $$TMP/lib/libelf.so $(location lib/libelf.so)
        cp -v -P $$TMP/lib/libelf.so.* $$(dirname $(location lib/libelf.so))
        cp -vr $$TMP/include/* $$(dirname $(location include/libelf.h))
"""
)