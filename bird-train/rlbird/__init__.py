# Generated by the protocol buffer compiler.  DO NOT EDIT!
# sources: rlbird.proto
# plugin: python-betterproto
# This file has been @generated

from dataclasses import dataclass
from typing import (
    TYPE_CHECKING,
    Dict,
    List,
    Optional,
)

import betterproto
import grpclib
from betterproto.grpc.grpclib_server import ServiceBase


if TYPE_CHECKING:
    import grpclib.server
    from betterproto.grpc.grpclib_client import MetadataLike
    from grpclib.metadata import Deadline


class CommandCommandType(betterproto.Enum):
    NOOP = 0
    ACTION_JUMP = 1
    CREATE_NEW_GAME = 2


@dataclass(eq=False, repr=False)
class GetNextCommandRequest(betterproto.Message):
    pass


@dataclass(eq=False, repr=False)
class SetCommandResultRequest(betterproto.Message):
    command_result: "CommandResult" = betterproto.message_field(1)


@dataclass(eq=False, repr=False)
class SetCommandResultResponse(betterproto.Message):
    pass


@dataclass(eq=False, repr=False)
class Command(betterproto.Message):
    command_type: "CommandCommandType" = betterproto.enum_field(1)
    action_jump_command: "ActionJumpCommandData" = betterproto.message_field(
        2, group="data"
    )
    create_new_game_command: "CreateNewGameCommandData" = betterproto.message_field(
        3, group="data"
    )


@dataclass(eq=False, repr=False)
class CreateNewGameCommandData(betterproto.Message):
    """Ignored. We're hardcoding this in the game side."""

    game_world_bounds: "GameWorldBounds" = betterproto.message_field(1)
    difficulty_params: "DifficultyParams" = betterproto.message_field(2)


@dataclass(eq=False, repr=False)
class ActionJumpCommandData(betterproto.Message):
    jump_force: float = betterproto.double_field(1)


@dataclass(eq=False, repr=False)
class GameWorldBounds(betterproto.Message):
    view_width: float = betterproto.double_field(1)
    view_height: float = betterproto.double_field(2)
    min_wall_gap: float = betterproto.double_field(3)


@dataclass(eq=False, repr=False)
class DifficultyParams(betterproto.Message):
    """
    The model training does not care about these parameters except the
    pentalty. We're sending these to the Python client just to create logs.
    """

    ball_max_velocity: float = betterproto.double_field(1)
    ball_starting_velocity: float = betterproto.double_field(2)
    disable_camera_tilt: bool = betterproto.bool_field(3)
    ball_nudge_velocity: float = betterproto.double_field(4)
    noise_scale: float = betterproto.double_field(5)
    g: float = betterproto.double_field(6)
    bad_wall_invisible_probability: float = betterproto.double_field(7)
    max_wall_height: float = betterproto.double_field(8)
    min_wall_height: float = betterproto.double_field(9)
    bad_wall_penalty: int = betterproto.int32_field(10)
    max_wall_width: float = betterproto.double_field(11)
    min_wall_width: float = betterproto.double_field(12)
    ball_radius: float = betterproto.double_field(13)


@dataclass(eq=False, repr=False)
class GameState(betterproto.Message):
    ball_state: "BallState" = betterproto.message_field(1)
    visible_walls_state: "VisibleWallsState" = betterproto.message_field(2)
    wall_collisions: List["WallCollision"] = betterproto.message_field(3)
    time: float = betterproto.double_field(4)


@dataclass(eq=False, repr=False)
class WallCollision(betterproto.Message):
    wall: "Wall" = betterproto.message_field(1)
    ball_state: "BallState" = betterproto.message_field(2)


@dataclass(eq=False, repr=False)
class BallState(betterproto.Message):
    x: float = betterproto.double_field(1)
    y: float = betterproto.double_field(2)
    vx: float = betterproto.double_field(3)
    vy: float = betterproto.double_field(4)
    ax: float = betterproto.double_field(5)
    ay: float = betterproto.double_field(6)


@dataclass(eq=False, repr=False)
class VisibleWallsState(betterproto.Message):
    walls: List["Wall"] = betterproto.message_field(1)


@dataclass(eq=False, repr=False)
class Wall(betterproto.Message):
    x: float = betterproto.double_field(1)
    y: float = betterproto.double_field(2)
    width: float = betterproto.double_field(3)
    height: float = betterproto.double_field(4)
    points: float = betterproto.double_field(5)


@dataclass(eq=False, repr=False)
class CommandResult(betterproto.Message):
    game_state: "GameState" = betterproto.message_field(1)
    game_over: bool = betterproto.bool_field(2)
    reward: float = betterproto.double_field(3)


class RlBirdServerStub(betterproto.ServiceStub):
    async def get_next_command(
        self,
        get_next_command_request: "GetNextCommandRequest",
        *,
        timeout: Optional[float] = None,
        deadline: Optional["Deadline"] = None,
        metadata: Optional["MetadataLike"] = None
    ) -> "Command":
        return await self._unary_unary(
            "/rlbird.RLBirdServer/GetNextCommand",
            get_next_command_request,
            Command,
            timeout=timeout,
            deadline=deadline,
            metadata=metadata,
        )

    async def set_command_result(
        self,
        set_command_result_request: "SetCommandResultRequest",
        *,
        timeout: Optional[float] = None,
        deadline: Optional["Deadline"] = None,
        metadata: Optional["MetadataLike"] = None
    ) -> "SetCommandResultResponse":
        return await self._unary_unary(
            "/rlbird.RLBirdServer/SetCommandResult",
            set_command_result_request,
            SetCommandResultResponse,
            timeout=timeout,
            deadline=deadline,
            metadata=metadata,
        )


class RlBirdServerBase(ServiceBase):

    async def get_next_command(
        self, get_next_command_request: "GetNextCommandRequest"
    ) -> "Command":
        raise grpclib.GRPCError(grpclib.const.Status.UNIMPLEMENTED)

    async def set_command_result(
        self, set_command_result_request: "SetCommandResultRequest"
    ) -> "SetCommandResultResponse":
        raise grpclib.GRPCError(grpclib.const.Status.UNIMPLEMENTED)

    async def __rpc_get_next_command(
        self, stream: "grpclib.server.Stream[GetNextCommandRequest, Command]"
    ) -> None:
        request = await stream.recv_message()
        response = await self.get_next_command(request)
        await stream.send_message(response)

    async def __rpc_set_command_result(
        self,
        stream: "grpclib.server.Stream[SetCommandResultRequest, SetCommandResultResponse]",
    ) -> None:
        request = await stream.recv_message()
        response = await self.set_command_result(request)
        await stream.send_message(response)

    def __mapping__(self) -> Dict[str, grpclib.const.Handler]:
        return {
            "/rlbird.RLBirdServer/GetNextCommand": grpclib.const.Handler(
                self.__rpc_get_next_command,
                grpclib.const.Cardinality.UNARY_UNARY,
                GetNextCommandRequest,
                Command,
            ),
            "/rlbird.RLBirdServer/SetCommandResult": grpclib.const.Handler(
                self.__rpc_set_command_result,
                grpclib.const.Cardinality.UNARY_UNARY,
                SetCommandResultRequest,
                SetCommandResultResponse,
            ),
        }
