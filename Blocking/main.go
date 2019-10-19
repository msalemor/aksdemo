package main

import (
	"flag"
	"fmt"
	"math"
	"os"
	"runtime"
	"strconv"
	"time"
)

func assingEnvValue(str string, intPtr *int) {
	if str != "" {
		i, err := strconv.Atoi(str)
		if err != nil {
			*intPtr = i
		}
	}
}

func main() {
	done := make(chan int)

	// Get the parameters from the command lines
	var waitPtr = flag.Int("wait", 5, "seconds to wait before blocking")
	var secPtr = flag.Int("time", 30, "seconds to block")
	var perPtr = flag.Int("per", 100, "target cpu percentace 25,50,75,100")
	flag.Parse()

	waitStr := os.Getenv("WAIT_TIME")
	timeStr := os.Getenv("TIME_AT_MAX")

	// Override the parameters from environment variables
	assingEnvValue(waitStr, waitPtr)
	assingEnvValue(timeStr, secPtr)

	// Wait before blocking
	fmt.Printf("Waiting %v seconds before blocking\n", *waitPtr)

	// Start blocking
	totalCpus := float64(runtime.NumCPU())
	perTotal := float64(*perPtr) / 100
	cpus := int(math.Ceil(totalCpus * perTotal))

	if cpus > int(totalCpus) {
		cpus = int(totalCpus)
	}

	if cpus < 1 {
		cpus = 1
	}

	fmt.Printf("Blocking for %v seconds. Number of CPUs: %v at %v%%\n", *secPtr, cpus, *perPtr)

	// Block every CPU in the system
	for i := 0; i < cpus; i++ {
		go func() {
			for {
				select {
				case <-done:
					return
				default:
				}
			}
		}()
	}

	// Wait for a period of time
	time.Sleep(time.Second * time.Duration(*secPtr))

	// Close the channel and exit the program
	close(done)
}
