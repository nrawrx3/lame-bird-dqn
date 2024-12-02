import gymnasium as gym
from gymnasium import spaces
import numpy as np
from rlbird import (
    Command,
    CommandCommandType,
    ActionJumpCommandData,
    CreateNewGameCommandData,
    GameState,
    BallState,
    VisibleWallsState,
)
from rl_service import RLBirdService
import asyncio
# from typing import override
from compat import override

class RLTrainState:
    SAMPLING_ACTION = 0
    WAITING_FOR_ACTION_RESPONSE = 1
    WAITING_FOR_RESET_RESPONSE = 2


NUM_BALL_STATE = 6
NUM_WALL_STATE = 5
NUM_VISIBLE_WALLS = 10
OBSERVATION_STATE_SIZE = NUM_BALL_STATE + NUM_WALL_STATE * NUM_VISIBLE_WALLS

assert OBSERVATION_STATE_SIZE == 56  # Just a sanity check


def observation_space_from_game_state(game_state: GameState) -> np.array:
    point = np.zeros(OBSERVATION_STATE_SIZE, dtype=np.float32)

    bs = game_state.ball_state
    point[0] = bs.x
    point[1] = bs.y
    point[2] = bs.vx
    point[3] = bs.vy
    point[4] = bs.ax
    point[5] = bs.ay

    # TODO: Uncomment after implementing visible walls in game state
    # assert len(game_state.visible_walls_state.walls) == NUM_VISIBLE_WALLS

    # Take at most NUM_VISIBLE_WALLS walls
    visible_walls = game_state.visible_walls_state.walls[:NUM_VISIBLE_WALLS]

    for i, vws in enumerate(visible_walls):
        point[6 + i * 5] = vws.x
        point[7 + i * 5] = vws.y
        point[8 + i * 5] = vws.width
        point[9 + i * 5] = vws.height
        point[10 + i * 5] = vws.points

    return point


class RLBirdEnv(gym.Env):
    metadata = {"render.modes": ["human"]}

    game_command_queue = []

    def __init__(self, rl_service: RLBirdService):
        super(RLBirdEnv, self).__init__()
        self.rl_service = rl_service
        self.action_space = spaces.Discrete(2)  # 0: NOOP, 1: JUMP
        self.observation_space = spaces.Box(
            low=-np.inf, high=np.inf, shape=(OBSERVATION_STATE_SIZE,), dtype=np.float32
        )
        self.state = RLTrainState.WAITING_FOR_RESET_RESPONSE

    @override
    def reset(self):
        # Create the command to reset the game
        command = Command(
            command_type=CommandCommandType.CREATE_NEW_GAME,
            create_new_game_command=CreateNewGameCommandData(),
        )

        print("Pushing create new game command...")
        future = asyncio.run_coroutine_threadsafe(
            self.rl_service.push_next_command(command),
            # asyncio.get_running_loop(),
            self.rl_service.loop,
        )

        future.result()  # Wait for the command to be queued

        print("Done pushing create new game command.")

        # Wait for the result from the game
        future = asyncio.run_coroutine_threadsafe(
            self.rl_service.pop_result(),
            # asyncio.get_running_loop(),
            self.rl_service.loop,
        )
        command_result = future.result()  # Blocking call

        print(f"Received result from create new game command: {command_result}")

        # Process game state and return the observation
        game_state = command_result.game_state
        obs_point = observation_space_from_game_state(game_state)
        return obs_point, {}

    @override
    def step(self, action):
        print(f"Action: {action}")

        # Choose the command based on the action
        if action == 1:
            command = Command(
                command_type=CommandCommandType.ACTION_JUMP,
                action_jump_command=ActionJumpCommandData(jump_force=1.0),
            )
        else:
            command = Command(command_type=CommandCommandType.NOOP)

        # Push the command synchronously
        future = asyncio.run_coroutine_threadsafe(
            self.rl_service.push_next_command(command),
            # asyncio.get_running_loop(),
            self.rl_service.loop,
        )
        future.result()  # Wait for the command to be queued

        # Wait for the result from the game
        future = asyncio.run_coroutine_threadsafe(
            self.rl_service.pop_result(),
            # asyncio.get_running_loop(),
            self.rl_service.loop,
        )
        command_result = future.result()  # Blocking call

        # Process game state and return results
        game_state = command_result.game_state
        obs_point = observation_space_from_game_state(game_state)
        reward = command_result.reward
        done = command_result.game_over
        return obs_point, reward, done, {}
