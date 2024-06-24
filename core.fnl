(local ball (require :ball))

(fn init [state] 
  (tset state :ball (ball.init)))

(fn update [dt state]
  (if (love.keyboard.isDown "q")
      (love.event.quit))
  (let [(width height) (love.window.getMode)
        action {:left (love.keyboard.isDown :left)
                :right (love.keyboard.isDown :right)
                :jump (love.keyboard.isDown :space) }]
      (tset state :ball (ball.update dt state.ball action width height))))

(fn draw [state]
  (ball.draw state.ball))

{ : init : update : draw }
