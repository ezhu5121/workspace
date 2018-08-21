#include "gtest/gtest.h"

#include <openssl/ssl.h>

TEST(hello_test, get_greet) {
    EXPECT_EQ(SSL_library_init(), 1);
}
