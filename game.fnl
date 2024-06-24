(local repl (require "lib.stdio"))
(local core (require :core))
(local ball (require :ball))
(local test-ball (require :ball))
(local { : hotswap : map } (require "lib.lume"))

(math.randomseed (os.time))

(global state {})

(fn reset-ball! [state]
  (tset state :ball (ball.init)))

(comment
  (tset state :balls (map [1 2] ball.init))
  (. state.ball :color)
  (. state.ball :x)
  (. state.ball :y)
  (. state.ball :dy)
  (. state.ball :dx)
  (tset state.ball :x 100)
  (tset state.ball :y 100)
  (love.window.getMode)
  (tset state.ball :dx 400)
  (do
  (tset state.ball :y (- state.ball.y 100))
  (tset state.ball :dy (math.random 400 3500))
  (tset state.ball :dx (math.random -2000 2000)))
  (. state :ball)
  (reset-ball! state)
  (love.window.getDisplayCount)
  (love.window.getPosition)
  (love.window.setPosition 300 500 2)
  (love.window.updateMode 800 800 {:resizable false})
  (love.window.getDisplayName 1)
  (love.window.getFullscreenModes)
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
