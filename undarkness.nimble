# Package

version       = "0.1.0"
author        = "Dmitry Matveyev"
description   = "A game about the purpose of death and undeath"
license       = "MIT"
srcDir        = "src"
binDir        = "js"
bin           = @["undarkness.js"]

backend       = "js"

# Dependencies

requires "nim >= 0.20.0", "karax >= 1.1.0"

# Tasks

task pathgraph, "Draw a map of all the questions":
  withDir "src/tools":
    exec "nim js path_graph.nim"
    mvFile "path_graph.js", "../../js/path_graph.js"
