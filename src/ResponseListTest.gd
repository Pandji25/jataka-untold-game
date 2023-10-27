extends HBoxContainer

@export var response_template: Button
@export var response_label: Label

var texts: Array = ["hello", "bonjour"]

func _ready():
	for item in texts:
		var response: Button = response_template.duplicate(0)
		
		response.name = "Response%s" % get_child_count()
		
		var response_text: Label = response_label.duplicate(0)
		
		response_text.name = "ResponseText"
		response_text.text = item
		add_child(response)
		response.add_child(response_text)



