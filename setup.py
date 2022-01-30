import setuptools

ENTRYPOINT = """
[console_scripts]
rflow=zoracloud.cli.cli_main:cli_group
"""

entry_points = ENTRYPOINT


setuptools.setup(
    name="zoracloud",
    version="0.0.0",
    description="Cloud Automation",
    packages=setuptools.find_packages("src"),
    package_dir={"": "src"},
    autehor="Allan Chepkoy",
    author_email="allankiplangat22@gmail.com",
    license="",
    install_requires=["tfx", "click", "colorama", "tensorflow"],
    entry_points=entry_points,
)
