"""Main entrypoint to invoke CLI."""

import click
from zoracloud.cli.commands.init import init_group
from colorama import Fore, Back, Style


@click.group("cli")
def cli_group():
    click.echo(
        Fore.GREEN + "Rflow CLI and SDK helps you swiftly bootstrap Rflow projects"
    )


cli_group.add_command(init_group)
if __name__ == "__main__":
    cli_group()
