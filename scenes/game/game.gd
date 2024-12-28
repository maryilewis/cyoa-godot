extends Control

const PAGE = preload("res://scenes/page/page.tscn")

# Dictionary holding the data for all the pages
var page_data: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	# These two lines could probably be done in one step, but I didn't feel like it.
	var file_data = _parse("res://data/example_data.csv")
	get_page_data_From_file_data(file_data)
	go_to_page("start") #assumes your first page has the ID start. Change to suit your data.

## Reads a csv and turns it into a dictionary
## Adapted from https://github.com/Anaxie-Studio/godot-csv-to-dictionary/blob/main/csv_to_dictionary_parser.gd
func _parse(
	file_path: String,
	id_column: String = "id",
	delimiter: String = ","
) -> Dictionary:
	var file = FileAccess.open(file_path, FileAccess.READ)

	var dict_data: Dictionary = {}

	var line_index: int = -1
	var column_headers: PackedStringArray
	while not file.eof_reached():
		line_index += 1
		var line: PackedStringArray = file.get_csv_line(delimiter)

		if line_index == 0:
			column_headers = line
		else:
			var entry: Dictionary = {}
			for column_index in column_headers.size():
				var value = line[column_index]

				# Detect bools.
				if value is String:
					var value_lower: String = value.to_lower()
					if value_lower == "true":
						value = true
					elif value_lower == "false":
						value = false

				entry[column_headers[column_index]]	= value
				if column_headers[column_index] == id_column:
					dict_data[entry[id_column]] = entry
	file.close()
	return dict_data

## Translates the dictionary that was read from the CSV into objects for use in the game
func get_page_data_From_file_data(file_data: Dictionary):
	for key in file_data.keys():
		var row = file_data[key]
		var page = PageData.new()
		page.id = row.id
		page.title = row.title
		page.text = row.text
		page.image_path = row.image_path
		page.options = []
		for i in range (1,4): #adust number if you need more than 3 options
			if row["option_text" + str(i)] != "":
				var option = Option.new()
				option.target_id = row["option_target" + str(i)]
				option.text = row["option_text" + str(i)]
				page.options.append(option)
		page_data[key] = page

## go to the page associated with this ID
func go_to_page(id: String):
	for child in $Pages.get_children():
		$Pages.remove_child(child)
	var page = PAGE.instantiate()
	page.page_data = page_data[id]
	page.option_selected.connect(go_to_page)
	$Pages.add_child(page)
	
