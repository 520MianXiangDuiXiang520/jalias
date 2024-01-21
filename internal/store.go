package internal

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path"
	"strings"
)

func getStorePath(arg string) string {
	storePath := os.Getenv(EnvStorePath)
	//first := arg[0]
	//if first > 'z' || first < 'a' {
	//	panic("the key mast in [a-z]")
	//}
	return path.Join(storePath, fmt.Sprintf(".JAlian_%s.data", "all"))
}

func getKeysPath() string {
	storePath := os.Getenv(EnvStorePath)
	return path.Join(storePath, ".keys.data")
}

func parseStore(key string) (dict map[string]string, err error) {
	dataFile := getStorePath(key)
	data, err := os.ReadFile(dataFile)
	if err != nil {
		return nil, err
	}

	err = json.Unmarshal(data, &dict)
	if err != nil {
		return nil, err
	}
	return dict, nil
}

func formatStore(key string, d map[string]string) error {
	dataFile := getStorePath(key)
	data, err := json.Marshal(d)
	if err != nil {
		return err
	}
	err = os.WriteFile(dataFile, data, 0666)
	if err != nil {
		return err
	}
	keyFile := getKeysPath()
	keys := MapKeys(d)
	return os.WriteFile(keyFile, []byte(strings.Join(keys, "/ ")), 0666)
}

func Load(key string) string {
	dict, err := parseStore(key)
	if err != nil {
		panic("fail to read store " + err.Error())
	}

	val := dict[key]
	return val
}

func LoadKeys() string {
	data, err := os.ReadFile(getKeysPath())
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		panic("fail to read store " + err.Error())
	}
	return string(data)
}

func Store(k, v string, del bool) {
	dict, err := parseStore(k)
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		panic("fail to read store " + err.Error())
	}
	if dict == nil {
		if del {
			return
		}
		dict = map[string]string{}
	}
	_, ok := dict[k]
	if !ok && del {
		return
	}
	if del {
		delete(dict, k)
	} else {
		dict[k] = v
	}
	if formatStore(k, dict) != nil {
		panic("fail to store " + err.Error())
	}
}

func Clean() {
	storePath := os.Getenv(EnvStorePath)
	_ = os.RemoveAll(storePath)
}
