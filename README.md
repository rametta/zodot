# 🛡️ Zodot

> Data Validator for [Godot](https://godotengine.org/) - _inspired by [Zod](https://github.com/colinhacks/zod)_

Zodot is a lightweight data validation library for Godot. Define a schema shape, then use that schema to validate any data. Excellent for parsing data that was stored in JSON, or data returned from API's.

## Features:

- Validators for all the Godot [Variant Types](https://docs.godotengine.org/en/latest/classes/class_@globalscope.html#enum-globalscope-variant-type)
- More expressive than what GDScript provides, allows things like `.nullable()`, `.union()`, typed dictionaries, and more
- Automatic data coercing with `.coerce()` that uses `str_to_var`
- Extendible with custom validators for your own types
- Clear error messages
- Lightweight & Zero Dependencies

## Installation

Clone `addons/zodot` into your projects `addons` folder, or [download directly](https://godotengine.org/asset-library/asset/2261) from the Godot Asset Store.

## Usage

Here is an example of a defined schema for a `User` with 3 fields and their corresponding types. We can also see there are extra constraints on the name and age, such as name can not be empty, and age must be greater than 12.

```gdscript
# Our User Schema
var UserSchema = Z.schema({
  "name": Z.string().non_empty().maximum(5),
  "age": Z.integer().minimum(12),
  "is_tall": Z.boolean()
})

# Our data we want to validate
var user = {
  "name": "Jason",
  "age": 100,
  "is_tall": true
}

func _ready():
  # Validate the data against the schema and get the result
  var result = UserSchema.parse(user)
  print(result.ok()) # true
```

Using the same schema, here is an example where the validation fails:

```gdscript
var user = {
  "name": "Jason",
  "age": 10,
  "is_tall": true
}

var result = UserSchema.parse(user)
print(result.ok()) # false
print(result.error) # "Field 'age' has value lower than desired minimum of 12"
```

Example where data was stored by calling `var_to_str` on every field and stored as `JSON`.

```gdscript
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

# Simulate retreiving this data from external source
# by stringifying than parsing
var json_string = JSON.stringify(data)
var json = JSON.new()
json.parse(json_string)

var result = schema.parse(json.data)

assert_eq(result.data.my_color, Color(5.5,6.6,7.7, .5)) # true
assert_eq(result.data.my_float, 1.23) # true
assert_eq(result.data.my_vect3, Vector3(1.9,2.3,3.5)) # true
```

## Types

Here is a list of all the available types to use for validation, and their associated constraints. All types also have these base constraints available:

- `.coerce()` calls `str_to_var()` before validation, useful if previously called `var_to_str()`
- `.nullable()` allows the field to be null or missing

Examples

```gdscript
# Coerce example
var schema = Z.integer().minimum(2).maximum(20).coerce()
schema.parse("5").ok() # true
var result = schema.parse(var_to_str(26)).ok() # false
result.data == 26 # true, result data contains the coerced value

# Nullable example
var schema = Z.integer().minimum(2).maximum(20).nullable()
schema.parse(5).ok() # true
schema.parse(null).ok() # true
schema.parse(26).ok() # false
```

### Z.string()

Parse [string](https://docs.godotengine.org/en/latest/classes/class_string.html#class-string) type.

Available extension constraints:

- `.non_empty()` enforces strings to not be empty
- `.minimum(value: int)` enforces a minimum length
- `.maximum(value: int)` enforces a maximum length

Example

```gdscript
var schema = Z.string().minimum(1).maximum(20)
schema.parse("hello").ok() # true
schema.parse("").ok() # false
```

### Z.integer()

Parse [integer](https://docs.godotengine.org/en/latest/classes/class_int.html#class-int) type.

Available extension constraints:

- `.minimum(value: int)` enforces a minimum value
- `.maximum(value: int)` enforces a maximum value

Example

```gdscript
var schema = Z.integer().minimum(1).maximum(20)
schema.parse(5).ok() # true
schema.parse(100).ok() # false
schema.parse(5.5).ok() # false - float is not an integer
```

### Z.float()

Parse [float](https://docs.godotengine.org/en/latest/classes/class_float.html#class-float) type.

Available extension constraints:

- `.minimum(value: float)` enforces a minimum value
- `.maximum(value: float)` enforces a maximum value

Example

```gdscript
var schema = Z.float().minimum(1.0).maximum(20.5)
schema.parse(5.5).ok() # true
schema.parse(100.45).ok() # false
schema.parse(5).ok() # false - int is not a float
```

### Z.boolean()

Parse [boolean](https://docs.godotengine.org/en/latest/classes/class_bool.html#class-bool) type.

Accepts enum to constrain to either only `true` or only `false`. Default is both.

Example

```gdscript
Z.boolean().parse(true).ok() # true
Z.boolean().parse(false).ok() # true

Z.boolean(z_boolean.Kind.ONLY_TRUE).parse(true).ok() # true
Z.boolean(z_boolean.Kind.ONLY_TRUE).parse(false).ok() # false

Z.boolean(z_boolean.Kind.ONLY_FALSE).parse(true).ok() # false
Z.boolean(z_boolean.Kind.ONLY_FALSE).parse(false).ok() # true
```

### Z.array()

Parse [array](https://docs.godotengine.org/en/latest/classes/class_array.html#class-array) type.

Accepts an optional extra schema to constrain array items to a certain type.

Available extension constraints:

- `.non_empty()` enforces the array to have at least 1 item

Example

```gdscript
Z.array().parse([1,2,3]).ok() # true
Z.array().non_empty().parse([]).ok() # false, empty
Z.array(Z.integer()).parse([1,2,3]).ok() # true
Z.array(Z.integer()).parse(["1",2,3]).ok() # false, item[0] is a string
```

### Z.dictionary()

Parse [dictionary](https://docs.godotengine.org/en/latest/classes/class_dictionary.html#class-dictionary) type.

Accepts an optional extra schema to constrain dictionary items to a certain type. (For a specific dictionary shape, use `Z.schema()` instead)

Available extension constraints:

- `.non_empty()` enforces the dictionary to have at least 1 item

Example

```gdscript
Z.dictionary().parse({"key": 1}).ok() # true
Z.dictionary().non_empty().parse({}).ok() # false, empty
Z.dictionary(Z.integer()).parse({"key": 1}).ok() # true
Z.dictionary(Z.integer()).parse({"key": "a"}).ok() # false, key is a string
```

### Z.schema()

A special type for defining specific object shapes that are more rigid than a standard dictionary. Takes a dictionary as argument, where each key defines a type.

Example

```gdscript
var schema = Z.schema({
  "first_name": Z.string().non_empty(),
  "fave_color": Z.color().nullable()
})

var data = {
  "first_name": "Jason",
  "fave_color": Color.ALICE_BLUE
}

schema.parse(data).ok() # true
```

### Z.union()

A special type for allowing a field to be more than 1 type. Takes an array of schemas to validate against.

Example:

```gdscript
# Allow a field to be a color OR a vector3
var schema = Z.union([Z.color(), Z.vector3()])

schema.parse(Vector3(1,2,3)).ok() # true
schema.parse(Color(1,2,3)).ok() # true
schema.parse(67).ok() # false
```

### Z.zenum() (Z.enum())

A special type for parsing Godot `enum`'s.

Note: Since `enum` is a reserved word, this validator can not be called `Z.enum()` so it is called `Z.zenum()` instead.

Example:

```gdscript
enum Speed = {
  Fast,
  Slow,
  Medium
}

var schema = Z.zenum(Speed)

schema.parse(Speed.Fast).ok() # true
schema.parse(Speed.Slow).ok() # true
schema.parse(Speed.Medium).ok() # true
schema.parse(0).ok() # true
schema.parse(1).ok() # true
schema.parse(2).ok() # true
schema.parse(67).ok() # false
```

### Z.color()

Parse [Color](https://docs.godotengine.org/en/latest/classes/class_color.html#class-color) type.

Example

```gdscript
Z.color().parse(Color.ALICE_BLUE).ok() # true
Z.color().parse(Color(1,2,3,0.5)).ok() # true
Z.color().parse("blue").ok() # false
```

### Z.vector2() & Z.vector2i()

Parse [Vector2](https://docs.godotengine.org/en/latest/classes/class_vector2.html#class-vector2) and [Vector2i](https://docs.godotengine.org/en/latest/classes/class_vector2i.html#class-vector2i) types respectively.

Example

```gdscript
# Vector2
Z.vector2().parse(Vector2.ZERO).ok() # true
Z.vector2().parse(Vector2(1.1, 2)).ok() # true
Z.vector2().parse(Vector3.ZERO).ok() # false

# Vector2I
Z.vector2i().parse(Vector2i.ZERO).ok() # true
Z.vector2i().parse(Vector2i(1, 2)).ok() # true
Z.vector2i().parse(Vector2.ZERO).ok() # false
```

### Z.vector3() & Z.vector3i()

Parse [Vector3](https://docs.godotengine.org/en/latest/classes/class_vector3.html#class-vector3) and [Vector3i](https://docs.godotengine.org/en/latest/classes/class_vector3i.html#class-vector3i) types respectively.

Example

```gdscript
# Vector3
Z.vector3().parse(Vector3.ZERO).ok() # true
Z.vector3().parse(Vector3(1.1, 2, 6)).ok() # true
Z.vector3().parse(Vector4.ZERO).ok() # false

# Vector3I
Z.vector3i().parse(Vector3i.ZERO).ok() # true
Z.vector3i().parse(Vector3i(1, 2, 7)).ok() # true
Z.vector3i().parse(Vector3.ZERO).ok() # false
```

### Z.vector4() & Z.vector4i()

Parse [Vector4](https://docs.godotengine.org/en/latest/classes/class_vector4.html#class-vector4) and [Vector4i](https://docs.godotengine.org/en/latest/classes/class_vector4i.html#class-vector4i) types respectively.

Example

```gdscript
# Vector4
Z.vector4().parse(Vector4.ZERO).ok() # true
Z.vector4().parse(Vector4(1.1, 2, 6, 1)).ok() # true
Z.vector4().parse(Vector3.ZERO).ok() # false

# Vector4I
Z.vector4i().parse(Vector4i.ZERO).ok() # true
Z.vector4i().parse(Vector4i(1, 2, 7, 8)).ok() # true
Z.vector4i().parse(Vector4.ZERO).ok() # false
```

### Z.transform2d() & Z.transform3d()

Parse [Transform2D](https://docs.godotengine.org/en/latest/classes/class_transform2d.html#class-transform2d) and [Transform3D](https://docs.godotengine.org/en/latest/classes/class_transform3d.html#class-transform3d) types respectively.

Example

```gdscript
# Transform2D
Z.transform2d().parse(Transform2D.FLIP_X).ok() # true
Z.transform2d().parse(Vector3.ZERO).ok() # false

# Transform3D
Z.transform3d().parse(Transform3D.FLIP_Z).ok() # true
Z.transform3d().parse(Vector4.ZERO).ok() # false
```

### Z.rect2() & Z.rect2i()

Parse [Rect2](https://docs.godotengine.org/en/latest/classes/class_rect2.html#class-rect2) and [Rect2i](https://docs.godotengine.org/en/latest/classes/class_rect2i.html#class-rect2i) types respectively.

Example

```gdscript
# Rect2
Z.rect2().parse(Rect2(1,2,3,4.5)).ok() # true
Z.rect2().parse(Vector3.ZERO).ok() # false

# Rect2i
Z.rect2i().parse(Rect2(1,2,3,4)).ok() # true
Z.rect2i().parse(Vector4.ZERO).ok() # false
```

### Z.plane()

Parse [Plane](https://docs.godotengine.org/en/latest/classes/class_plane.html#class-plane) type.

Example

```gdscript
Z.plane().parse(Plane.PLANE_XY).ok() # true
```

### Z.projection()

Parse [Projection](https://docs.godotengine.org/en/latest/classes/class_projection.html#class-projection) type.

Example

```gdscript
Z.projection().parse(Projection.ZERO).ok() # true
```

### Z.quaternion()

Parse [Quaternion](https://docs.godotengine.org/en/latest/classes/class_quaternion.html#class-quaternion) type.

Example

```gdscript
Z.quaternion().parse(Quaternion.IDENTITY).ok() # true
```

### Z.aabb()

Parse [AABB](https://docs.godotengine.org/en/latest/classes/class_aabb.html#class-aabb) type.

Example

```gdscript
Z.aabb().parse(AABB()).ok() # true
```

### Z.rid()

Parse [RID](https://docs.godotengine.org/en/latest/classes/class_rid.html#class-rid) type.

Example

```gdscript
Z.rid().parse(RID()).ok() # true
```

### Z.basis()

Parse [Basis](https://docs.godotengine.org/en/latest/classes/class_basis.html#class-basis) type.

Example

```gdscript
Z.basis().parse(Basis.FLIP_X).ok() # true
```

### More

There are many more validators, please check [here](https://github.com/rametta/zodot/tree/main/addons/zodot/type_classes) for a full list of all the validators available.
