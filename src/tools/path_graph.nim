import json
from os import `/`
import jsffi
import .. / private / debugging

const
  textsPath = ".." / ".." / "gamedata" / "texts"
  questionsJsonData = slurp(textsPath / "questions.json")

# Global JS objects.
var
  d3 {.importc, nodecl.}: JsObject ## d3 JS library
  dagreD3 {.importc, nodecl.}: JsObject ## dagreD3 JS library
  console {.importc, nodecl.}: JsObject

type
  NodeProps = ref object
    label, class: cstring
    rx, ry: int
  EdgeProps = ref object
    label, class: cstring

proc createDom() =
  var questionsJson = parseJson(questionsJsonData)
  var g = jsNew(dagreD3.graphlib.Graph()).setGraph(newJsObject())
    .setDefaultEdgeLabel(proc():auto = JsObject{})

  for name, obj in questionsJson.pairs:
    g.setNode(name, NodeProps{label: name, rx: 5, ry: 5})
    for choice in items(obj["choices"]):
      g.setEdge(name, choice["path"].getStr())

  var
    d3Render = jsNew(dagreD3.render()).to(proc(a, b: auto))
    svg: JsObject = d3.select("svg")
    svgGroup: JsObject = svg.append("g")
  d3Render(d3.select("svg g"), g)

  # Centering the graph.
  var xCenterOffset = (svg.attr("width") - g.graph().width) / 2.toJs()
  svgGroup.attr("transform", "translate(" & xCenterOffset.to(cstring) & ", 20)")
  svg.attr("height", g.graph().height + 40.toJs())

when isMainModule:
  proc main() =
    createDom()

  main()
