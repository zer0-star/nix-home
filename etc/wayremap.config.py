 # etc/wayremap.config.py

from wayremap import ecodes as e, run, WayremapConfig, Binding, wait_sway
import uinput as k

wayremap_config = WayremapConfig(
    # Note that `'/dev/input/event4'` varies among system.
    input_path='/dev/input/event0',

    # Filter applications which remap will be applied
    applications=[
        'Vivaldi-stable',
        'firefox',
    ],

    bindings=[
        # To see all available binding keys, please see
        # https://github.com/acro5piano/wayremap/blob/06d27c9bb86b766d7fd1e4230f3a16827785519e/wayremap/ecodes.py
        # modifier keys are `KEY_LEFTCTRL` or `KEY_LEFTALT`, or both. Neither `shift` nor `super` is not implemented yet.

        Binding([e.KEY_LEFTCTRL, e.KEY_M], [[k.KEY_ENTER]]),

        # Emacs-like key binding
        Binding([e.KEY_LEFTCTRL, e.KEY_LEFTALT, e.KEY_A],
                [[k.KEY_LEFTCTRL, k.KEY_HOME]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_LEFTALT, e.KEY_E],
                [[k.KEY_LEFTCTRL, k.KEY_END]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_LEFTALT, e.KEY_H],
                [[k.KEY_LEFTCTRL, k.KEY_BACKSPACE]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_F], [[k.KEY_RIGHT]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_B], [[k.KEY_LEFT]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_P], [[k.KEY_UP]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_N], [[k.KEY_DOWN]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_K],
                [[k.KEY_LEFTSHIFT, k.KEY_END], [k.KEY_LEFTCTRL, k.KEY_X]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_A], [[k.KEY_HOME]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_E], [[k.KEY_END]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_Y], [[k.KEY_LEFTCTRL, k.KEY_V]]),
        Binding([e.KEY_LEFTALT, e.KEY_F], [[k.KEY_LEFTCTRL, k.KEY_RIGHT]]),
        Binding([e.KEY_LEFTALT, e.KEY_B], [[k.KEY_LEFTCTRL, k.KEY_LEFT]]),
        Binding([e.KEY_LEFTALT, e.KEY_D], [[k.KEY_LEFTCTRL, k.KEY_DELETE]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_H], [[k.KEY_BACKSPACE]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_D], [[k.KEY_DELETE]]),
        Binding([e.KEY_LEFTCTRL, e.KEY_S], [[k.KEY_LEFTCTRL, k.KEY_F]]),


        # OSX-like key binding
        Binding([e.KEY_LEFTALT, e.KEY_A], [[k.KEY_LEFTCTRL, k.KEY_A]]),
        Binding([e.KEY_LEFTALT, e.KEY_C], [[k.KEY_LEFTCTRL, k.KEY_C]]),
        Binding([e.KEY_LEFTALT, e.KEY_V], [[k.KEY_LEFTCTRL, k.KEY_V]]),

        # Slack helm!
        Binding([e.KEY_LEFTALT, e.KEY_X], [[k.KEY_LEFTCTRL, k.KEY_K]]),
    ])


# Required if you want to use wayremap as a startup service.
wait_sway()

# Finally, run wayremap.
run(wayremap_config)
