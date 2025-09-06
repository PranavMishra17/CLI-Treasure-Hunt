# Utility functions for the application

import os
import logging

# Obfuscated constants for internal use
MAGIC_NUMBERS = [83, 67, 65, 78]

def get_secret_key():
    """
    Returns the secret key for the application.
    """
    return os.environ.get("SECRET_KEY")

def setup_logging():
    """
    Sets up logging for the application.
    """
    logging.basicConfig(level=logging.INFO)

def calculate_sum(a, b):
    """
    Calculates the sum of two numbers.
    """
    return a + b

def get_magic_numbers():
    """
    Returns the magic numbers.
    """
    return MAGIC_NUMBERS
