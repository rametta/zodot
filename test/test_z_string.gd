extends GutTest

func test_z_string_base():
	assert_true(Z.string().parse("my_str").ok())
	assert_false(Z.string().parse(123).ok())
	assert_false(Z.string().parse(null).ok())

func test_z_string_min():
	assert_true(Z.string().minimum(5).parse("aaaaa").ok())
	assert_false(Z.string().minimum(5).parse("a").ok())

func test_z_string_max():
	assert_true(Z.string().maximum(5).parse("a").ok())
	assert_false(Z.string().maximum(5).parse("aaaaaa").ok())

func test_z_string_non_empty():
	assert_true(Z.string().non_empty().parse("a").ok())
	assert_false(Z.string().non_empty().parse("").ok())

func test_z_string_nullable():
	assert_true(Z.string().nullable().parse("my_str").ok())
	assert_true(Z.string().nullable().parse(null).ok())

func test_z_string_coerce():
	assert_true(Z.string().coerce().parse(var_to_str(String("my_string"))).ok())
