from json import nil
import jsffi
import .. / private / debugging

var d3 {.importc, nodecl.}: JsObject
var dagreD3 {.importc, nodecl.}: JsObject
var console {.importc, nodecl.}: JsObject
type
  NodeProps = ref object
    label, class: cstring

proc createDom() =
  dbgEcho "rendering DOM"
  var g = jsNew(dagreD3.graphlib.Graph()).setGraph(newJsObject())
    .setDefaultEdgeLabel(proc():auto = JsObject{})

  g.setNode("0", NodeProps{label: "TOP", class: "type-TOP"})
  g.setNode("1", NodeProps{label: "S", class: "type-S"})

  for node in g.nodes():
    var node = g.node(node)
    node.rx = 5
    node.ry = 5

  g.setEdge("0", "1")
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
