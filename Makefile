proto:
	protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		helloworld/helloworld.proto
build:
	GOOS=linux GOARCH=amd64 go build -o server ./greeter_server
	podman build -f Dockerfile --platform=linux/amd64 -t docker.io/imroc/grpc_server:latest
	podman push docker.io/imroc/grpc_server:latest
	rm server
rsync:
	rsync -av ./ dev:/root/grpc-demo
restart:
	kubectl rollout restart deployments.v1.apps/server