import asyncio
from asyncio import Queue
from grpclib.server import Server
# from typing import override
from compat import override

from rlbird import (
    RlBirdServerBase,
    GetNextCommandRequest,
    SetCommandResultRequest,
    SetCommandResultResponse,
    Command,
    CommandResult,
    CommandCommandType,
)


class RLBirdService(RlBirdServerBase):
    def __init__(self, loop: asyncio.AbstractEventLoop) -> None:
        super().__init__()

        self.loop = loop
        self._next_command_queue = Queue[Command](maxsize=5)
        self._command_result_queue = Queue[CommandResult](maxsize=5)

    @override
    async def get_next_command(self, request: GetNextCommandRequest) -> Command:
        print(f"rpc GetNextCommand: {request}")

        command = await self._next_command_queue.get()

        print(
            f"rpc GetNextCommand: sending command {str(command.command_type)} to the game..."
        )
        return command

    @override
    async def set_command_result(
        self,
        request: SetCommandResultRequest,
    ) -> SetCommandResultResponse:
        print(f"rpc SetCommandResult: {request.command_result}")

        await self._command_result_queue.put(request.command_result)

        print("rpc SetCommandResult: done setting command result.")
        return SetCommandResultResponse()

    # Stores the next command to be sent to the game via the get_next_command rpc.
    async def push_next_command(self, command: Command):
        print(f"Pushing next command (async): {str(command.command_type)}")

        await self._next_command_queue.put(command)

        print("Done pushing next command (async).")

    async def pop_result(self) -> CommandResult:
        print("pop_result: blocking...")
        command_result = await self._command_result_queue.get()

        print(
            f"pop_result: unblocked, returning [{command_result.start_frame} .. {command_result.end_frame}] frames"
        )

        return command_result

    def shutdown(self):
        # Add cleanup logic here, e.g., close connections, stop threads, etc.
        print("Cleaning up RLBirdService resources...")
