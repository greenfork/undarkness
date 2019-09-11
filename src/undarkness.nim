from karax / karax import setRenderer

from logic import createDom, initLogic

proc main() =
  initLogic()
  setRenderer(createDom)

main()
