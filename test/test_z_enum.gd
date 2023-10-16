extends GutTest

enum MyEnum {
	Fast,
	Slow,
	Medium
}

func test_z_enum():
	var schema = Z.zenum(MyEnum)
	assert_true(schema.parse(MyEnum.Fast).ok())
	assert_true(schema.parse(MyEnum.Slow).ok())
	assert_true(schema.parse(MyEnum.Medium).ok())
	assert_true(schema.parse(0).ok())
	assert_true(schema.parse(1).ok())
	assert_true(schema.parse(2).ok())
	assert_false(schema.parse(5).ok())
	assert_false(schema.parse(4).ok())
	assert_false(schema.parse(true).ok())
