GOBUILD = go build -ldflags="-s -w"

build:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o ./bin/_jalias_darwin_amd64 ./cmd
	GOOS=darwin GOARCH=arm64 $(GOBUILD) -o ./bin/_jalias_darwin_arm64 ./cmd
	GOOS=linux GOARCH=386 $(GOBUILD) -o ./bin/_jalias_linux_386 ./cmd
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o ./bin/_jalias_linux_amd64 ./cmd
	GOOS=linux GOARCH=arm64 $(GOBUILD) -o ./bin/_jalias_linux_arm64 ./cmd
	# GOOS=windows GOARCH=386 $(GOBUILD) -o ./bin/_jalias_windows_386 ./cmd
	# GOOS=windows GOARCH=amd64 $(GOBUILD) -o ./bin/_jalias_windows_amd64 ./cmd
	# GOOS=windows GOARCH=arm $(GOBUILD) -o ./bin/_jalias_windows_arm ./cmd
	# GOOS=windows GOARCH=arm64 $(GOBUILD) -o ./bin/_jalias_windows_arm64 ./cmd

clean:
	rm -rf ./bin/*

zsh_install:
	source ./scripts/install.sh