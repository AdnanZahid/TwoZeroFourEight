//
//  main.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 11/18/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

let grid: Grid = Grid()

grid.printBoxArray()

grid.takeTurn(direction: Direction.Down)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Left)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Right)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Down)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Up)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Left)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Down)

grid.printBoxArray()

grid.takeTurn(direction: Direction.Right)

grid.printBoxArray()
