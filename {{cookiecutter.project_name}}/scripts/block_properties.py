from block_wrangler import blocks, load_tags, BlockMapping
from pathlib import Path

shaderpack_root = Path(__file__).parent.parent

def main():
    tags = load_tags()

    mapping = BlockMapping.solve({
        'sway': tags['sway'],
        'sway_lower': tags['sway/lower'] + tags['sway/short'],
        'sway_upper': tags['sway/upper'],
        'sway_hanging': tags['sway/hanging'],
        'sway_full': tags['sway/whole'],
        'sway_floating': tags['sway/floating'],
        'flowers': tags['plant/flowers'],
        'crops': tags['plant/crops'],
        'water': blocks('minecraft:water'),
    })


    with shaderpack_root.joinpath('shaders/block.properties').open('w') as f:
        f.write(mapping.render_encoder())
    with shaderpack_root.joinpath('shaders/util/block_properties.glsl').open('w') as f:
        f.write(mapping.render_decoder())

if __name__ == '__main__':
    main()