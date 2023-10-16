extends GutTest

func test_z_union():
	var schema = Z.union([Z.vector3(), Z.color()])
	assert_true(schema.parse(Vector3.ZERO).ok())
	assert_true(schema.parse(Color.ALICE_BLUE).ok())
	assert_false(schema.parse(123).ok())
	assert_false(schema.parse(null).ok())
