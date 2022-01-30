"""Context for the cli group"""

import click


class Context:
    """Context shared between all command groups

    Attributes:
        flags_dict: A dictionary containing the flags of a command
    """

    def __init__(self):
        self.flags_dict = {}


pass_context = click.make_pass_decorator(Context, ensure=True)
