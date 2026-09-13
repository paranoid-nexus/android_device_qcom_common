#!/usr/bin/env python3

import os
import sys
import subprocess

script_dir = os.path.dirname(os.path.abspath(__file__))
extract_utils_path = os.path.join(script_dir, "tools", "extract_utils_qti")
os.environ["PYTHONPATH"] = extract_utils_path + os.pathsep + os.environ.get("PYTHONPATH", "")

for root, dirs, files in os.walk("."):
    if "setup-makefiles.py" in files:
        print(f"Running {os.path.join(root, 'setup-makefiles.py')}")
        subprocess.run([sys.executable, "setup-makefiles.py"], cwd=root, check=False)
