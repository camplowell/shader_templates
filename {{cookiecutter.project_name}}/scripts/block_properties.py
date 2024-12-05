from block_wrangler import *
from pathlib import Path

from caseconverter import pascalcase

shaderpack_root = Path(__file__).parent

def main():
    tags = load_tags()
    
    Bool = Flag.Config(function_name=lambda flag: f"Is{pascalcase(flag)}")
    Sequence = FlagSequence.Config(function_name=lambda flag: f"Get{pascalcase(flag)}")
    Enum = EnumFlag.Config(function_name=lambda flag: f"{pascalcase(flag)}Type") | Sequence
    Int = IntFlag.Config() | Sequence
    
    mapping = BlockMapping.solve({
        'sway':Enum({
            'top': tags['sway/upper'],
            'bottom': tags['sway/lower'] + tags['sway/short'], # Tags can be combined with the +, -, and & operators
            'full': tags['sway/full'],
            'floating': tags['sway/floating'],
            'hanging': tags['sway/hanging'],
        }),
        'crops': Bool(tags['minecraft:crops']), # Vanilla tags are included
        'water': Bool(blocks('minecraft:water')), # Individual blocks can also be referenced by name
        'emissivity': Int({i:tags[f'lights/{i}'] for i in range(1, 16)}) # Flag sequences that return ints and floats are specified with IntFlag and FloatFlag, respectively.
    }, config=MappingConfig(
        start_index=10
    ))
    with shaderpack_root.joinpath('shaders/block.properties').open('w') as f:
        f.write(mapping.render_encoder())
    with shaderpack_root.joinpath('shaders/util/block_properties.glsl').open('w') as f:
        f.write(mapping.render_decoder())
    
    print(f'Done!')

if __name__ == '__main__':
    main()