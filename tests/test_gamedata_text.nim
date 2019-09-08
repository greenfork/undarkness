import json as json
import unittest, algorithm, sequtils, strutils, os

suite "references":
  setup:
    let
      questionsJsonData = readFile("gamedata"/"texts"/"questions.json")
      questionsJson = json.parseJson(questionsJsonData)

  test "all paths have corresponding endpoints":
    var paths, endpoints: seq[string]
    for endpoint, question in questionsJson.pairs:
      endpoints.add endpoint
      for choice in question["choices"]:
        paths.add choice["path"].getStr
    checkpoint("Filled paths and endpoints sequences")
    check(paths.sorted.deduplicate(true) == endpoints.sorted.deduplicate(true))
