(fn random-color-value []
  (+ 0.2 (* (math.random) (- 1.0 0.2))))

(fn random-color []
  [(random-color-value) (random-color-value) (random-color-value) (random-color-value)])
 
(fn collision-check [ball max-x max-y]
  {:x (or (>= ball.x (- max-x ball.width)) (<= ball.x 0))
   :y (or (>= ball.y (- max-y ball.height)) (<= ball.y 0))})

(fn grow-to-target [dt current target rate]
    (if (> current target)
        (- current (* rate dt))
        (< current target)
        (+ current (* rate dt))
        current))

(fn init [] {
  :x 100
  :y 100
  :dx 200
  :dy 100
  :color (random-color)
  :width (math.random 10 100)
  :height (math.random 10 100)
  :growth {:rate 10
  :target-width (math.random 10 100)
  :target-height (math.random 10 100)}})

(fn update [dt ball max-x max-y]
  (let [collision? (collision-check ball max-x max-y)
                   dx (if collision?.x
                          (* ball.dx -1)
                          ball.dx)
                   dy (if collision?.y
                          (* ball.dy -1)
                          ball.dy)]
    {:width (grow-to-target dt ball.width ball.growth.target-width
                            ball.growth.rate)
    :height (grow-to-target dt ball.height ball.growth.target-height
                            ball.growth.rate)
    :x (math.max (+ ball.x (* dx dt)) 0)
    :y (math.max (+ ball.y (* dy dt)) 0)
    : dx
    : dy
    :color (if (or collision?.x collision?.y)
               (random-color)
               ball.color)
    :growth {:rate ball.growth.rate
    :target-width (if (or collision?.x collision?.y)
                      (math.random 10 100)
                      ball.growth.target-width)
    :target-height (if (or collision?.x collision?.y)
                       (math.random 10 100)
                       ball.growth.target-height)}}))

(fn draw [ball]
  (love.graphics.setColor ball.color)
  (love.graphics.rectangle :fill ball.x ball.y ball.width ball.height))

{: init : update : draw}
