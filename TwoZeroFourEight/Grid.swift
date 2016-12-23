//
//  boxArray.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 11/18/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

protocol GridDelegate: class {
    
    func placeBox(box: Box)
    
    func move(box: Box, to x: Int, to y: Int)
    
    func merge(firstBox: Box, secondBox: Box)
    
    func didUndoMove()
    
    func gameOver()
}

class Grid: BoxDelegate {
    
    var boxArray: [[Box?]] = [[Box?]](repeating: [Box?](repeating: nil, count: maxX + 1), count: maxX + 1)
    
    var emptyBoxXYPairArray: [(Int, Int)] = []
    
    var boxArrayStack: Stack = Stack()
    
    var randomBoxGenerator: RandomBoxGenerator?
    
    func setup() {
        
        placeBox()
        
        placeBox()
        
        setupWalls()
    }
    
    func populateEmptyBoxXYPairArray() {
        
        emptyBoxXYPairArray = []
        
        for y in 0 ..< boxArray.count {
            
            for x in 0 ..< boxArray[y].count {
                
                let box: Box? = boxArray[x][y]
                
                if box == nil {
                
                    emptyBoxXYPairArray.append((x: x, y: y))
                }
            }
        }
    }
    
    func placeBox() {
        
        populateEmptyBoxXYPairArray()
        
        let boxAndCoordinates: (Box, Int, Int) = randomBoxGenerator!.generateBox(emptyBoxXYPairArray: emptyBoxXYPairArray, boxDelegate: self)
        
        let box: Box = boxAndCoordinates.0
        
        let x: Int = boxAndCoordinates.1
        let y: Int = boxAndCoordinates.2
        
        boxArray[x][y] = box
        
        if areEmptySpotsAvailable() == false {
            
            randomBoxGenerator?.gridDelegate?.gameOver()
        
        } else {
            
            randomBoxGenerator?.gridDelegate?.placeBox(box: box)
        }
    }
    
    func leftBox(box: Box) -> Box? {
        
        if box.leftWall == false {
            
            return boxArray[box.x - 1][box.y]
        }
        
        return nil
    }
    
    func rightBox(box: Box) -> Box? {
        
        if box.rightWall == false {
            
            return boxArray[box.x + 1][box.y]
        }
        
        return nil
    }
    
    func upBox(box: Box) -> Box? {
        
        if box.upWall == false {
            
            return boxArray[box.x][box.y - 1]
        }
        
        return nil
    }
    
    func downBox(box: Box) -> Box? {
        
        if box.downWall == false {
            
            return boxArray[box.x][box.y + 1]
        }
        
        return nil
    }
    
    func merge(firstBox: Box, secondBox: Box) {
        
        let totalNumber: Int = firstBox.number + secondBox.number
        
        boxArray[secondBox.x][secondBox.y]?.number = totalNumber
        
        boxArray[firstBox.x][firstBox.y] = nil
        
        randomBoxGenerator?.gridDelegate?.merge(firstBox: firstBox, secondBox: boxArray[secondBox.x][secondBox.y]!)
    }
    
    func move(box: Box, direction: Direction) {
        
        boxArray[box.x][box.y] = nil
        
        var x: Int
        var y: Int
        
        if direction == Direction.Left {
            
            x = box.x - 1
            y = box.y
            
        } else if direction == Direction.Right {
            
            x = box.x + 1
            y = box.y
            
        } else if direction == Direction.Up {
            
            x = box.x
            y = box.y - 1
            
        } else {
            
            x = box.x
            y = box.y + 1
        }
        
        randomBoxGenerator?.gridDelegate?.move(box: box, to: x, to: y)
        
        box.setupBox(x: x, y: y)
        
        boxArray[x][y] = box
    }
    
    func areEmptySpotsAvailable() -> Bool {
        
        return emptyBoxXYPairArray.count > 0
    }
    
    func takeLeftTurn() -> Bool {
        
        var isTurnTaken: Bool = false
        
        let direction: Direction = Direction.Left
        
        for y in 0 ..< boxArray.count {
            
            for x in 0 ..< boxArray[y].count {
                
                if let box: Box = boxArray[x][y] {
                    
                    while box.canMove(direction: direction) {
                        
                        box.move(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                    
                    if box.canMerge(direction: direction) {
                        
                        box.merge(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                }
            }
        }
        
        return isTurnTaken
    }
    
    func takeRightTurn() -> Bool {
        
        var isTurnTaken: Bool = false
        
        let direction: Direction = Direction.Right
        
        for y in 0 ..< boxArray.count {
            
            for x in (0 ..< boxArray[y].count).reversed() {
                
                if let box: Box = boxArray[x][y] {
                    
                    while box.canMove(direction: direction) {
                        
                        box.move(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                    
                    if box.canMerge(direction: direction) {
                        
                        box.merge(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                }
            }
        }
        
        return isTurnTaken
    }
    
    func takeUpTurn() -> Bool {
        
        var isTurnTaken: Bool = false
        
        let direction: Direction = Direction.Up
        
        for y in 0 ..< boxArray.count {
            
            for x in 0 ..< boxArray[y].count {
                
                if let box: Box = boxArray[x][y] {
                    
                    while box.canMove(direction: direction) {
                        
                        box.move(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                    
                    if box.canMerge(direction: direction) {
                        
                        box.merge(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                }
            }
        }
        
        return isTurnTaken
    }
    
    func takeDownTurn() -> Bool {
        
        var isTurnTaken: Bool = false
        
        let direction: Direction = Direction.Down
        
        for y in (0 ..< boxArray.count).reversed() {
            
            for x in 0 ..< boxArray[y].count {
                
                if let box: Box = boxArray[x][y] {
                    
                    while box.canMove(direction: direction) {
                        
                        box.move(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                    
                    if box.canMerge(direction: direction) {
                        
                        box.merge(direction: direction)
                        
                        setupWalls()
                        
                        isTurnTaken = true
                    }
                }
            }
        }
        
        return isTurnTaken
    }
    
    func clone2DArray(array: [[Box?]]) -> [[Box?]] {
        
        var newArray: [[Box?]] = []
        
        for x in 0 ..< boxArray.count {
            
            newArray.append([])
            
            for y in 0 ..< boxArray[x].count {
                
                let box: Box? = boxArray[x][y]
                    
                newArray[x].append(box?.copy())
            }
        }
        
        return newArray
    }
    
    func takeTurn(direction: Direction) -> Bool {
        
        let oldBoxArray: [[Box?]] = clone2DArray(array: boxArray)
        
        var isTurnTaken: Bool = false
        
        if direction == Direction.Left {
            
            isTurnTaken = takeLeftTurn()
            
        } else if direction == Direction.Right {
            
            isTurnTaken = takeRightTurn()
            
        } else if direction == Direction.Up {
            
            isTurnTaken = takeUpTurn()
            
        } else {
            
            isTurnTaken = takeDownTurn()
        }
        
        if isTurnTaken == true {
            
            placeBox()
            
            setupWalls()
            
            boxArrayStack.push(oldBoxArray)
        }
        
        return isTurnTaken
    }
    
    func undoMove() {
        
        if let poppedBoxArray = boxArrayStack.pop() {
        
            boxArray = poppedBoxArray
            
            populateEmptyBoxXYPairArray()
            
            setupWalls()
            
            randomBoxGenerator?.gridDelegate?.didUndoMove()
            
            for y in 0 ..< boxArray.count {
                
                for x in 0 ..< boxArray[y].count {
                    
                    if let box: Box = boxArray[x][y] {
                        
                        randomBoxGenerator?.gridDelegate?.placeBox(box: box)
                    }
                }
            }
        }
    }
    
    func setupWalls() {
        
        for y in 0 ..< boxArray.count {
            
            for x in 0 ..< boxArray[y].count {
                
                if let box: Box = boxArray[x][y] {
                    
                    box.setupWalls()
                }
            }
        }
    }
    
    func printBoxArray() {
        
        for y in 0 ..< boxArray.count {
        
            for x in 0 ..< boxArray[y].count {
                
                print("-", separator: "", terminator: " ")
                
                if let box = boxArray[x][y] {
                
                    print(box.number, separator: "", terminator: " ")
                    
                } else {
                    
                    print("x", separator: "", terminator: " ")
                }
            }
            
            print("-", separator: "", terminator: " ")
            
            print("\n")
        }
        
        print("\n")
        print("\n")
    }
}
