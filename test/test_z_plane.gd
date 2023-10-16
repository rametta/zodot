extends GutTest

func test_z_plane():
	assert_true(Z.plane().parse(Plane.PLANE_XY).ok())
	assert_true(Z.plane().coerce().parse(var_to_str(Plane.PLANE_YZ)).ok())
	assert_false(Z.plane().parse(123).ok())
	assert_false(Z.plane().parse(null).ok())
	assert_false(Z.plane().parse("123").ok())
	
	var result = Z.plane().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
