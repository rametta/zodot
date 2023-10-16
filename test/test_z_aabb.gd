extends GutTest

func test_z_aabb():
	assert_true(Z.aabb().parse(AABB()).ok())
	assert_true(Z.aabb().coerce().parse(var_to_str(AABB())).ok())
	assert_false(Z.aabb().parse(123).ok())
	assert_false(Z.aabb().parse(null).ok())
	assert_false(Z.aabb().parse("123").ok())
	
	var result = Z.aabb().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
