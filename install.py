#!/usr/bin/env python3

import os
import re
import shutil
import hashlib
import subprocess

class PathsFile:
    bash_var_re = re.compile(r'/?\$\{(\w+)\}/?')
    def __init__(self):
        self.map = {}
        with open('paths', 'r') as fp:
            for line in fp:
                key, value = line.strip().split(' = ')
                path = self.bash_var_re.split(value)
                for i, dir in enumerate(path):
                    if dir in os.environ:
                        path[i] = os.environ[dir]
                self.map[key] = os.path.join(*path)

def ask_with_diff(src, dst):
    subprocess.call(['diff', src, dst])
    return input('Do you want to copy this file to this repo? [y/n]') == 'y'

def compare_files(src, dst):
    src_hash = ''
    dst_hash = ''
    
    with open(src, 'rb') as f:
        md5 = hashlib.md5()
        md5.update(f.read())
        src_hash = md5.hexdigest()
    with open(dst, 'rb') as f:
        md5 = hashlib.md5()
        md5.update(f.read())
        dst_hash = md5.hexdigest()

    if src_hash != dst_hash:
        if os.path.getmtime(src) > os.path.getmtime(dst):
            print(f"{dst} is outdated. Updating.")
            shutil.copy(src, dst)
        else:
            print(f"{dst} is newer. Should you update?")
            if ask_with_diff(src, dst):
                shutil.copy(dst, src)
                print(f"{src} is updated.")
        return True
    return False
        

def for_all_entries(repo_path, system_path, destination_extras):
    if os.path.isdir(repo_path) and (os.path.isdir(system_path) or not os.path.exists(system_path)):
        return for_all_paths(repo_path, system_path, destination_extras)
    elif os.path.isdir(repo_path) or os.path.isdir(system_path):
        if os.path.isdir(system_path):
            tmp = repo_path
            repo_path = system_path
            system_path = tmp
        raise Exception(f"{repo_path} is a folder, but {system_path} is a file")
    else:
        # both are files
        # print(f"Comparing files {repo_path} and {system_path}")
        return compare_files(repo_path, system_path)

def for_all_paths(repo_path, system_path, destination_extras):
    isModified = False
    if not os.path.exists(system_path):
        print(f"No folder {repo_path} in the system. Updating.")
        shutil.copytree(repo_path, system_path)
        isModified = True
    else:
        repo_fs = set(os.listdir(repo_path))
        system_fs = set(os.listdir(system_path))
        common = repo_fs.intersection(system_fs)
        uncommon = repo_fs.symmetric_difference(system_fs)
        for item in common:
            isModified &= for_all_entries(os.path.join(repo_path, item), os.path.join(system_path, item), destination_extras)
        for item in uncommon:
            if item in repo_fs:
                src = os.path.join(repo_path, item)
                dst = os.path.join(system_path, item)
                print(f"New item {item} in {system_path} (from {src})")
                if os.path.isdir(src):
                    shutil.copytree(src, dst)
                else:
                    shutil.copy(src, dst)
                isModified = True
            else:
                destination_extras.append((system_path, item))
    return isModified
            
        

if __name__ == '__main__':
    destination_extras = []
    for repo_path, system_path in PathsFile().map.items():
        if not os.path.exists(repo_path):
            raise Exception("Paths file specifies non-existant repo-path "+repo_path)
        if not for_all_entries(repo_path, system_path, destination_extras):
            print(f"{repo_path} and {system_path} match exactly.")
    for system_path, item in destination_extras:
        print(f"Destination folder {system_path} contains extra {'folder' if os.path.isdir(os.path.join(system_path, item)) else 'file'} {item}. Ignoring it.")
