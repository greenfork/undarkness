include karax / prelude
from logic import createDom

when isMainModule:
  proc main() =
    setRenderer(createDom)

  main()
