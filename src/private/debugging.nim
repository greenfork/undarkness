template dbgEcho*(str: untyped) =
  when not defined(danger) and not defined(release):
    debugEcho $str
