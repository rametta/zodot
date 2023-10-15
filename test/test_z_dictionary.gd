extends GutTest

func test_z_dictionary_base():
	assert_true(Z.dictionary().parse({}).ok())
	assert_true(Z.dictionary().parse({"key": 1}).ok())
	assert_false(Z.dictionary().parse(123).ok())
	assert_false(Z.dictionary().parse(null).ok())
	assert_false(Z.dictionary().parse("123").ok())
	assert_false(Z.dictionary().parse([]).ok())
	
	var result = Z.dictionary().parse("", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_dictionary_non_empty():
	assert_true(Z.dictionary().non_empty().parse({"key": 1}).ok())
	assert_false(Z.dictionary().non_empty().parse({}).ok())
	
func test_z_dictionary_nullable():
	assert_true(Z.dictionary().nullable().parse({}).ok())
	assert_true(Z.dictionary().nullable().parse(null).ok())

func test_z_dictionary_coerce():
	var schema = Z.dictionary().coerce()
	var data = var_to_str({"key": 1})
	var result = schema.parse(data)
	assert_true(result.ok())
	assert_eq(result.data, {"key": 1})
	
func test_z_dictionary_schema_int():
	var schema = Z.dictionary(Z.integer())
	assert_true(schema.parse({"key": 1}).ok())
	var result = schema.parse({"key": "123"}, "my_dict")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'my_dict[key]' does not match desired type")
