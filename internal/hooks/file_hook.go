package hooks

import (
	"os"
	"regexp"

	"github.com/fooxlj07/hooktftp/internal/config"
	tftp "github.com/fooxlj07/libgotftp/src"
)

var pathEscape = regexp.MustCompile("\\.\\.\\/")

var FileHook = HookComponents{
	func(path string, _ tftp.Request) (*HookResult, error) {
		file, err := os.Open(path)
		if err != nil {
			return nil, err
		}

		// get the file size
		stat, err := file.Stat()
		if err != nil {
			return nil, err
		}
		return newHookResult(file, nil, int(stat.Size()), nil), nil
	},
	func(s string, _ config.HookExtraArgs) (string, error) {
		return pathEscape.ReplaceAllLiteralString(s, ""), nil
	},
}
