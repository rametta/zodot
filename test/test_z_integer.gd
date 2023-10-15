extends GutTest

func test_z_integer_base():
	assert_true(Z.integer().parse(123).is_ok())
	assert_false(Z.integer().parse(123.567).is_ok())
	assert_false(Z.integer().parse(null).is_ok())
	assert_false(Z.integer().parse("123").is_ok())

func test_z_integer_min():
	assert_true(Z.integer().minimum(5).parse(7).is_ok())
	assert_false(Z.integer().minimum(5).parse(3).is_ok())

func test_z_integer_max():
	assert_true(Z.integer().maximum(5).parse(4).is_ok())
	assert_false(Z.integer().maximum(5).parse(8).is_ok())
	
func test_z_integer_min_max_nullable_corece():
	var schema = Z.integer().maximum(5).minimum(1).nullable().coerce()
	assert_true(schema.parse(var_to_str(4)).is_ok())
	assert_true(schema.parse(4).is_ok())
	assert_true(schema.parse(null).is_ok())
	assert_false(schema.parse(-6).is_ok())
	assert_false(schema.parse(20).is_ok())
	assert_false(schema.parse(3.14).is_ok())

func test_z_integer_nullable():
	assert_true(Z.integer().nullable().parse(123).is_ok())
	assert_true(Z.integer().nullable().parse(null).is_ok())

func test_z_integer_coerce():
	assert_true(Z.integer().coerce().parse(var_to_str(123)).is_ok())

func test_z_int_data_coerce():
	var result = Z.integer().coerce().parse(var_to_str(123))
	
	assert_true(result.is_ok())
	assert_eq(result.data, 123)
	assert_eq(result.error, "")
