extends GutTest

func test_z_rid():
	assert_true(Z.rid().parse(RID()).ok())
	assert_true(Z.rid().coerce().parse(var_to_str(RID())).ok())
	assert_false(Z.rid().parse(123).ok())
	assert_false(Z.rid().parse(null).ok())
	assert_false(Z.rid().parse("123").ok())
	
	var result = Z.rid().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
