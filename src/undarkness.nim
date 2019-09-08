include karax / prelude
from logic import createDom, initLogic

when isMainModule:
  proc main() =
    initLogic()
    setRenderer(createDom)

  main()
