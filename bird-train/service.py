import asyncio
import grpclib
from grpclib.server import Server
from typing import override

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
    def __init__(self) -> None:
        super().__init__()

        self._next_command_event = asyncio.Event()
        self._command_result_event = asyncio.Event()

        # Shared state
        self._next_command = None
        self._command_result = None

    @override
    async def get_next_command(self, request: GetNextCommandRequest) -> Command:
        print(f"GetNextCommand: {request}")

        # Wait for the next command to be set by the agent
        await self._next_command_event.wait()

        # Clear the event for the subsequent commands
        self._next_command_event.clear()

        print(f'Sending command {str(self._next_command.command_type)} to the game...')
        return self._next_command

    @override
    async def set_command_result(
        self,
        request: SetCommandResultRequest,
    ) -> SetCommandResultResponse:
        print(f"SetCommandResult: {request.command_result}")

        self._command_result = request.command_result
        self._command_result_event.set()

        print("Done setting command result.")
        return SetCommandResultResponse()

    # Stores the next command to be sent to the game via the get_next_command rpc.
    def set_next_command(self, command: Command):
        print(f"Setting next command to be sent: {str(command.command_type)}")

        self._next_command = command
        self._next_command_event.set()

        print("Done setting next command to be sent.")

    async def get_command_result(self) -> CommandResult:
        print("Waiting for the game to provide command result...")

        await self._command_result_event.wait()

        print('Received command result from the game.')

        self._command_result_event.clear()
        return self._command_result

    def shutdown(self):
        # Add cleanup logic here, e.g., close connections, stop threads, etc.
        print("Cleaning up RLBirdService resources...")
