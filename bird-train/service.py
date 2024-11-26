import asyncio
from grpclib.server import Server

from rlbird import (
    RlBirdServerBase,
    RlBirdServerStub,
    GetNextCommandRequest,
    SendCommandResponseRequest,
    Command,
    CommandCommandType,
)


class RLBirdService(RlBirdServerBase):
    async def get_next_command(self, request: GetNextCommandRequest) -> Command:
        print(f"GetNextCommand: {request}")
        command = Command(
            command_type=CommandCommandType.NOOP, action_jump_command=None
        )
        return command

    async def send_command_response(self, request: SendCommandResponseRequest) -> None:
        print(f"SendCommandResponse: {request}")


async def main():
    server = Server([RLBirdService()])
    await server.start("127.0.0.1", 50051)
    print("Server started, listening on port 50051...")
    await server.wait_closed()


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        pass
