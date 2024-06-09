(local ball (require :ball))

(fn init [state] 
  (tset state :ball (ball.init)))

(fn update [dt state]
  (if (love.keyboard.isDown "q")
      (love.event.quit))

  (let [(width height) (love.window.getMode)]
      (tset state :ball (ball.update dt state.ball width height))))

(fn draw [state]
  (ball.draw state.ball))

{ : init : update : draw }
