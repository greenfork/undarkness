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
    inner: JsObject = svg.select("g")
    zoom = d3.zoom().on("zoom", proc() =
      inner.attr("transform", d3.event.transform))
  svg.call(zoom)
  d3Render(inner, g)
  console.log(g)

  # Centering the graph with zoom.
  var initialScale = 0.6.toJs
  svg.call(
    zoom.transform,
    d3.zoomIdentity.translate(
      (svg.attr("width") - g.graph().width * initialScale) / 2.toJs, 20.toJs
    ).scale(initialScale)
  )
  svg.attr("height", g.graph().height * initialScale + 40.toJs)

when isMainModule:
  proc main() =
    createDom()

  main()
