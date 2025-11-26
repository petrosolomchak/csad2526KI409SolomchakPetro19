#include <gtest/gtest.h>
#include "math_operations.h"

TEST(AdditionTest, PositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AdditionTest, NegativeNumbers) {
    EXPECT_EQ(add(-2, -3), -5);
}

TEST(AdditionTest, MixedSign) {
    EXPECT_EQ(add(-2, 3), 1);
}

TEST(AdditionTest, Zero) {
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(0, 5), 5);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
