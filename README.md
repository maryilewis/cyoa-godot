# Choose your own Godoture

A short project made in godot 4.3 by Mary Lewis one Saturday morning. Feel free to use this as a starting point for your own project.

## How to Use

Open with Godot 4.3 (or latest 4.x, probably)

### Make your own pages

I chose to store page data in a CSV because I like being able to view all the pages at once, and I only had to make one page scene. CSV stands for "comma-separated values", and it's basically a simple text version of a spreadsheet.

Open up `data/example_data.csv` and take a look. Each row is the data for one page. You might not be able to open it in Godot (Godot seems to think it's a malformed translation file), but any other text editor (VSCode, Notepad++) or spreadsheet viewer (Excel, etc) will work. Just make sure you always save as CSV.

* id: This must be unique; each row must have a different id.
* title: Title displayed at the top of the page. Supports bbcode
* text: The main body of text. Supports bbcode. If you need to have commas in your text, make sure to surround this with quotes ""
* image_path: The location of the illustration for the page. This location must be inside your project. I put mine in the images folder. Example: `res://images/kitchen.png`
* Up to 3 options. Each option has `option_text` and `option_target`. The option text is the words that show on the buttons. The option target is the page that button will take you to. **The option_target must exactly match the id of the page you want that option to lead to.**

If you want to add more than 3 options to a page, add more columns following the same pattern (option_text4 etc), and in `res://scenes/game/game.gd` find this line: `		for i in range (1,4): #adust number if you need more than 3 options` and change the "4" to one more than the number of options you want. If you are using a text editor, make sure each row gets the right number of trailing commas or you will get an error.

### Change the "page" format

To change layout, open up "scenes/page/page.tscn" and have at it. Just make sure you're updating the references in "scenes/page/page.gd" at the same time.

To change appearance, add a theme to the root node of the project and go nuts!

## Additional notes

When exporting, be sure to include your csv file in the files that need to be bundled into the export. `Project > Export > Resources Tab > Filters to Export non-resource...`
