import argparse
import json
import os
import re
import shutil
import subprocess
from pathlib import Path

"""
See https://wphelp365.com/blog/ultimate-guide-downloading-converting-aax-flac/
on how to use.
Step 3 + 4 will get activation bytes.

Example:
python convert.py -i "The Tower of the Swallow.aax" -a xxxxxx
where -a is the activation code
"""


def get_chapters(input):
    ffprobe = shutil.which('ffprobe')
    if not ffprobe:
        raise FileNotFoundError('ffprobe not found!')
    cmd = [ffprobe, '-show_chapters', '-loglevel', 'error', '-print_format',
           'json', input]
    output = subprocess.check_output(cmd, universal_newlines=True)
    chapters = json.loads(output)
    return chapters


def parse_chapters(chapters, input, activation_bytes, album):
    ffmpeg = shutil.which('ffmpeg')
    if not ffmpeg:
        raise FileNotFoundError('ffmpeg not found!')
    for i, chapter in enumerate(chapters['chapters']):
        title = chapter['tags']['title']

        cmd = [ffmpeg, '-y',
               '-activation_bytes', activation_bytes,
               '-i', input,
               '-ss', chapter['start_time'],
               '-to', chapter['end_time'],
               '-metadata', 'title=%s' % title]

        if album is not None:
            cmd.extend(['-metadata', 'album=%s' % album])

        out_arg = Path(input).stem
        output = f'{out_arg}_{i+1}.flac'
        cmd.extend(['-c:a', 'flac', '-vn', output])
        print(cmd)

        subprocess.check_output(cmd, universal_newlines=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='Input file name', required=True)
    parser.add_argument('-a', '--activation-bytes', help='Activation bytes',
                        required=True)
    parser.add_argument('--album',
                        help='ID3v2 tag for Album, if not specified, '
                             'uses from aax')
    namespace = parser.parse_args()
    print(namespace)

    # Collate args
    input = namespace.input
    activation_bytes = namespace.activation_bytes
    album = namespace.album
    chapters = get_chapters(input)
    print(chapters)

    parse_chapters(chapters, input, activation_bytes, album)
