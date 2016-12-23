//
//  Box.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 11/18/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

//Protocal that copyable class should conform
protocol Copying {
    init(original: Self)
}

//Concrete class extension
extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

protocol BoxDelegate: class {
    
    func move(box: Box, direction: Direction)
    
    func merge(firstBox: Box, secondBox: Box)
    
    func leftBox(box: Box) -> Box?
    func rightBox(box: Box) -> Box?
    func upBox(box: Box) -> Box?
    func downBox(box: Box) -> Box?
}

class Box: Copying {
    
    var x: Int
    var y: Int
    
    var number: Int
    
    var upWall: Bool = false
    var leftWall: Bool = false
    var rightWall: Bool = false
    var downWall: Bool = false
    
    var upBox: Box?
    var leftBox: Box?
    var rightBox: Box?
    var downBox: Box?
    
    weak var delegate: BoxDelegate?
    
    init(x: Int, y: Int, number: Int, delegate: BoxDelegate) {
        
        self.number = number
        self.delegate = delegate
        
        self.x = x
        self.y = y
    }
    
    required init(original: Box) {
        
        x = original.x
        y = original.y
        
        number = original.number
        
        delegate = original.delegate
    }
    
    func setupBox(x: Int, y: Int) {
    
        self.x = x
        self.y = y
    }
    
    func setupWalls() {
        
        if x == 0 {
            
            leftWall = true
            
        } else {
            
            leftWall = false
        }
        
        if x == maxX {
            
            rightWall = true
            
        } else {
            
            rightWall = false
        }
        
        if y == 0 {
            
            upWall = true
            
        } else {
            
            upWall = false
        }
        
        if y == maxY {
            
            downWall = true
            
        } else {
            
            downWall = false
        }
        
        leftBox = delegate?.leftBox(box: self)
        rightBox = delegate?.rightBox(box: self)
        upBox = delegate?.upBox(box: self)
        downBox = delegate?.downBox(box: self)
    }
    
    func canMove(direction: Direction) -> Bool {
        
        if direction == Direction.Left && leftBox == nil && leftWall == false {
            
            return true
            
        } else if direction == Direction.Right && rightBox == nil && rightWall == false {
            
            return true
            
        } else if direction == Direction.Up && upBox == nil && upWall == false {
                
            return true
            
        } else if direction == Direction.Down && downBox == nil && downWall == false {
                
            return true
        }
        
        return false
    }
    
    func canMerge(direction: Direction) -> Bool {
        
        if direction == Direction.Left && leftBox?.number == number {
            
            return true
            
        } else if direction == Direction.Right && rightBox?.number == number {
            
            return true
            
        } else if direction == Direction.Up && upBox?.number == number {
            
            return true
            
        } else if direction == Direction.Down && downBox?.number == number {
            
            return true
        }
        
        return false
    }
    
    func move(direction: Direction) {
        
        delegate?.move(box: self, direction: direction)
    }
    
    func merge(direction: Direction) {
        
        if direction == Direction.Left && leftBox != nil {
            
            delegate?.merge(firstBox: self, secondBox: leftBox!)
            
        } else if direction == Direction.Right && rightBox != nil {
            
            delegate?.merge(firstBox: self, secondBox: rightBox!)
            
        } else if direction == Direction.Up && upBox != nil {
            
            delegate?.merge(firstBox: self, secondBox: upBox!)
            
        } else if direction == Direction.Down && downBox != nil {
            
            delegate?.merge(firstBox: self, secondBox: downBox!)
        }
    }
}
