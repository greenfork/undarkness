template dbgDo(blk: untyped) =
  when not defined(danger) and not defined(release):
    blk

template releaseDo(blk: untyped) =
  when defined(danger) or defined(release):
    blk

template dbgEcho*(str: untyped) =
  dbgDo(debugEcho $str)
