extends GutTest

func test_z_transform3d():
	assert_true(Z.transform3d().parse(Transform3D.FLIP_Z).ok())
	assert_true(Z.transform3d().parse(Transform3D.IDENTITY).ok())
	assert_true(Z.transform3d().parse(Transform3D.FLIP_Y).ok())
	assert_true(Z.transform3d().coerce().parse(var_to_str(Transform3D.FLIP_X)).ok())
	assert_false(Z.transform3d().parse(123).ok())
	assert_false(Z.transform3d().parse(null).ok())
	assert_false(Z.transform3d().parse("123").ok())
	
	var result = Z.transform3d().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
