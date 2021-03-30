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
