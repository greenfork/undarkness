import tables

include karax / prelude
import rendering

type
  QuestionScreen = object
    title: kstring
    choices: seq[Choice]

const
  questionScreens = {
    "welcome": QuestionScreen(
        title: "What is your purpose?",
        choices: @[Choice(title: kstring"I'm here to kill you", path: kstring"killing"),
                   Choice(title: kstring"I'm aftaid", path: kstring"afraid")]
      )
  }.to_table

proc createDom*(): VNode =
  withLayout:
    let scr = questionScreens["welcome"]
    renderQuestion(scr.title)
    renderChoices(scr.choices)
