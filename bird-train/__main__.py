from service import RLBirdService
from grpclib.server import Server
from rl_bird_env import RLBirdEnv
import asyncio, threading
import nest_asyncio
import signal
from sys import exit

nest_asyncio.apply()


def shutdown_event_loop(loop, rl_service, grpc_thread):
    print("\nShutting down gracefully...")
    rl_service.shutdown()  # Custom method to clean up RLBirdService resources if needed
    loop.stop()
    print("Shutdown complete.")
    exit(1)


async def run_env_loop(rl_service: RLBirdService):
    env = RLBirdEnv(rl_service)

    print("Resetting the environment...")
    # Reset the environment
    state, _ = await asyncio.create_task(env.reset())

    print('Starting the step loop...')

    done = False
    while not done:
        action = env.action_space.sample()  # Random action
        state, reward, done, _ = await asyncio.create_task(env.step(action))
        print(f"State: {state}, Reward: {reward}, Done: {done}")


async def run_grpc_server(rl_service: RLBirdService):
    server = Server([rl_service])  # Use the shared instance
    await server.start("127.0.0.1", 50051)
    print("gRPC server started on port 50051...")
    await server.wait_closed()


if __name__ == "__main__":
    # Create a shared instance of RLBirdService
    shared_rl_service = RLBirdService()

    # Function to run the gRPC server
    def run_grpc_server_thread():
        asyncio.run(run_grpc_server(shared_rl_service))

    # Start the gRPC server in a separate thread
    grpc_thread = threading.Thread(target=run_grpc_server_thread, daemon=True)
    grpc_thread.start()

    # Run the environment loop in the main thread
    try:
        loop = asyncio.get_event_loop()

        def signal_handler(sig, frame):
            shutdown_event_loop(loop, shared_rl_service, grpc_thread)

        # Register signal handler for graceful shutdown
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)

        # Run the environment loop
        loop.run_until_complete(run_env_loop(shared_rl_service))
    except KeyboardInterrupt:
        shutdown_event_loop(loop, shared_rl_service, grpc_thread)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        shutdown_event_loop(loop, shared_rl_service, grpc_thread)
