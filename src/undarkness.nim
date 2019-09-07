include karax / prelude

var lines: seq[kstring] = @[]

proc question(title: kstring): VNode =
  result = buildHtml(h1):
    text title

proc createDom(): VNode =
  result = buildHtml(tdiv):
    question("What am I doing?")

when isMainModule:
  proc main() =
    setRenderer createDom

  main()
