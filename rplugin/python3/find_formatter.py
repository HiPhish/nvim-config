import pynvim
from typing import Any, List
from importlib.util import find_spec

known_formatters = ['autopep8', 'yapf', 'black']


@pynvim.plugin
class FormatterDetector:

    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.function(name='DetectPythonFormatters', sync=True)
    def detect_python_formatters(self, args: List[Any]):
        result: List[str] = []

        for formatter_name in known_formatters:
            module = find_spec(formatter_name)
            if module is not None:
                result.append(formatter_name)

        return result
