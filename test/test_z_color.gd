extends GutTest

func test_z_color():
	assert_true(Z.color().parse(Color.ALICE_BLUE).ok())
	assert_true(Z.color().parse(Color(1,2,3,.5)).ok())
	assert_true(Z.color().coerce().parse(var_to_str(Color.ANTIQUE_WHITE)).ok())
	assert_false(Z.color().parse(123).ok())
	assert_false(Z.color().parse(null).ok())
	assert_false(Z.color().parse("123").ok())
