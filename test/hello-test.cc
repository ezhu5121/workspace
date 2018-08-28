#include "gtest/gtest.h"
#include <openssl/ssl.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>
#include <sys/queue.h>

#include <dpdk/rte_memory.h>
#include <dpdk/rte_memzone.h>
#include <dpdk/rte_launch.h>
#include <dpdk/rte_eal.h>
#include <dpdk/rte_per_lcore.h>
#include <dpdk/rte_lcore.h>
#include <dpdk/rte_debug.h>

TEST(hello_test, ssl_init) {
    EXPECT_EQ(SSL_library_init(), 1);
}

int main(int argc, char* argv[]) {
    int rc = rte_eal_init(argc, argv);
    EXPECT_GE(rc, 0);

    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
