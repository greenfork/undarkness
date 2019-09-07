import tables, strutils

include karax / prelude
import rendering

type
  QuestionScreen = object
    title*: kstring
    choices*: seq[Choice]

const
  questionScreens = {
    "welcome": QuestionScreen(
        title: "What is your purpose?",
        choices: @[Choice(title: kstring"I'm here to kill you", path: kstring"killing"),
                   Choice(title: kstring"I'm aftaid", path: kstring"afraid")]
      ),
    "killing": QuestionScreen(
        title: "How bad do you want it?",
        choices: @[Choice(title: kstring"Real bad", path: kstring"cruelty"),
                   Choice(title: kstring"Ha-ha, I was just joking", path: kstring"joking")]
      )
  }.to_table
  initScreen = questionScreens["welcome"]

proc createDom*(rd: RouterData): VNode =
  let key = if rd.hashPart == "": "welcome"
            else: ($rd.hashPart)[1..<len(rd.hashPart)]
  let screen = questionScreens.getOrDefault(key, initScreen)
  withLayout:
    renderQuestion(screen.title)
    renderChoices(screen.choices)
