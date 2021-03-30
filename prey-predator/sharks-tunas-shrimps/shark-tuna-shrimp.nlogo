breed [ shrimps shrimp]
breed [ tunas tuna ]
breed [ sharks shark ]

turtles-own [ energy ]  ;; agents own energy

globals [ ;; movement of agents
  tunas-movement
  sharks-movement
  shrimps-movement
]

;; this procedures sets up the model
to setup
  clear-all
  ask patches [
    set pcolor cyan + 3
  ]
  create-shrimps number-of-shrimps [  ;; create the initial shrimp
    setxy random-xcor random-ycor
    set color orange
    set size 1 ;;
    set energy 50  ;; set the initial energy to 50
  ]
  create-tunas number-of-tunas [  ;; create the initial tunas
    setxy random-xcor random-ycor
    set color blue + 2
    set size 2 ;; increase their size relative to shrimps
    set energy 100  ;; set the initial energy to 100 relative to shrmps
  ]
  create-sharks number-of-sharks [  ;; create the initial sharks
    setxy random-xcor random-ycor
    set color sky
    set size 4 ;; increase their size relative to tunas
    set energy 400  ;; set the initial energy to 400 relative to tunas
  ]

  ;; set the movement of agents, considered as constant
  set shrimps-movement 45
  set tunas-movement 90
  set sharks-movement 180

  reset-ticks
end

;; make the model run
to go
  if not any? turtles [  ;; now check for any turtles, that is both wolves and sheep
    stop
  ]

  ask sharks [  ;; ask sharks
    wiggle  ;; first turn a little bit
    move  ;; then step forward
    check-if-dead  ;; check to see if agent should die
    eat            ;; shark eat tuna and shrimp
    reproduce
  ]
  ask tunas [  ;; ask tunas
    wiggle  ;; first turn a little bit
    move  ;; then step forward
    check-if-dead  ;; check to see if agent should die
    eat            ;; tuna eat shrimp
    reproduce
  ]
  ask shrimps [  ;; ask shrimps
    wiggle  ;; first turn a little bit
    move  ;; then step forward
    check-if-dead  ;; check to see if agent should die
  ]

  reproduce-shrimp ;;
  tick
  my-update-plots  ;; plot the population counts
end

;; turtle procedure, the agent changes its heading
to wiggle
  ifelse breed = shrimps
  [ ifelse coin-flip? [right random shrimps-movement] [left random shrimps-movement]

  ]
  [ ifelse breed = tunas
    [
      ifelse coin-flip? [right random tunas-movement] [left random tunas-movement]
    ]
    [
      ifelse coin-flip? [right random sharks-movement] [left random sharks-movement]
    ]
  ]
  ;; turn right then left, so the average is straight ahead

end

;; turtle procedure, the agent moves which costs it energy
to move
  ifelse breed = shrimps
  [
    back 1
    set energy energy - shrimps-movement-cost
  ]
  [
    forward 1
    ifelse breed = tunas
    [ set energy energy - tunas-movement-cost ]
    [ set energy energy - sharks-movement-cost ]
  ]
   ;; reduce the energy by the cost of movement
end

;; generate random; for movement
to-report coin-flip?
  report random 2 = 0
end

;; turtle procedure, for all agents
to check-if-dead
 if energy < 0 [
    die
  ]
end

;; turtle procedure
to eat
  ifelse breed = sharks
  [
    eat-shrimps
    eat-tunas
  ]
  [ if breed = tunas [eat-shrimps] ]
end

;; sharks and tunas procedure, sharks and tunas eat shrimps
to eat-shrimps
  if any? shrimps-here [  ;; if there are sheep here then eat one
    let target one-of shrimps-here
    ask target [
      die
    ]
    ;; increase the energy by the parameter setting
    set energy energy + energy-gain-from-shrimp
  ]
end

;; sharks procedure, sharks eat tuna
to eat-tunas
  if any? tunas-here [  ;; if there are sheep here then eat one
    let target one-of tunas-here
    ask target [
      die
    ]
    ;; increase the energy by the parameter setting
    set energy energy + energy-gain-from-tunas
  ]
end

;; sharks and tunas procedure; check to see if this turtle has enough energy to reproduce
to reproduce
  ifelse breed = tunas
  [
    if energy > 200 [
      set energy energy - 100  ;; reproduction transfers energy
      hatch 1 [ set energy 100 ] ;; to the new agent
    ]
  ]
  [
    if energy > 800 [
       set energy energy - 400  ;; reproduction transfers energy
       hatch 1 [ set energy 400 ] ;; to the new agent
    ]
  ]

end

;; reproduce shrimp
to reproduce-shrimp
  create-shrimps random number-of-shrimps [  ;; create the initial shrimp
    setxy random-xcor random-ycor
    set color orange
    set size 1 ;;
    set energy 50  ;; set the initial energy to 50
  ]
end

;; update the plots
to my-update-plots
  set-current-plot-pen "tunas"
  plot count tunas

  set-current-plot-pen "sharks"
  plot count sharks * 10 ;; scaling factor so plot looks nice

  set-current-plot-pen "shrimps"
  plot count shrimps / 50 ;; scaling factor so plot looks nice
end

; Copyright 2007 Uri Wilensky.
; See Info tab for full copyright and license.
@#$#@#$#@
GRAPHICS-WINDOW
684
39
1121
477
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

SLIDER
16
96
208
129
number-of-tunas
number-of-tunas
0
100
50.0
1
1
NIL
HORIZONTAL

SLIDER
14
144
210
177
number-of-sharks
number-of-sharks
0
100
16.0
1
1
NIL
HORIZONTAL

SLIDER
274
52
478
85
energy-gain-from-shrimp
energy-gain-from-shrimp
0
2.0
1.7
0.1
1
NIL
HORIZONTAL

BUTTON
277
151
350
184
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
373
152
436
185
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
276
202
607
463
Population over Time
Time
Population
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"tunas" 1.0 0 -8020277 true "" ""
"shrimps" 1.0 0 -955883 true "" ""
"sharks" 1.0 0 -13791810 true "" ""

SLIDER
16
53
208
86
number-of-shrimps
number-of-shrimps
0
1000
249.0
1
1
NIL
HORIZONTAL

TEXTBOX
17
26
167
44
Population
12
0.0
1

TEXTBOX
15
210
165
228
Movement Cost\n
12
0.0
1

SLIDER
16
236
212
269
shrimps-movement-cost
shrimps-movement-cost
0
2
0.4
0.1
1
NIL
HORIZONTAL

SLIDER
15
282
211
315
tunas-movement-cost
tunas-movement-cost
0
2
0.5
0.1
1
NIL
HORIZONTAL

SLIDER
17
331
212
364
sharks-movement-cost
sharks-movement-cost
0
4.0
0.5
0.1
1
NIL
HORIZONTAL

TEXTBOX
277
25
427
43
Energy gain\n
12
0.0
1

SLIDER
277
103
481
136
energy-gain-from-tunas
energy-gain-from-tunas
0
8
4.0
0.1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

This model is extended from Chapter Four of the book "Introduction to Agent-Based Modeling: Modeling Natural, Social and Engineered Complex Systems with NetLogo", by Uri Wilensky & William Rand. 

This represents a simple predator prey model of population dynamics, specifically in aqcuatic food chain.

## HOW IT WORKS

The model creates a population of shrimps, tunas, and sharks that wander around the ocean.  For each step the shrimps, tunas, and sharks swim around the ocean with the cost of energy. If their energy gets too low they die.  However, the sharks can eat tunas and shrimps and tunas can eat shrimp in the ocean to regain energy. The shrimps on the other hand reproduce without eating.  If the energy of the tunas ans sharks gets above a certain level then they can reproduce.

## HOW TO USE IT

Set the NUMBER-OF-SHRIMPS, NUMBER-OF-TUNAS, NUMBER-OF-SHARKS slider and press SETUP to create the initial population. You can also change the SHRIMPS-MOVEMENT-COST, TUNAS-MOVEMENT-COST, SHARKS-MOVEMENT-COST slider to affect the energy cost of movement for the agents.  The the ENERGY-GAIN-FROM-SHRIMPS and ENERGY-GAIN-FROM-TUNAS slider affects how much energy the tunas can gain from eating shrimps or how much energy the sharks can gain from eating tunas.

After this, press the GO button to make the shrimps, tunas, and sharks move around the ocean, and interact.

## THINGS TO NOTICE

How does the number of sheep affect the population levels?  How does the number of wolves affect the population levels?

Is there a spatial relationship between where the sheep do well and where the wolves do well?

How does the presence of wolves affect the system?

## THINGS TO TRY

Change the NUMBER-OF-TUNAS, while leaving the NUMBER-OF-SHARKS constant or vice-versa, how does this affect the model results?

How does the ENERGY-GAIN-FROM-SHRIMP and ENERGY-GAIN-FROM-TUNAS affect the model results?

## EXTENDING THE MODEL

Change the reproduction of shrimps, currently it is generated randomly with its population at maximum. You may also add algae which serves as the food for shrimp.
Adjusting the energy, size, and movement of the agents, according to theories will provide a more accurate representation of the acquatic food chain.

## NETLOGO FEATURES

No unusual features.

## RELATED MODELS

The Wolf Sheep Predation Model in the Biology section of the NetLogo models library.

## CREDITS AND REFERENCES

* Wilensky, U. & Rand, W. (2015). Introduction to Agent-Based Modeling: Modeling Natural, Social and Engineered Complex Systems with NetLogo. Cambridge, MA. MIT Press.

* Wilensky, U. (2007).  NetLogo Wolf Sheep Simple 5 model.  http://ccl.northwestern.edu/netlogo/models/WolfSheepSimple5.  Center for Connected Learning and Computer-Based Modeling, Northwestern Institute on Complex Systems, Northwestern University, Evanston, IL.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
