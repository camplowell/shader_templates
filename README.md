# shader_templates
A cookiecutter template generator for Minecraft shaderpacks (Iris/Optifine)

## Installation
This project relies on [cookiecutter](https://pypi.org/project/cookiecutter/) to generate shaderpack templates.

To install cookiecutter, run:
```bash
pipx install cookiecutter
```
> Pipx is highly recommended for end-user apps hosted on PiPy.

## Usage

### Create a new Github repository
Create a new repository for your shaderpack on Github or whatever version control system you prefer.
Clone the repository to your local machine.

> Note: This template includes a `.gitignore` file to prevent committing Python virtual environments, cache files, and other things you probably don't want to commit.  
> Do not add a `.gitignore` file to the root of your repository; it will be overwritten by the template.

### Add the template
To use this template, run:
```bash
cd your/shaderpack/repository/..
cookiecutter gh:camplowell/shader_templates -f
```
Enter the folder name of your shaderpack when prompted for the *project name*.

### Options
- *project name*: The name of the shaderpack folder.
- *Distant Horizons support*: Whether or not to include shaders to support [Distant Horizons](https://modrinth.com/mod/distanthorizons) (Iris only).
- *GLSL version*: The version of GLSL to use (compatibility profile is used if applicable).


### Commit and push
You're done! Commit your changes to your repository and push them to Github.
