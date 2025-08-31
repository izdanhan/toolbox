#!/usr/bin/env python3
"""
Basic Python script template with argparse and logging.
"""

import argparse
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def main():
    parser = argparse.ArgumentParser(description="Template script")
    parser.add_argument("--name", "-n", help="Your name", default="World")
    args = parser.parse_args()

    logging.info("Script started")
    print(f"Hello, {args.name}!")
    logging.info("Script finished")

if __name__ == "__main__":
    main()
