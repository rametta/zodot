# 🛡️ Zodot

> Data Validator for [Godot](https://godotengine.org/) - _inspired by [Zod](https://github.com/colinhacks/zod)_

Zodot is a lightweight data validation library for Godot. Define a schema shape, then use that schema to validate any data. Excellent for parsing data that was stored in JSON, or data returned from API's.

## Features:

- Validators for all the Godot [Variant Types](https://docs.godotengine.org/en/latest/classes/class_@globalscope.html#enum-globalscope-variant-type)
- More expressive than what GDScript provides, allows things like `.nullable()` and `.union()`
- Automatic data coercing with `.coerce()` that uses `str_to_var`
- Extendible with custom validators for your own types
- Clear error messages
- Lightweight & Zero Dependencies

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

```

```

## Installation

Clone `addons/zodot` into your projects `addons` folder, or [download directly](https://godotengine.org/asset-library/asset/2261) from the Godot Asset Store.

## Types

Here is a list of all the available types to use for validation, and their associated constraints. All types also have available these base constraints:

- `.coerce()` calls `str_to_var()` before validation, useful if previously called `var_to_string()`
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
