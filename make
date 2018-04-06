#!/usr/bin/env python3.6
"""Run script.
"""
import shlex
import sys
from typing import List

import os
from clinner.command import Type as CommandType, command
from clinner.run.main import Main

APP_NAME = 'goobox-nodes-api'
IMAGE_NAME = f'goobox/{APP_NAME}'
APP_PATH = f'/srv/apps/{APP_NAME}/app'


@command(command_type=CommandType.SHELL,
         args=((('-i', '--image'), {'help': 'Docker image name', 'default': IMAGE_NAME}),
               (('-t', '--tag'), {'help': 'Docker tag', 'default': 'latest'}),),
         parser_opts={'help': 'Build docker image'})
def build(*args, **kwargs) -> List[List[str]]:
    tag = ['-t', f'{kwargs["image"]}:{kwargs["tag"]}']
    return [shlex.split(f'docker build') + tag + ['.'] + list(args)]


@command(command_type=CommandType.SHELL,
         args=((('-i', '--image'), {'help': 'Docker image name', 'default': IMAGE_NAME}),
               (('-t', '--tag'), {'help': 'Docker tag', 'default': 'latest'}),),
         parser_opts={'help': 'Push docker image'})
def push(*args, **kwargs) -> List[List[str]]:
    tag = [f'{kwargs["image"]}:{kwargs["tag"]}']
    return [shlex.split(f'docker push') + tag + list(args)]


@command(command_type=CommandType.SHELL,
         args=((('-i', '--image'), {'help': 'Docker image name', 'default': IMAGE_NAME}),
               (('-t', '--tag'), {'help': 'Docker tag', 'default': 'latest'}),
               (('-p', '--port'), {'help': 'App port', 'default': '8000'}),
               (('--source',), {'help': 'Bind source code as docker volume', 'action': 'store_true'})),
         parser_opts={'help': 'Run command through entrypoint'})
def run(*args, **kwargs) -> List[List[str]]:
    image = [f'{kwargs["image"]}:{kwargs["tag"]}']

    volumes = []
    if kwargs['source']:
        volumes += ['-v', f'{os.getcwd()}:{APP_PATH}']

    port = ['-p', f'{kwargs["port"]}:8000']

    return [shlex.split(f'docker run') + port + volumes + image + list(args)]


@command(command_type=CommandType.SHELL,
         args=((('-i', '--image'), {'help': 'Docker image name', 'default': IMAGE_NAME}),
               (('-t', '--tag'), {'help': 'Docker tag', 'default': 'latest'}),
               (('--source',), {'help': 'Bind source code as docker volume', 'action': 'store_true'})),
         parser_opts={'help': 'Run tests'})
def test(*args, **kwargs) -> List[List[str]]:
    image = [f'{kwargs["image"]}:{kwargs["tag"]}']
    cmd = ['pytest']
    volumes = ['-v', f'{os.getcwd()}:{APP_PATH}'] if kwargs['source'] else []

    return [shlex.split(f'docker run') + volumes + image + cmd + list(args)]


@command(command_type=CommandType.SHELL,
         args=((('-i', '--image'), {'help': 'Docker image name', 'default': IMAGE_NAME}),
               (('-t', '--tag'), {'help': 'Docker tag', 'default': 'latest'}),
               (('--source',), {'help': 'Bind source code as docker volume', 'action': 'store_true'})),
         parser_opts={'help': 'Run lint'})
def lint(*args, **kwargs) -> List[List[str]]:
    image = [f'{kwargs["image"]}:{kwargs["tag"]}']
    cmd = ['prospector']
    volumes = ['-v', f'{os.getcwd()}:{APP_PATH}'] if kwargs['source'] else []

    return [shlex.split(f'docker run') + volumes + image + cmd + list(args)]


if __name__ == '__main__':
    sys.exit(Main().run())