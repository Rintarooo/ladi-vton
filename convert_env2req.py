import yaml
import argparse

def convert_env_to_requirements(input_file, output_file):
    with open(input_file, 'r') as f:
        env_data = yaml.safe_load(f)

    dependencies = env_data.get('dependencies', [])

    with open(output_file, 'w') as f:
        for dep in dependencies:
            if isinstance(dep, str):
                f.write(dep + '\n')
            elif isinstance(dep, dict):
                for key, value in dep.items():
                    if key.lower() == 'pip':
                        for v in value:
                            f.write(v + '\n')
                            
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convert environment.yml to requirements.txt')
    parser.add_argument('-i', '--input', type=str, default='environment.yml', help='Path to environment.yml file')
    parser.add_argument('-o', '--output', type=str, default='requirements.txt', help='Path to output requirements.txt file')

    args = parser.parse_args()

    convert_env_to_requirements(args.input, args.output)