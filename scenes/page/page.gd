class_name Page extends Control

var page_data: PageData
signal option_selected(String)

# Called when the node enters the scene tree for the first time.
func _ready():
	if page_data != null:
		$MarginContainer/VBoxContainer/PanelContainer/MarginContainer/RichTextLabel.text = page_data.title
		$MarginContainer/VBoxContainer/HBoxContainer/TextureRect.texture = load(page_data.image_path)
		$MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel.text = page_data.text
		for option in page_data.options:
			var opt = option as Option
			var button = Button.new()
			button.text = opt.text
			button.pressed.connect(select_option.bind(opt.target_id))
			$MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Options.add_child(button)

func select_option(id: String):
	print("selected ", id)
	option_selected.emit(id)
