import asyncio
import sys
import threading
from pathlib import Path

import numpy as np

repo = Path(r"D:\RoboDojo_Workspace\RoboDojo")
sys.path.insert(0, str(repo))
sys.path.insert(0, str(repo / "XPolicyLab"))

from XPolicyLab.policy.demo_policy.model import Model
from client_server.ws.model_server import PolicyServer, PolicyServerConfig
from client_server.ws.model_client import WsModelClient

model = Model({
    "action_type": "joint",
    "env_cfg_type": "arx_x5",
})

server = PolicyServer(
    model,
    PolicyServerConfig(host="127.0.0.1", port=0),
)

loop = asyncio.new_event_loop()
thread = threading.Thread(target=loop.run_forever, daemon=True)
thread.start()

try:
    asyncio.run_coroutine_threadsafe(
        server.start(), loop
    ).result(timeout=30)

    print("[SERVER] Listening:", server.url)

    with WsModelClient(
        url=server.url,
        evaluation_id="local_preflight",
        trial_id="stack_bowls_test",
        action_case_id="stack_bowls_case",
        connect_timeout_s=10,
        request_timeout_s=15,
    ) as client:

        print("PASS: WebSocket connection and handshake")

        client.call(func_name="reset")
        print("PASS: remote policy reset")

        obs = {
            "instruction": "Stack the three bowls together.",
            "vision": {},
            "state": {},
            "action": {},
            "data_format_version": "v1.0",
        }

        client.call(func_name="update_obs", obs=obs)
        print("PASS: observation transmission")

        actions = client.call(func_name="get_action")

        expected = {
            "left_arm_joint_state": 6,
            "right_arm_joint_state": 6,
            "left_ee_joint_state": 1,
            "right_ee_joint_state": 1,
        }

        assert isinstance(actions, list)
        assert len(actions) == 2

        for action in actions:
            assert set(action) == set(expected)
            for key, dimension in expected.items():
                assert np.asarray(action[key]).shape == (dimension,)

        print("PASS: action transmission and dimensions")
        print("PASS: real WebSocket policy communication")

finally:
    try:
        asyncio.run_coroutine_threadsafe(
            server.stop(), loop
        ).result(timeout=15)
    finally:
        loop.call_soon_threadsafe(loop.stop)
        thread.join(timeout=5)
        if not thread.is_alive():
            loop.close()
