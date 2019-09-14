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

task pages, "Build github pages":
  exec "nimble build"
  exec "nimble pathgraph"
  cpFile "templates/index.html", "docs/index.html"
  cpFile "templates/path_graph.html", "docs/path_graph.html"
  cpFile "js/undarkness.js", "docs/undarkness.js"
  cpFile "js/path_graph.js", "docs/path_graph.js"
  cpFile "css/styles.css", "docs/styles.css"
  exec """nimgrep -r "\.\./js" "." docs/index.html"""
  exec """nimgrep -r "\.\./css" "." docs/index.html"""
  exec """nimgrep -r "\.\./js/lib" "." docs/path_graph.html"""
  exec """nimgrep -r "\.\./js" "." docs/path_graph.html"""
