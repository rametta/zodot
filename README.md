# 🛡️ Zodot

> Data Validator for [Godot](https://godotengine.org/) - _inspired by [Zod](https://github.com/colinhacks/zod)_

Zodot is a lightweight data validation library for Godot. Define a schema shape, then use that schema to validate any data. Excellent for parsing data that was stored in JSON, or data returned from API's.

If validation passes then we are assured the data is in the correct shape, if not, Zodot provide friendly error messages for whichever field does not match the schema.

## Usage

Here is an example of a defined schema for a `User` with 3 fields and their corresponding types. We can also see there are extra constraints on the name and age, such as name can not be empty, and age must be greater than 12.

```gdscript
# Our User Schema
var UserSchema = Z.schema({
  "name": Z.string().non_empty().maximum(5).minimum(1),
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

## Installation

Clone `addons/zodot` into your projects `addons` folder, or download directly from the Godot Asset Store here. (Link coming soon - pending application approval)

## Types

Here is a list of all the available types to use for validation, and their associated constraints. All types also have available these base constraints:

- `.coerce()` calls `str_to_var()` before validation, useful if previously called `var_to_string()`
- `.nullable()` allows the field to be null or missing

Examples

```gdscript
# Coerce example
var schema = Z.integer().minimum(1).maximum(20).coerce()
schema.parse("5").ok() # true
var result = schema.parse(var_to_str(26)).ok() # false
result.data == 26 # true, result data contains the coerced value

# Nullable example
var schema = Z.integer().minimum(1).maximum(20).nullable()
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
