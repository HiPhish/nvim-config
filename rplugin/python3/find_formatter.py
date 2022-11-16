import pynvim
from typing import Any, List
from importlib.util import find_spec

known_formatters = ['autopep8', 'yapf', 'black']


@pynvim.plugin
class FormatterDetector:

    def __init__(self, nvim):
        pass

    @pynvim.function(name='DetectPythonFormatters', sync=True)
    def detect_python_formatters(self, args: List[Any]) -> List[str]:
        return [name for name in known_formatters if find_spec(name) is not None]
