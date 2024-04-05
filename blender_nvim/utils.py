import queue
import traceback

import bpy


def redraw_all():
    for window in bpy.context.window_manager.windows:
        for area in window.screen.areas:
            area.tag_redraw()


def get_prefixes(all_names, separator):
    return set(name.split(separator)[0] for name in all_names if separator in name)


execution_queue = queue.Queue()


def run_in_main_thread(func):
    execution_queue.put(func)


def always():
    while not execution_queue.empty():
        func = execution_queue.get()
        try:
            func()
        except:  # noqa: E722
            traceback.print_exc()
    return 0.1


bpy.app.timers.register(always, persistent=True)
