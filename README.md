# Uncharted Realms
## What it does
A simple card game, with a slight twist. Starting off with 3 randomly generated cards that are served to your hand by a neural network. All the cards were generated using a sophisticated set of data to make sure the stats of each card was balanced enough that people wouldn't want to stop playing our game.

## How we built it
We used scikit learn to create our neural network for generating cards. A linear regression is created by fitting the stats of existing cards against their cost. Numerical values have a simple linear fit, but more complex stats like specific words had to be turn into numerical representations called "one hot". Cards were then generated for users to play games with, and these cards were then sent back to the network and were used to retrain the network and improve its confidence.

The game itself was developed with Love2D, a lightweight Lua game engine. It gets JSON data from our neural network through our backend done in Flask.

## Challenges we ran into
Lua is the language that we all had to start learning beginning on the first day of the hackathon. Our team had a difficult time programming in this language because we didn't know how the language worked and how to develop a game. On top of Lua, we wanted to implement a neural network, and we had a hard time starting off and finding a framework that we could understand and use.

## Accomplishments that we're proud of
The biggest accomplishment of this hackathon was the implementation of the neural network using Python and our ability to learn to build a simple game from scratch using Love2D.

## What's next for Uncharted Realms
The next step for Uncharted Realms is to allow users to play with others, due to the time limit and our inexperience using Love2D, a lot of the functionality that we wanted to implement were unable to be accomplished.
