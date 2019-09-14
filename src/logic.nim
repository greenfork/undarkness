import tables
from os import `/`
import json as json

import karax / [kbase, karax, karaxdsl, vdom, compact, jstrutils]
import rendering, private / debugging

type
  QuestionScreen* = object
    title*: string
    choices*: seq[Choice]

const
  textsPath = ".." / "gamedata" / "texts"
  questionsJsonData = slurp(textsPath / "questions.json")

var
  questionsJson: JsonNode
  questionScreens = initTable[kstring, QuestionScreen]()
  defaultScreen: QuestionScreen

proc initLogic* =
  questionsJson = json.parseJson(questionsJsonData)
  dbgEcho questionsJson
  for key, screen in questionsJson.pairs:
    questionScreens[key] = json.to(screen, QuestionScreen)
  defaultScreen = questionScreens["welcome"]

proc createDom*(rd: RouterData): VNode =
  let key = if rd.hashPart != "": ($rd.hashPart)[1..<len(rd.hashPart)]
            else: ""
  dbgEcho key
  let screen = questionScreens.getOrDefault(key, defaultScreen)
  withLayout:
    renderQuestion(screen.title)
    renderChoices(screen.choices)
