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
	--go-grpc_opt=module=${GO_MODULE} --go-grpc_out=. \
	./proto/personal/productservice/*.proto 

.PHONY: build
build: clean protoc-go


.PHONY: pipeline-init
pipeline-init:
	sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
.PHONY: pipeline-build
pipeline-build: pipeline-init build