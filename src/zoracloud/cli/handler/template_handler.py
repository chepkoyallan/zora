import os
import re
import click
import collections
from typing import List, Dict, Any, Pattern, Set
from zoracloud.cli import labels
from tfx.dsl.io import fileio
import urllib.request

_PIPELINE_NAME_ESCAPE_CHAR = ["\\", "'", '"', "/"]

_PLACEHOLDER_PIPELINE_NAME = re.compile("{{PIPELINE_NAME}}")

_IMPORT_FROM_PACKAGE = re.compile(r"from tfx\.experimental\.templates\.[^\.]+\.")

_IMPORT_FROM_LOCAL_DIR = "from "

_IGNORE_FILE_PATHS = {
    "taxi": [  # template name
        "e2e_tests",
    ],
    "penguin": [
        "e2e_tests",
    ],
}

_TemplateFilePath = collections.namedtuple("_TemplateFilePath", ["src", "dst"])

_ADDITIONAL_FILE_PATHS = {
    "taxi": [  # template name
        _TemplateFilePath(
            "examples/chicago_taxi_pipeline/data/simple/data.csv", "data/data.csv"
        ),
    ],
    "penguin": [
        _TemplateFilePath(
            "http://storage.googleapis.com/download.tensorflow.org/data/palmer_penguins/penguins_processed.csv",
            "data/data.csv",
        ),
    ],
}


def _copy_and_replace_placeholder_file(
    src: str, dst: str, replace_dict: Dict[Pattern[str], str]
) -> None:
    """Copy a file to destination path and replace the placeholders."""
    click.echo("{} -> {}".format(os.path.basename(src), dst))
    with open(src) as fp:
        contents = fp.read()
    for orig_regex, new in replace_dict.items():
        contents = orig_regex.sub(new, contents)
    with open(dst, "w") as fp:
        fp.write(contents)


def _copy_and_replace_placeholder_dir(
    src: str, dst: str, ignore_paths: Set[str], replace_dict: Dict[Pattern[str], str]
) -> None:
    """Copy a directory to destination path and replace the placeholders."""
    if not os.path.isdir(dst):
        if os.path.exists(dst):
            raise RuntimeError(
                "Cannot copy template directory {}. Already a file exists.".format(src)
            )
        fileio.makedirs(dst)
    for f in os.listdir(src):
        src_path = os.path.join(src, f)
        dst_path = os.path.join(dst, f)
        if src_path in ignore_paths:
            continue

        if os.path.isdir(src_path):
            if f.startswith("_"):  # Excludes __pycache__ and other private folders.
                continue
            _copy_and_replace_placeholder_dir(
                src_path, dst_path, ignore_paths, replace_dict
            )
        else:  # a file.
            if f.endswith(".pyc"):  # Excludes .pyc
                continue
            _copy_and_replace_placeholder_file(src_path, dst_path, replace_dict)


def _source_dir():
    """Get zora directory in the source tree"""
    return os.path.dirname(  # zoracloud
        os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # cli  # handler
    )


def _template_src_dir():
    """Get the template directory in the source tree

    Find zoracloud templates
    :returns
    Path to the directory containing template sources
    """
    return os.path.join(_source_dir(), "templates")


def list_template() -> List[str]:
    """List available templates by inspecting templates source directory

    :return:
    List of template names which is same as directory name
    """
    template_dir = _template_src_dir()
    names = []
    for f in os.listdir(template_dir):
        if f.startswith("_"):
            continue
        if not os.path.isdir(os.path.join(template_dir, f)):
            continue
        names.append(f)
    return names


def _sanitize_pipeline_name(name: str) -> str:
    """Escape special characters to make a valid directory name."""
    for escape_char in _PIPELINE_NAME_ESCAPE_CHAR:
        name = name.replace(escape_char, "\\" + escape_char)
    return name


def _templates_src_dir() -> str:
    """Get template directory in the source tree.
      We should find tfx/experimental/templates
      from tfx/tools/cli/handler/template_handler.py.
    Returns:
      Path to the directory containing template sources.
    """
    return os.path.join(_source_dir(), "experimental", "templates")


def copy_template(flags_dict: Dict[str, Any]) -> None:
    """Copy template flags_dict["model"] to flags_dict["dest_dir"].
    Copies all *.py and README files in specified template, and replace
    the content of the files.
    Args:
      flags_dict: Should have pipeline_name, model and dest_dir.
    """
    model = flags_dict[labels.MODEL]
    pipeline_name = _sanitize_pipeline_name(flags_dict[labels.PIPELINE_NAME])
    template_dir = os.path.join(_templates_src_dir(), model)
    if not os.path.isdir(template_dir):
        raise ValueError("Model {} does not exist.".format(model))
    destination_dir = flags_dict[labels.DESTINATION_PATH]

    ignore_paths = {
        os.path.join(template_dir, x) for x in _IGNORE_FILE_PATHS.get(model, [])
    }
    replace_dict = {
        _IMPORT_FROM_PACKAGE: _IMPORT_FROM_LOCAL_DIR,
        _PLACEHOLDER_PIPELINE_NAME: pipeline_name,
    }
    _copy_and_replace_placeholder_dir(
        template_dir, destination_dir, ignore_paths, replace_dict
    )
    for additional_file in _ADDITIONAL_FILE_PATHS.get(model, []):
        dst_path = os.path.join(destination_dir, additional_file.dst)
        fileio.makedirs(os.path.dirname(dst_path))

        if additional_file.src.startswith(("http://", "https://")):
            urllib.request.urlretrieve(additional_file.src, dst_path)
        else:
            src_path = os.path.join(_source_dir(), additional_file.src)
            fileio.copy(src_path, dst_path)
