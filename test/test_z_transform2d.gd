extends GutTest

func test_z_transform2d():
	assert_true(Z.transform2d().parse(Transform2D.FLIP_X).ok())
	assert_true(Z.transform2d().parse(Transform2D.FLIP_Y).ok())
	assert_true(Z.transform2d().coerce().parse(var_to_str(Transform2D.FLIP_X)).ok())
	assert_false(Z.transform2d().parse(123).ok())
	assert_false(Z.transform2d().parse(null).ok())
	assert_false(Z.transform2d().parse("123").ok())
	
	var result = Z.transform2d().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
