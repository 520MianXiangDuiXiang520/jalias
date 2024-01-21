package main

import (
	"fmt"
	"github.com/520MianXiangDuiXiang520/jalias/internal"
	"os"
	"strings"
)

func setAlias(args []string, del bool) {
	if (!del && len(args) < 3) || (del && len(args) < 2) {
		panic("bad args" + strings.Join(args, " "))
	}

	key := args[1]
	key = strings.ToLower(key)
	value := ""
	if !del {
		value = args[2]
	}
	internal.Store(key, value, del)
	fmt.Println(value)
}

func aliasReplace(args []string) {
	for i, arg := range args {
		arg = strings.TrimSpace(arg)
		if arg == "" {
			continue
		}
		if strings.HasPrefix(arg, "-") {
			continue
		}
		paths := strings.Split(arg, "/")
		first := strings.ToLower(paths[0])
		alias := internal.Load(first)
		if alias != "" {
			args[i] = alias + arg[len(first):]
			break
		}
	}
	fmt.Println(strings.Join(args, " "))
}

func main() {
	args := os.Args
	if len(args) <= 1 {
		panic("bad args!!!")
	}

	common := args[1]
	switch common {
	case "add", "+":
		setAlias(args[1:], false)
	case "del", "-":
		setAlias(args[1:], true)
	case "__JAliasKeys":
		fmt.Println(internal.LoadKeys())
	case "__JAliasClean":
		internal.Clean()
	default:
		aliasReplace(args[1:])
	}
}
