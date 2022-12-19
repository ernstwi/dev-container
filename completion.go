package main

import (
	"fmt"
	"log"
	"os"
	"path"
	"strings"
)

func main() {
	home, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}
	files, err := os.ReadDir(path.Join(home, "devc"))
	if err != nil {
		log.Fatal(err)
	}

	line, ok := os.LookupEnv("COMP_LINE")
	if !ok {
		log.Fatal(err)
	}

	for _, file := range files {
		if strings.HasPrefix("devc "+file.Name(), line) {
			fmt.Println(file.Name())
		}
	}
}
