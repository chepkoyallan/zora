"""Commands for bootstrapping the project"""

import click
from zoracloud.cli import labels
from zoracloud.cli.handler import template_handler
from zoracloud.cli.cli_context import Context
from colorama import Fore, Back, Style


# from zoracloud.cli


@click.group("projects", help="Working with different kinds of projects")
def init_group() -> None:
    pass


@init_group.command("list", help="List projects to initialize")
def list_templates() -> None:
    click.echo(Fore.BLUE + "Available templates:")
    for template in template_handler.list_template():
        click.echo("-{}".format(template))


@init_group.command("init", help="Initialize a project to destination directory")
@click.option(
    "--pipeline_name",
    # "--destination-name",
    required=True,
    type=str,
    help="Name of the preprocessing pipelne",
)
@click.option(
    "--destination_path",
    # "--destination-path",
    required=True,
    type=str,
    help="The destination directory path to initialize the pipeline project",
)
@click.option(
    "--model",
    required=True,
    type=str,
    help="Name of the template to copy. Currently, `taxi` is the only template provided.",
)
def init(ctx: Context, pipeline_name: str, destination_path: str, model: str) -> None:
    """Command definition to initialize the template to a specified directory"""
    click.echo("Initializing {} preprocessing template".format(model))
    ctx.flags_dict[labels.PIPELINE_NAME] = pipeline_name
    ctx.flags_dict[labels.DESTINATION_PATH] = destination_path
    ctx.flags_dict[labels.MODEL] = model
    template_handler.copy_template(ctx.flags_dict)
