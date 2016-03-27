## TicTacToe (AI branch)

21 March 2016

TicTacToe, in Ruby.  It isn't perfect but has taught me plenty.

#### The story so far:
I'm still early on and made what now feels like the rookie error of leaping in to hack away at it.  At first I got it working, then (after the fact) I learnt a little about tests and built some.

This has been a learning curve, and I'll be doing some more digging into good practices for testing.  The ones I produced seemed tied to code - they had (and still have) a tendency to break at slight changes that I think is symptomatic of writing the code first.
The process also taught me just how much discipline is required to resist the urge to bolt off.  It seems to be early days yet on that front!
I also backed out of developing meaningful tests for aspects that currently look tricky, such as the main game loop.  

This was also the first time I dug into git - I have similar lessons to learn about version control in practice.  I see now that Git is a lot deeper than it looks at a first pass.  Similar points about discipline apply too, especially with keeping commits to a sensible size and using them to put together a narrative which would make sense from the outside.

Once I'd got it working, I:
- Refactored and got the methods shorter, and closer to an ideal of one function per method
- Added some methods to validate input (using loops, which feels awkward)
- Lifted out display aspects (the 'views') but not into own class yet
- Discovered RSpec and started playing with that

But then I got ambitious and thought I'd add the AI.

Lesson: it's dangerous to (A)code at night (B)code while drunk - code base got the bloat very quickly!  Very easy to end up with code in urgent need of refactoring, very quickly.
BUT - it's passing tests so far and the AI will happily produce draw after draw when it plays itself.  The ranking system I think leaves room to set the AI to behave sub-optimally, for more of a 'gamey' feel

#### Is it SOLID?
As it stands today, I think it's safe to say not really.  While some of the refactoring helped with the early code base, it is now at a state where

- Player has some board checking methods, some assessment methods, some moving methods and details about the player's properties.  These need separating!
- Board has information about the board's state, methods to report on that, methods to calculate particular game-relevant details (how many non-blocked lines, etc), grid-specific calculators to make inputting human-friendly, and validity checks
- Game holds the game objects, maintains the game loop, has all the display methods, gets input, and has some methods to check game status
Given that SRP generally requires no 'ands' in the spec for a class, I think it's safe to say this scores pretty poorly on single responsibility

- Board and player seem to have become tightly dependent, as have game and board.  The game is likely to have some tight dependencies, but I would like to re-use the board later on - so need to find a way to decouple it now
- Interfaces - in the initial iteration these were okay - a short list of sensible public methods, and helper methods tucked away.  With the AI work many of Board's private methods have been exposed.  These could happily be hidden again once I have separated out the game-specific checks on the board to part of the AI class.

#### To do (in the immediate future)
- Finish test suite so it is complete and robust.  nb seems flaky when there are multiple ways to (e.g.) block a fork
- Refactor out the evaluation code.  In some ways it seems like it belongs with board, but uncoupled from the basic 'what is where' methods
- Refactor out the display code into as own class/module

