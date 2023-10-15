extends GutTest

func test_z_float_base():
	assert_true(Z.float().parse(123.67).is_ok())
	assert_false(Z.float().parse(123).is_ok())
	assert_false(Z.float().parse(null).is_ok())
	assert_false(Z.float().parse("123").is_ok())

func test_z_float_min():
	assert_true(Z.float().minimum(5.5).parse(7.8).is_ok())
	assert_false(Z.float().minimum(5.5).parse(3.12).is_ok())

func test_z_float_max():
	assert_true(Z.float().maximum(5.5).parse(4.2).is_ok())
	assert_false(Z.float().maximum(5.5).parse(8.1).is_ok())
	
func test_z_float_min_max_nullable_corece():
	var schema = Z.float().maximum(5.5).minimum(1.0).nullable().coerce()
	assert_true(schema.parse(var_to_str(4.6)).is_ok())
	assert_true(schema.parse(4.6).is_ok())
	assert_true(schema.parse(null).is_ok())
	assert_false(schema.parse(-6.4).is_ok())
	assert_false(schema.parse(20).is_ok())
	assert_false(schema.parse(20.0).is_ok())

func test_z_float_nullable():
	assert_true(Z.float().nullable().parse(123.3).is_ok())
	assert_true(Z.float().nullable().parse(null).is_ok())

func test_z_float_coerce():
	assert_true(Z.float().coerce().parse(var_to_str(123.56)).is_ok())
	
func test_z_float_data_coerce():
	var result = Z.float().coerce().parse(var_to_str(123.56))
	
	assert_true(result.is_ok())
	assert_eq(result.data, 123.56)
	assert_eq(result.error, "")
