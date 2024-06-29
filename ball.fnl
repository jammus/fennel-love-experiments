(local { : random } (require "lib.lume"))

(local character (love.graphics.newImage "assets/pixel-adventure/main-characters/virtual-guy/jump.png"))

(local g 980)

(fn random-color []
  [(random 0.2 1) (random 0.2 1) (random 0.2 1) (random 0.2 1)])
 
(fn collision-check [ball max-x max-y]
  (let [x0 (<= ball.x 0)
        x1 (>= ball.x (- max-x ball.width))
        y0 (<= ball.y 0)
        y1 (>= ball.y (- max-y ball.height))]
    {: x0 : x1 : y0 : y1 :x (or x0 x1) :y (or y0 y1) :any (or x0 x1 y0 y1)}))

(fn init [] {
  :x 100 :y 100
  :dx 200 :dy 100
  :color (random-color)
  :width 32 :height 32
  :growth {:rate 10 :target-width (math.random 10 100) :target-height (math.random 10 100)}})

(fn update [dt ball action max-x max-y]
  (set ball.x (math.min (math.max (+ ball.x (* ball.dx dt)) 0) (- max-x ball.width)))
  (set ball.y (math.min (math.max (+ ball.y (* ball.dy dt)) 0) (- max-y ball.height)))
  (set ball.dx 0)
  (when (. action :left)
    (set ball.dx -200))
  (when (. action :right)
    (set ball.dx 200))
  (let [collision? (collision-check ball max-x max-y)]
    (when (. collision? :y)
      (set ball.dy 0))
    (when (not (. collision? :y1))
      (set ball.dy (+ ball.dy (* g dt))))
    (when (and (. action :jump)
               (or (. collision? :y1)
                   (and (. collision? :x0) (. action :right))
                   (and (. collision? :x1) (. action :left))))
      (set ball.dy -500)))
  ball)

(fn draw [ball]
  (love.graphics.draw character ball.x ball.y))

{: init : update : draw}
