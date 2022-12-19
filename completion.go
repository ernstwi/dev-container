package main

import (
	"fmt"
	"os"
	"path"
	"strings"
)

func main() {
	home, err := os.UserHomeDir()
	if err != nil {
		return
	}
	files, err := os.ReadDir(path.Join(home, "devc"))
	if err != nil {
		return
	}
	line, ok := os.LookupEnv("COMP_LINE")
	if !ok {
		return
	}
	for _, file := range files {
		if strings.HasPrefix("devc "+file.Name(), line) {
			fmt.Println(file.Name())
		}
	}
}
