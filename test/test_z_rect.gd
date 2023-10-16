extends GutTest

func test_z_rect2():
	assert_true(Z.rect2().parse(Rect2(1.1,2.1,3.1,4.1)).ok())
	assert_true(Z.rect2().coerce().parse(var_to_str(Rect2(1.1,2.1,3.1,4.1))).ok())
	assert_false(Z.rect2().parse(123).ok())
	assert_false(Z.rect2().parse(null).ok())
	assert_false(Z.rect2().parse("123").ok())
	
	var result = Z.rect2().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_rect2i():
	assert_true(Z.rect2i().parse(Rect2i(1,2,3,4)).ok())
	assert_true(Z.rect2i().coerce().parse(var_to_str(Rect2i(1,2,3,4))).ok())
	assert_false(Z.rect2i().parse(123).ok())
	assert_false(Z.rect2i().parse(null).ok())
	assert_false(Z.rect2i().parse("123").ok())
	
	var result = Z.rect2i().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
