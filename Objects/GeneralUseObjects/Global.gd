extends Node

var totalLevels = 0

var audioController

#Variable to control the color of the charater

var bodyColor : Color
var shoesColor : Color

func _ready():
	randomize()
	bodyColor = Color(randf(), randf(), randf())
	shoesColor = Color(randf(), randf(), randf())


#Variables to control the Slate text

#var messageArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]

var messages = { 0 : "This is a text. Later, important things will be written here.",
				1 : "This is a text. Later, important things will be written here.",
				2 : "This is a text. Later, important things will be written here.",
				3 : "This is a text. Later, important things will be written here.",
				4 : "This is a text. Later, important things will be written here.",
				5 : "This is a text. Later, important things will be written here.",
				6 : "This is a text. Later, important things will be written here.",
				7 : "This is a text. Later, important things will be written here.",
				8 : "This is a text. Later, important things will be written here.",
				9 : "This is a text. Later, important things will be written here.",
				10 : "This is a text. Later, important things will be written here.",
				11 : "This is a text. Later, important things will be written here.",
				12 : "This is a text. Later, important things will be written here.",
				13 : "This is a text. Later, important things will be written here.",
				14 : "This is a text. Later, important things will be written here.",
				15 : "This is a text. Later, important things will be written here.",
				16 : "This is a text. Later, important things will be written here.",
				17 : "This is a text. Later, important things will be written here.",
				18 : "This is a text. Later, important things will be written here.",
				19 : "This is a text. Later, important things will be written here."
}

#variables to control credits

var credits = { "gateway" : "",
				"computer" : ""
}

var credit = ""