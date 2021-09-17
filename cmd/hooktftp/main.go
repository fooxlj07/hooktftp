package main

import "os"

import hooktftp "github.com/fooxlj07/hooktftp/internal"

func main() {
	os.Exit(hooktftp.HookTFTP())
}
