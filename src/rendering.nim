include karax / prelude
import karax / kdom except class

proc renderQuestion*(title: kstring): VNode =
  result = buildHtml(h1(class="title has-text-centered")):
    text title

type Choice* = object
  title*, path*: kstring
proc renderChoices*(choices: openArray[Choice]): VNode =
  result = buildHtml(tdiv(class="buttons are-medium is-centered")):
    for choice in choices:
      a(class="button is-primary is-outlined", href="#"&choice.path):
        text choice.title
        proc onMouseUp(ev: Event, n: VNode) =
          for btn in document.querySelectorAll(".buttons .button"):
            btn.blur()

template withLayout*(content: untyped) =
  result = buildHtml(tdiv(class = "hero is-dark is-fullheight")):
    tdiv(class="hero-body"):
      tdiv(class="container"):
        content
