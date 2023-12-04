package main

/*
* Advent of Code 2023
* Day 2: ⏹️ Cube Game 🕹️
* Michael Baucum
* Happy Holidays
* 🛸🎄❄️🎁🐟
 */

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

// The Elf would first like to know which games would have been possible
// if the bag contained only:
// 12 red cubes, 13 green cubes, and 14 blue cubes?

// Structs to store Game / Round Data
type Game struct {
	number int
	rounds []Round
}

type Round struct {
	red   int
	green int
	blue  int
}

func main() {
	// read the game records from the input file
	games := readFile("cubeGameRecords.txt")

	// Solution 1️⃣: Calculate the sum of the possible game numbers
	idSum := calculateSumOfPossibleGames(games, 12, 13, 14)
	fmt.Println("Solution 1: ", idSum)

	// Solution 2️⃣: Calculate the 'power of the minimum set' of cubes required to play all games ()
	powerOfMinimumSet := calculatePowerOfMinimumSet(games)
	fmt.Println("Solution 2: ", powerOfMinimumSet)
}

// Read the file and return a slice of strings (each is a game)
// Does more than just read the file... heheh 🤓
func readFile(fileName string) []Game {
	// Open the file
	file, err := os.Open(fileName)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close() // Will close the file at the end of the function

	scanner := bufio.NewScanner(file) // scanner to read the file line by line
	var games []Game                  // store our games

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text()) // Trim the line of any whitespace
		parts := strings.SplitN(line, ": ", 2)    // Split the line into two parts (game number and rounds). Parts is essentially the game.
		number, _ := strconv.Atoi(parts[0][5:])   // Skip the "Game " prefix
		roundsStr := strings.Split(parts[1], ";") // Split the rounds into a slice of strings
		var rounds []Round

		// Loop through each 'round' (roundsStr) and create a Round struct for that game.
		for _, roundStr := range roundsStr {
			round := Round{}
			cubes := strings.Split(roundStr, ",")
			for _, cube := range cubes {
				parts := strings.Fields(cube)             // Split the cube into the color and the count values
				cubeQuantity, _ := strconv.Atoi(parts[0]) // parts[0] is the quantity of the cubes
				switch parts[1] {                         // parts[1] is the color
				case "red":
					round.red = cubeQuantity
				case "green":
					round.green = cubeQuantity
				case "blue":
					round.blue = cubeQuantity
				}
			}
			rounds = append(rounds, round)
		}
		games = append(games, Game{number: number, rounds: rounds})
	}
	return games
}

// Check if a game is possible with the given number of colors / cubes
func isGamePossible(game Game, red, green, blue int) bool {
	for _, round := range game.rounds {
		if red < round.red || green < round.green || blue < round.blue {
			return false
		}
	}
	return true
}

// Part of Solution 1:
// Calculate the sum of possible game numbers
func calculateSumOfPossibleGames(games []Game, red, green, blue int) int {
	idSum := 0
	for _, game := range games {
		if isGamePossible(game, red, green, blue) {
			idSum += game.number
		}
	}
	return idSum
}

// Part of Solution 2:
// Calculate the power of the minimum set of cubes required to play all games
func calculatePowerOfMinimumSet(games []Game) int {
	roundMaximums := []Round{}   // create a slice of Round structs to store the maximums for each color, for each round, for each game...
	for _, game := range games { // iterate through each game
		maxRed, maxGreen, maxBlue := 0, 0, 0 // set our maximums to 0 each game
		for _, round := range game.rounds {  // iterate through each round for that game
			// Compare and set the maximums for each color accordingly:
			if round.red > maxRed {
				maxRed = round.red
			}
			if round.green > maxGreen {
				maxGreen = round.green
			}
			if round.blue > maxBlue {
				maxBlue = round.blue
			}
		}
		roundMaximums = append(roundMaximums, Round{red: maxRed, green: maxGreen, blue: maxBlue})
	}

	powerOfMinimumSet := 0
	for _, round := range roundMaximums {
		powerOfMinimumSet += round.red * round.green * round.blue // multiply the maximums of each color from each game
	}
	return powerOfMinimumSet
}
