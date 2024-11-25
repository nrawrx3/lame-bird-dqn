gen-rl-server-proto: protos/rl_server.proto
	python -m grpc_tools.protoc -I ./protos/ --python_out=./bird-train --grpc_python_out=./bird-train ./protos/rl_server.proto
