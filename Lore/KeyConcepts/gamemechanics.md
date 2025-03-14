Game Loop
=========
The top of this loop is where constants and globals are stored, generally those that allow the Lunar Calender to operate as its a law of physics. On the other hand branches are where things like instance variabls and local
exclusive variables are stored., such as dungeon per dungeon functions.

1. Enemy Behaviours
-------------------

* Initialization vector

* Remembered player behaviours shuffled, with one action removed the player no
longer does.

* Actions based on most frequent player actions.


2. NPC Behaviours
-----------------

* NPCs aids player by taking them to safety.

* NPCs aids player by helping them find out where to find an enemy tracking
device.

* NPC helps player by telling them about how dungeon mechanics works, and offers
items for sale.

* Key point is NPCs are often the previous protagonist of previous games,
otherwise how would they know where the tracking device or pet is. An entire map
is made about those behaviours.


3. Grid Based Semi-Autonomous Characters [ Gribatomatons ]
----------------------------------------------------------

* In a passive state only feeds itself and grows over time.

* In a passive state, actively tracks what the enemy is learning about the
player's actions.


4. Player Behaviours
--------------------

* Player needs device to learn what enemy knows.
  - With device, plays sees what enemy is actively learning.
  - You can then choose alternate behaviour branches to confuse the enemy.


* Otherwise player can't predict what enemy knows about player.
