extends GutTest

func test_z_quaternion():
	assert_true(Z.quaternion().parse(Quaternion.IDENTITY).ok())
	assert_true(Z.quaternion().coerce().parse(var_to_str(Quaternion.IDENTITY)).ok())
	assert_false(Z.quaternion().parse(123).ok())
	assert_false(Z.quaternion().parse(null).ok())
	assert_false(Z.quaternion().parse("123").ok())
	
	var result = Z.quaternion().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
