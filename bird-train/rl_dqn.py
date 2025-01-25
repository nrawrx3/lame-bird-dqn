import torch
import torch.nn as nn
import numpy as np
from rl_service import RLBirdService
import gymnasium as gym
from stable_baselines3 import DQN
from stable_baselines3.common.env_util import make_vec_env

MODEL_SAVE_FILE = "dqn_rl_bird"
TENSORBOARD_LOGS_DIR = "logs/dqn_rl_bird"


def register_rlbird_env():
    gym.envs.register(
        id="RLBird-v0",
        entry_point="rl_bird_env:RLBirdEnv",
        max_episode_steps=500,  # Adjust based on your game's episode length
    )


def train_sb3_dqn(rl_service: RLBirdService):
    register_rlbird_env()

    env = gym.make("RLBird-v0", rl_service=rl_service)

    vec_env = make_vec_env(lambda: env, n_envs=1)

    model = DQN(
        "MlpPolicy",
        vec_env,
        learning_rate=1e-3,
        buffer_size=1000,
        batch_size=64,
        gamma=0.99,  # Discount factor
        train_freq=4,  # Train every 4 steps
        target_update_interval=1000,  # Update target network every 1000 steps
        verbose=1,
        tensorboard_log=TENSORBOARD_LOGS_DIR,
    )

    print("Training model...", model.policy)

    model.learn(total_timesteps=50000)

    model.save("dqn_rl_bird")

    print(f"Training complete! Model saved as {MODEL_SAVE_FILE}.")