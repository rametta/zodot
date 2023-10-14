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
  print(result.is_ok()) # true
```

Using the same schema, here is an example where the validation fails:

```gdscript
var user = {
  "name": "Jason",
  "age": 10,
  "is_tall": true
}

var result = UserSchema.parse(user)
print(result.is_ok()) # false
print(result.error) # "Field 'age' has value lower than desired minimum of 12"
```

## Installation

Clone `addons/zodot` into your projects `addons` folder, or download directly from the Godot Asset Store here. (Link coming soon - pending application approval)

## Types

`// TODO - Coming soon`
