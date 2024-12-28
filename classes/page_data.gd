class_name PageData extends Resource
# unique identifier for each page
var id: String
# heading visible at the top of the page
var title: String
# the main body text of this page
var text: String
# the path to the image displayed on this page, ex: "res://images/test image.png". Optional
var image_path: String
# An array of the buttons that will be displayed at the bottom of the page.
# What they will say, and the ID of the page they will go to.
var options: Array
