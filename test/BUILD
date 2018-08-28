cc_test(
    name = "hello-test",
    srcs = ["hello-test.cc", "dpdk-test.cc"],
    copts = ["-Iexternal/gtest/include",
             "-Iexternal/openssl/include",
             "-Iexternal/dpdk/include/dpdk",
             ],
    deps = [
        "@gtest//:gtest",
        "@openssl//:ssl",
        "@dpdk//:libs",
        "@libelf//:libelf",
    ],
)
