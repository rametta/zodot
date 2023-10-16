extends GutTest

func test_z_vector3():
	assert_true(Z.vector3().parse(Vector3.ZERO).ok())
	assert_true(Z.vector3().parse(Vector3.ONE).ok())
	assert_true(Z.vector3().parse(Vector3(1.1,2.2, 7)).ok())
	assert_true(Z.vector3().coerce().parse(var_to_str(Vector3(1.1,2.2, 7))).ok())
	assert_false(Z.vector3().parse(123).ok())
	assert_false(Z.vector3().parse(null).ok())
	assert_false(Z.vector3().parse("123").ok())
	
	var result = Z.vector3().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_vector3i():
	assert_true(Z.vector3i().parse(Vector3i.ZERO).ok())
	assert_true(Z.vector3i().parse(Vector3i.ONE).ok())
	assert_true(Z.vector3i().parse(Vector3i(1,2,7)).ok())
	assert_true(Z.vector3i().coerce().parse(var_to_str(Vector3i(1,2,8))).ok())
	assert_false(Z.vector3i().parse(Vector3(1,2,6)).ok())
	assert_false(Z.vector3i().parse(123).ok())
	assert_false(Z.vector3i().parse(null).ok())
	assert_false(Z.vector3i().parse("123").ok())
	
	var result = Z.vector3i().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
