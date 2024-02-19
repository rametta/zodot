class_name Z

## Dictionary objects with specific properties
##
## Usage:
## [codeblock]
## var MySchema = Z.schema({
##     "name": Z.string(),
##     "age": Z.integer()
## })
## [/codeblock]
static func schema(dict: Dictionary) -> z_schema:
	return z_schema.new(dict)
	
static func union(schemas: Array[Zodot]) -> z_union:
	return z_union.new(schemas)
	
static func zenum(enum_type: Variant) -> z_enum:
	return z_enum.new(enum_type)

static func literal(value: Variant) -> z_literal:
	return z_literal.new(value)

static func nil() -> z_nil:
	return z_nil.new()
	
static func boolean(kind: z_boolean.Kind = z_boolean.Kind.BOTH) -> z_boolean:
	return z_boolean.new(kind)
	
static func integer() -> z_integer:
	return z_integer.new()
	
static func float() -> z_float:
	return z_float.new()

static func string() -> z_string:
	return z_string.new()
	
static func vector2() -> z_vector2:
	return z_vector2.new()
	
static func vector2i() -> z_vector2i:
	return z_vector2i.new()
	
static func rect2() -> z_rect2:
	return z_rect2.new()
	
static func rect2i() -> z_rect2i:
	return z_rect2i.new()

static func vector3() -> z_vector3:
	return z_vector3.new()
	
static func vector3i() -> z_vector3i:
	return z_vector3i.new()
	
static func transform2d() -> z_transform2d:
	return z_transform2d.new()

static func vector4() -> z_vector4:
	return z_vector4.new()

static func vector4i() -> z_vector4i:
	return z_vector4i.new()

static func plane() -> z_plane:
	return z_plane.new()
	
static func quaternion() -> z_quaternion:
	return z_quaternion.new()
	
static func aabb() -> z_aabb:
	return z_aabb.new()
	
static func basis() -> z_basis:
	return z_basis.new()
	
static func transform3d() -> z_transform3d:
	return z_transform3d.new()
	
static func projection() -> z_projection:
	return z_projection.new()
	
static func color() -> z_color:
	return z_color.new()

static func string_name() -> z_string_name:
	return z_string_name.new()

static func node_path() -> z_node_path:
	return z_node_path.new()

static func rid() -> z_rid:
	return z_rid.new()

static func object() -> z_object:
	return z_object.new()

static func callable() -> z_callable:
	return z_callable.new()

# name conflict with signal
static func zignal() -> z_signal:
	return z_signal.new()
	
static func dictionary(schema: Zodot = null) -> z_dictionary:
	return z_dictionary.new(schema)
	
static func array(schema: Zodot = null) -> z_array:
	return z_array.new(schema)
	
static func packed_byte_array() -> z_packed_byte_array:
	return z_packed_byte_array.new()

static func packed_int32_array() -> z_packed_int32_array:
	return z_packed_int32_array.new()
	
static func packed_int64_array() -> z_packed_int64_array:
	return z_packed_int64_array.new()
	
static func packed_float32_array() -> z_packed_float32_array:
	return z_packed_float32_array.new()
	
static func packed_float64_array() -> z_packed_float64_array:
	return z_packed_float64_array.new()
	
static func packed_string_array() -> z_packed_string_array:
	return z_packed_string_array.new()
	
static func packed_vector2_array() -> z_packed_vector2_array:
	return z_packed_vector2_array.new()
	
static func packed_vector3_array() -> z_packed_vector3_array:
	return z_packed_vector3_array.new()
	
static func packed_color_array() -> z_packed_color_array:
	return z_packed_color_array.new()
	
static func zmax() -> z_max:
	return z_max.new()
