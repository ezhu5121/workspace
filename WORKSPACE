
new_http_archive(
    name = "gtest",
    url = "https://github.com/google/googletest/archive/release-1.7.0.zip",
    sha256 = "b58cb7547a28b2c718d1e38aee18a3659c9e3ff52440297e965f5edffe34b6d0",
    build_file = "3rd/gtest/BUILD",
    strip_prefix = "googletest-release-1.7.0",
)
new_http_archive(
    name = "openssl",
    url = "https://www.openssl.org/source/openssl-1.0.2p.tar.gz",
    sha256 = "50a98e07b1a89eb8f6a99477f262df71c6fa7bef77df4dc83025a2845c827d00",
    build_file = "3rd/openssl/BUILD",
    strip_prefix = "openssl-1.0.2p",
)

new_http_archive(
    name = "dpdk",
    url = "http://fast.dpdk.org/rel/dpdk-18.08.tar.xz",
    sha256 = "cde60eaaacd3065fedaa29cee74f95c41dedc3081a070451f2b0f95569fbb032",
    strip_prefix = "dpdk-18.08",
    build_file = "3rd/dpdk/BUILD",
)

new_git_repository (
    name = "numactl",
    remote = "https://github.com/numactl/numactl.git",
    tag = "v2.0.12",
    build_file = "3rd/numactl/BUILD",
)

new_http_archive (
    name = "libelf",
    url = "http://www.mr511.de/software/libelf-0.8.13.tar.gz",
    sha256 = "591a9b4ec81c1f2042a97aa60564e0cb79d041c52faa7416acb38bc95bd2c76d",
    strip_prefix = "libelf-0.8.13",
    build_file = "3rd/libelf/BUILD",
)