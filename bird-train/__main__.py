import asyncio
import threading
from grpclib.server import Server
from rl_bird_env import RLBirdEnv
from rl_service import RLBirdService
from rlbird import Command, CommandCommandType


def start_grpc_server(loop, rl_service):
    """
    Run the gRPC server in a specified event loop.
    """
    asyncio.set_event_loop(loop)
    server = Server([rl_service])

    async def grpc_server():
        await server.start("127.0.0.1", 50051)
        print("gRPC server started on port 50051...")
        await server.wait_closed()

    loop.run_until_complete(grpc_server())


def start_env_loop(loop, rl_service):
    """
    Run the environment loop in a specified event loop.
    """
    asyncio.set_event_loop(loop)

    async def env_loop():
        env = RLBirdEnv(rl_service)

        state, _ = env.reset()
        print(f"Initial state: {state}")

        done = False
        while not done:
            action = env.action_space.sample()
            state, reward, done, info = env.step(action)

            print(f"Action: {action}, State: {state}, Reward: {reward}, Done: {done}")
            await asyncio.sleep(0.1)

        print("Environment loop finished.")

    loop.run_until_complete(env_loop())


if __name__ == "__main__":
    grpc_loop = asyncio.new_event_loop()
    env_loop = asyncio.new_event_loop()

    # Shared service instance
    rl_service = RLBirdService(grpc_loop)

    # Start threads
    grpc_thread = threading.Thread(
        target=start_grpc_server, args=(grpc_loop, rl_service)
    )
    env_thread = threading.Thread(target=start_env_loop, args=(env_loop, rl_service))

    grpc_thread.start()
    env_thread.start()

    grpc_thread.join()
    env_thread.join()

    print("All threads have completed.")
