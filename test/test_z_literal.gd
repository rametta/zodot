extends GutTest

func test_z_literal():
	assert_true(Z.literal("foo").parse("foo").ok())
	assert_false(Z.literal("bar").parse("foo").ok())
	assert_false(Z.literal(123).parse(null).ok())
	assert_true(Z.literal(123).nullable().parse(null).ok())
