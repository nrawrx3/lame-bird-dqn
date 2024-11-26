gen-rl-server-proto:
	python -m grpc_tools.protoc -I ./protos/ --python_betterproto_out=./bird-train protos/rlbird.proto


.PHONY: gen-rl-server-proto

