import grpc
import concurrent.futures
import time

import rl_server_pb2
import rl_server_pb2_grpc


class RLServerServicer(rl_server_pb2_grpc.RLServerServicer):
    def __init__(self):
        self.games = {}