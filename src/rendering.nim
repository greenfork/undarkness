include karax / prelude

proc question(title: kstring): VNode =
  result = buildHtml(h1(class="title has-text-centered")):
    text title

proc buttonOptions(buttons: openArray[kstring]): VNode =
  result = buildHtml(tdiv(class="buttons are-medium is-centered")):
    for btn in buttons:
      button(class="button is-primary is-outlined"):
        text btn

proc createDom*(): VNode =
  result = buildHtml(tdiv(class="hero is-dark is-fullheight")):
    tdiv(class="hero-body"):
      tdiv(class="container"):
        question("What am I doing?")
        buttonOptions([kstring"A great mischief", kstring"I don't know really"])
