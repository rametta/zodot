extends GutTest

func test_z_basis():
	assert_true(Z.basis().parse(Basis.FLIP_X).ok())
	assert_true(Z.basis().coerce().parse(var_to_str(Basis.FLIP_X)).ok())
	assert_false(Z.basis().parse(123).ok())
	assert_false(Z.basis().parse(null).ok())
	assert_false(Z.basis().parse("123").ok())
	
	var result = Z.basis().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
