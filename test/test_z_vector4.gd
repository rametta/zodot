extends GutTest

func test_z_vector4():
	assert_true(Z.vector4().parse(Vector4.ZERO).ok())
	assert_true(Z.vector4().parse(Vector4.ONE).ok())
	assert_true(Z.vector4().parse(Vector4(1.1,2.2,7,1)).ok())
	assert_true(Z.vector4().coerce().parse(var_to_str(Vector4(1.1,2.2,7,9))).ok())
	assert_false(Z.vector4().parse(123).ok())
	assert_false(Z.vector4().parse(null).ok())
	assert_false(Z.vector4().parse("123").ok())
	
	var result = Z.vector4().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_vector4i():
	assert_true(Z.vector4i().parse(Vector4i.ZERO).ok())
	assert_true(Z.vector4i().parse(Vector4i.ONE).ok())
	assert_true(Z.vector4i().parse(Vector4i(1,2,7,1)).ok())
	assert_true(Z.vector4i().coerce().parse(var_to_str(Vector4i(1,2,8,1))).ok())
	assert_false(Z.vector4i().parse(Vector4(1,2,6,1)).ok())
	assert_false(Z.vector4i().parse(123).ok())
	assert_false(Z.vector4i().parse(null).ok())
	assert_false(Z.vector4i().parse("123").ok())
	
	var result = Z.vector4i().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
