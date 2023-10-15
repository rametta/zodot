extends GutTest

func test_z_string_base():
	assert_true(Z.string().parse("my_str").is_ok())
	assert_false(Z.string().parse(123).is_ok())
	assert_false(Z.string().parse(null).is_ok())

func test_z_string_min():
	assert_true(Z.string().minimum(5).parse("aaaaa").is_ok())
	assert_false(Z.string().minimum(5).parse("a").is_ok())

func test_z_string_max():
	assert_true(Z.string().maximum(5).parse("a").is_ok())
	assert_false(Z.string().maximum(5).parse("aaaaaa").is_ok())

func test_z_string_non_empty():
	assert_true(Z.string().non_empty().parse("a").is_ok())
	assert_false(Z.string().non_empty().parse("").is_ok())

func test_z_string_nullable():
	assert_true(Z.string().nullable().parse("my_str").is_ok())
	assert_true(Z.string().nullable().parse(null).is_ok())

func test_z_string_coerce():
	assert_true(Z.string().coerce().parse(var_to_str(String("my_string"))).is_ok())
