# Replace this with your own github.com/<username>/<repository>
GO_MODULE := github.com/rizkysr90/my-protobuf

.PHONY: clean
clean:
ifeq ($(OS), Windows_NT)
	if exist "gen" rd /s /q gen
	mkdir gen\go
else
	rm -fR ./gen 
	mkdir -p ./gen/go
endif

.PHONY: protoc-go
protoc-go:
	protoc --go_opt=module=${GO_MODULE} --go_out=. \
	./proto/personal/productservice/*.proto 

.PHONY: build
build: clean protoc-go