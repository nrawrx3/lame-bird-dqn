gen-rl-server-proto:
	python -m grpc_tools.protoc -I ./protos/ --python_betterproto_out=./bird-train protos/rlbird.proto


gen-rl-client-proto:
	protoc --dart_out=grpc:bird-game/lib/generated -I ./protos/ protos/rlbird.proto


.PHONY: gen-rl-server-proto

.PHONY: gen-rl-client-proto

