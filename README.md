# Two Zero Four Eight bot

This is a **2048 playing bot** written in Swift.

Here is a summary of it's working principle:

1. It utilizes the well-known **expectimax algorithm** for constructing stochastic decision trees (probability based trees).
2. Stochastic decision trees cannot be pruned so we leave them as is.
3. Then it traverses that tree, evaluates the highest ranked move and plays it.
4. The depth of decision tree is **2**.

Here's a screenshot of the bot in motion:

![Screenshot](https://github.com/AdnanZahid/TwoZeroFourEight/blob/master/Screenshot.png)

Please see the following files for more information:

[AISolver.swift](https://github.com/AdnanZahid/TwoZeroFourEight/blob/master/TwoZeroFourEight/AISolver.swift)

Graphical programming is done in Apple's SpriteKit framework (used for 2D graphics programming).