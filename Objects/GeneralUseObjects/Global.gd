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

var messageArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]

var messages = { 0 : "EXODUS preparation complete",
				1 : "Photosensitive buttons in place",
				2 : "Warning: creatures escaped",
				3 : "Water as power implemented",
				4 : "Do not terminate creatures",
				5 : "Creatures helping kill spies",
				6 : "Project EXODUS online",
				7 : "Choose EXODUS members complete",
				8 : "Error: couldn't find reference",
				9 : "Year 5 report: failure",
				10 : "Year 9 report: gateway open",
				11 : "Scouting team lost",
				12 : "Tunnels set to dark",
				13 : "Use light to repel creatures",
				14 : "Recharge stations installed",
				15 : "All personal: keep lights on",
				16 : "Mission goal: find new home",
				17 : "Planet found: start EXODUS",
				18 : "EXODUS list: at capacity",
				19 : "Order: abandon Earth"
}

#variables to control credits

var credits = { "gateway" : "",
				"computer" : ""
}

var credit = ""