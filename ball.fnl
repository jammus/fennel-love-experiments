(local { : random } (require "lib.lume"))

(local g 2000)

(fn random-color []
  [(random 0.2 1) (random 0.2 1) (random 0.2 1) (random 0.2 1)])
 
(fn collision-check [ball max-x max-y]
  (let [x (or (>= ball.x (- max-x ball.width)) (<= ball.x 0))
        y (or (>= ball.y (- max-y ball.height)) (<= ball.y 0))]
    {: x : y :any (or x y)}))

(fn grow-to-target [dt current target rate]
    (if (> current target)
        (- current (* rate dt))
        (< current target)
        (+ current (* rate dt))
        current))

(fn bumper-hit [current]
  (let [new-speed (random 1200 1300)]
    (if (> current 0)
        (* new-speed -1)
        new-speed)))

(fn apply-friction [dt current target]
  (let [real-target (if (< current 0) (* target -1) target)]
    (grow-to-target dt current real-target 500)))

(fn grow-ball [dt { : width : height : growth }]
  [(grow-to-target dt width growth.target-width growth.rate)
   (grow-to-target dt height growth.target-height growth.rate)])

(fn init [] {
  :x 100 :y 100
  :dx 200 :dy 100
  :color (random-color)
  :width (math.random 10 100) :height (math.random 10 100)
  :growth {:rate 10 :target-width (math.random 10 100) :target-height (math.random 10 100)}})

(fn update [dt ball max-x max-y]
  (let [collision? (collision-check ball max-x max-y)
                   dx (if collision?.x
                          (bumper-hit ball.dx)
                          (apply-friction dt ball.dx 200))
                   dy (if collision?.y
                          (bumper-hit ball.dy)
                          (+ ball.dy (* g dt)))
        [width height] (grow-ball dt ball)]
    {:width width
    :height height
    :x (math.min (math.max (+ ball.x (* dx dt)) 0) (- max-x width))
    :y (math.min (math.max (+ ball.y (* dy dt)) 0) (- max-y height))
    : dx
    : dy
    :color ball.color
    :growth {:rate ball.growth.rate
    :target-width (if collision?.any
                      (math.random 10 100)
                      ball.growth.target-width)
    :target-height (if collision?.any
                       (math.random 10 100)
                       ball.growth.target-height)}}))

(fn draw [ball]
  (love.graphics.setColor ball.color)
  (love.graphics.rectangle :fill ball.x ball.y ball.width ball.height))

{: init : update : draw}
