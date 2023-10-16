extends GutTest

func test_z_vector2():
	assert_true(Z.vector2().parse(Vector2.ZERO).ok())
	assert_true(Z.vector2().parse(Vector2.ONE).ok())
	assert_true(Z.vector2().parse(Vector2(1.1,2.2)).ok())
	assert_true(Z.vector2().coerce().parse(var_to_str(Vector2(1.1,2.2))).ok())
	assert_false(Z.vector2().parse(123).ok())
	assert_false(Z.vector2().parse(null).ok())
	assert_false(Z.vector2().parse("123").ok())
	
	var result = Z.vector2().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_vector2i():
	assert_true(Z.vector2i().parse(Vector2i.ZERO).ok())
	assert_true(Z.vector2i().parse(Vector2i.ONE).ok())
	assert_true(Z.vector2i().parse(Vector2i(1,2)).ok())
	assert_true(Z.vector2i().coerce().parse(var_to_str(Vector2i(1,2))).ok())
	assert_false(Z.vector2i().parse(Vector2(1,2)).ok())
	assert_false(Z.vector2i().parse(123).ok())
	assert_false(Z.vector2i().parse(null).ok())
	assert_false(Z.vector2i().parse("123").ok())
	
	var result = Z.vector2i().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")
