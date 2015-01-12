#include "gmock/gmock.h"
#include "../src/hello.h"

using namespace ::testing;

const std::string expected = "Hello, world!";

class TestCaseFixture : public testing::Test {
public:

};

TEST_F(TestCaseFixture, TestDescription) {
  ASSERT_THAT(hello_world(), Eq(expected));
}

