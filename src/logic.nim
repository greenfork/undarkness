include karax / prelude
import rendering

proc createDom*(): VNode =
  withLayout:
    question("What is your purpose?")
    choices([kstring"I'm here to kill", kstring"I don't know really"])
