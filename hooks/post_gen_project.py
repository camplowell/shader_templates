from pathlib import Path
from logging import getLogger

def remove_dh_files():
	logger = getLogger(__name__)
	TO_DELETE = [
		'shaders/util/dh_clip.glsl',
		'shaders/dh_terrain.vsh',
		'shaders/dh_terrain.fsh',
		'shaders/dh_water.vsh',
		'shaders/dh_water.fsh',
		'shaders/lang/en_US.lang',
		'shaders/lang'
	]
	for path in (Path(file) for file in TO_DELETE):
		if not path.exists():
			logger.warn(f"Couldn't delete {path} because it doesn't exist!")
			continue
		if path.is_dir():
			path.rmdir()
		else:
			path.unlink()

if not {{cookiecutter.dh_support}}:
	remove_dh_files()