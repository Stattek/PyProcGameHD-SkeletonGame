from dmd import *
from layers import *

from . import DisplayController, HDTextLayer


class HDDisplayController(DisplayController):
    def __init__(self, game):
        game.use_virtual_dmd_only = True

        super().__init__(game, game.dmd_width, game.dmd_height, message_font=None)
        self.message_layer = HDTextLayer(
            game.dmd_width / 2,
            game.dmd_height / 2,
            game.fonts["default_msg"],
            "center",
            width=game.dmd_width,
        )

    def set_message(self, message, seconds):
        self.message_layer.set_text(message, seconds)
