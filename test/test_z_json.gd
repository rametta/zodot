extends GutTest

var schema = Z.schema({
	"my_float": Z.float().coerce(),
	"my_color": Z.color().coerce(),
	"my_vect3": Z.vector3().coerce()
})

var data = {
	"my_float": var_to_str(1.23),
	"my_color": var_to_str(Color(5.5,6.6,7.7, .5)),
	"my_vect3": var_to_str(Vector3(1.9,2.3,3.5)),
}

var json_string = JSON.stringify(data)

func test_z_json():
	var json = JSON.new()
	var error = json.parse(json_string)
	assert_eq(error, OK)
	var result = schema.parse(json.data)
	assert_true(result.ok())
	assert_eq(result.error, "")
	
	assert_eq(result.data.my_color, Color(5.5,6.6,7.7, .5))
	assert_eq(result.data.my_float, 1.23)
	assert_eq(result.data.my_vect3, Vector3(1.9,2.3,3.5))
	
	assert_typeof(result.data.my_color, TYPE_COLOR)
	assert_typeof(result.data.my_float, TYPE_FLOAT)
	assert_typeof(result.data.my_vect3, TYPE_VECTOR3)
