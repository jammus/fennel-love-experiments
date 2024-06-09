(local repl (require "lib.stdio"))
(local core (require :core))
(local { : hotswap } (require "lib.lume"))

(math.randomseed (os.time))

(global state {})

(comment
  (. state.ball :color)
)

(fn love.load []
  (core.init state)
  (repl.start)) ; this is important for the REPL to work

(fn love.draw []
  (core.draw state))

(fn love.update [dt]
  (core.update dt state))

(comment
  (hotswap "core")
  (hotswap "ball"))
