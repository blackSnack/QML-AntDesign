import os
import shutil

def create_plugin(plugin_name):
    # 1. create plugin path
    plugin_path = os.path.join(os.getcwd(), plugin_name)
 
    # 2. copy PluginTemplate to plugin path
    template_path = os.path.join(os.getcwd(), 'PluginTemplate')
    shutil.copytree(template_path, plugin_path)

    # 3. replace "@Template@" field to plugin name
    replace_in_files(plugin_path, '@Template@', plugin_name)

    # 4. replace Template filed to plugin name
    rename_files(plugin_path, 'Template', plugin_name)

def replace_in_files(directory, search_str, replace_str):
    for subdir, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(subdir, file)
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                content = content.replace(search_str, replace_str)
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)

def rename_files(directory, search_str, replace_str):
    for subdir, _, files in os.walk(directory):
        for file in files:
            if search_str in file:
                new_name = file.replace(search_str, replace_str)
                file_path = os.path.join(subdir, file)
                new_path = os.path.join(subdir, new_name)
                os.rename(file_path, new_path)

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python script.py plugin_name")
        sys.exit(1)

    plugin_name = sys.argv[1]
    create_plugin(plugin_name)
