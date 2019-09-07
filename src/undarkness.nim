include karax / prelude
from rendering import createDom

when isMainModule:
  proc main() =
    setRenderer createDom

  main()
