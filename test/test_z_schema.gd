extends GutTest

var schema = Z.schema({
	"name": Z.string(),
	"color": Z.color()
})
	
func test_z_schema_base():
	assert_true(schema.parse({ "name": "jason", "color": Color.ALICE_BLUE }).ok())
	assert_false(schema.parse(null).ok())
	assert_false(schema.parse({}).ok())
	assert_false(schema.parse({"name": "jason"}).ok())
	assert_false(schema.parse({"name": "jason", "color": null}).ok())
	
func test_z_schema_nullable():
	assert_true(schema.nullable().parse(null).ok())
	assert_false(schema.nullable().parse({}).ok())

func test_z_schema_field_nullable():
	var schema2 = Z.schema({
		"name": Z.string(),
		"color": Z.color().nullable()
	})
	assert_true(schema2.parse({"name": "jason"}).ok())
	assert_true(schema2.parse({"name": "jason", "color": null}).ok())
