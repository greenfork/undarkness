import tables
from os import `/`
import json as json

include karax / prelude

import rendering

type
  QuestionScreen = object
    title*: string
    choices*: seq[Choice]

const
  textsPath = ".." / "gamedata" / "texts"
  questionJsonData = slurp(textsPath / "questions.json")

var
  questionJson: JsonNode
  questionScreens = initTable[string, QuestionScreen]()
  defaultScreen: QuestionScreen

proc initLogic* =
  questionJson = json.parseJson(questionJsonData)
  echo questionJson
  for key, screen in questionJson.pairs:
    questionScreens[key] = json.to(screen, QuestionScreen)
  defaultScreen = questionScreens["welcome"]

proc createDom*(rd: RouterData): VNode =
  let key = if rd.hashPart != "": ($rd.hashPart)[1..<len(rd.hashPart)]
            else: ""
  let screen = questionScreens.getOrDefault(key, defaultScreen)
  withLayout:
    renderQuestion(screen.title)
    renderChoices(screen.choices)
