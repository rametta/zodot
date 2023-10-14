# 🛡️ Zodot

> Data Validator for [Godot](https://godotengine.org/)

## Example Usage

```gdscript
var UserSchema = Z.schema({
	"name": Z.string().non_empty().maximum(5).minimum(1),
	"age": Z.integer().minimum(12),
	"is_tall": Z.boolean()
})

var user = {
	"name": "Jason",
	"age": 100,
	"is_tall": true
}

func _ready():
	var result = UserSchema.parse(user)
	print(result.is_ok()) # true
```
