package main

import (
	"fmt"
	"os"
	"os/exec"
	"path"
	"strings"
)

func main() {
	line, ok := os.LookupEnv("COMP_LINE")
	if !ok {
		return
	}
	args := strings.Split(line, " ")

	switch len(args) {
	// devc --init || devc <container>
	case 2:
		// devc --init
		if __init(args[1]) {
			return
		}
		// devc <container>
		container(args[1])
		return
	// devc --init <container> || devc <container> <mount>
	case 3:
		// devc --init <container>
		if args[1] == "--init" {
			container(args[2])
			return
		}
		// devc <container> <mount>
		volume(args[2])
		return
	// devc --init <container> <mount>
	case 4:
		volume(args[3])
	}
}

func __init(prefix string) bool {
	if prefix != "" && strings.HasPrefix("--init", prefix) {
		fmt.Println("--init")
		return true
	}
	return false
}

func container(prefix string) {
	out, err := exec.Command("docker", "ps", "-a", "--format", "{{.Names}}").Output()
	if err != nil {
		return
	}
	names := strings.Split(string(out), "\n")
	for _, name := range names {
		if strings.HasPrefix(name, prefix) {
			fmt.Println(name)
		}
	}
}

func volume(prefix string) {
	home, err := os.UserHomeDir()
	if err != nil {
		return
	}
	files, err := os.ReadDir(path.Join(home, "devc"))
	if err != nil {
		return
	}
	names := make([]string, len(files))
	for i, f := range files {
		names[i] = f.Name()
	}
	for _, name := range names {
		if strings.HasPrefix(name, prefix) {
			fmt.Println(name)
		}
	}
}
