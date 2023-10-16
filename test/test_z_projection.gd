extends GutTest

func test_z_projection():
	assert_true(Z.projection().parse(Projection.ZERO).ok())
	assert_true(Z.projection().coerce().parse(var_to_str(Projection.ZERO)).ok())
	assert_false(Z.projection().parse(123).ok())
	assert_false(Z.projection().parse(null).ok())
	assert_false(Z.projection().parse("123").ok())
	
	var result = Z.projection().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
