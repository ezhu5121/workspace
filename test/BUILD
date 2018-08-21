cc_test(
    name = "hello-test",
    srcs = ["hello-test.cc"],
    copts = ["-Iexternal/gtest/include",
             "-Iexternal/openssl/include"],
    linkopts = ["-lssl"],
    deps = [
        "@gtest//:main",
        "@openssl//:ssl",
    ],
)
