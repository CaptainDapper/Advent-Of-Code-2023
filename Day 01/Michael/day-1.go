package main

/*
* Advent of Code 2023
* Day 1: Calibration Codes
* Michael Baucum
* Happy Holidays
* 🛸🎄❄️🎁
*/

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"unicode"
)

func main() {

	// Grab the calibration codes from the file
	jumbledCodes := grabCalibrationCodes()

	// Solution 1️⃣:
	numberCodes := grabNumberCodes(jumbledCodes)
	printSum(numberCodes)

	// Solution 2️⃣:
	numberCodes2 := grabNumberCodes(convertWordsToNumbers(jumbledCodes))
	printSum(numberCodes2)
}

// Turns each line from the file into a string in a slice of strings
func grabCalibrationCodes() []string {
	calibrationCodes := []string{}

	// Open the file.
	f, _ := os.Open("calibration-codes.txt")

	// Create a new Scanner for the file.
	scanner := bufio.NewScanner(f)

	for scanner.Scan() {
		line := scanner.Text()
		calibrationCodes = append(calibrationCodes, line)
	}

	// Close the file when finished
	f.Close()

	return calibrationCodes
}

// Grab the codes (first/last numbers) from each line of the file.
// Returns a slice of ints
func grabNumberCodes(jumbledCodes []string) []int {
	numberCodes := []int{}

	for _, singleCode := range jumbledCodes {
		singleCodeNumbers := ""
		for _, v := range singleCode {
			if unicode.IsDigit(v) {
				singleCodeNumbers += string(v)
			}
		}
		strCode := string(singleCodeNumbers[0]) + string(singleCodeNumbers[len(singleCodeNumbers)-1])
		intCode, _ := strconv.Atoi(strCode)
		numberCodes = append(numberCodes, intCode)
	}

	return numberCodes
}

// Take the codes and convert written numbers to their numbers
// Returns as a slice of strings
func convertWordsToNumbers(jumbledCodes []string) []string {

	// Map the numbered words to their replacement values:
	// The replacement values will keep the integrity of surrounding
	// written numbers (endings/beginnings).

	// Thanks for the idea:
	// @Sloan 🔥🧠🍕

	numberMap := map[string]string{
		"zero":  "0o",
		"one":   "o1e",
		"two":   "t2o",
		"three": "t3e",
		"four":  "4",
		"five":  "5e",
		"six":   "s6",
		"seven": "7n",
		"eight": "e8t",
		"nine":  "n9e",
	}

	//strings.ReplaceAll(string, oldValue, newValue)

	for i := range jumbledCodes { // iterate through each line of the codes file
		for numberKey := range numberMap { // iterate through the map key/value
			if strings.Contains(jumbledCodes[i], numberKey) {
				jumbledCodes[i] = strings.ReplaceAll(jumbledCodes[i], numberKey, numberMap[numberKey])
			}
		}
	}

	return jumbledCodes
}

// Print the sum of the codes
func printSum(numberCodes []int) {
	sum := 0
	for i := range numberCodes {
		sum += numberCodes[i]
	}
	fmt.Println(sum)
}
