build:
	go build -o ./bin/_jalias ./cmd

clean:
	rm -rf ./bin/*

zsh_install:
	source ./scripts/install.sh