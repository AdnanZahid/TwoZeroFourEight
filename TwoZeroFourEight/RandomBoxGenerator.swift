//
//  RandomBoxGenerator.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 12/23/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

import Foundation

class RandomBoxGenerator {
    
    let initialNumbersArray: [Int] = [2, 2, 2, 2, 2, 2, 2, 2, 2, 4]
    
    var isRandom: Bool
    
    var nextNumber: Int?
    var nextXYPair: (Int, Int)?
    
//    var nextXYPair: (Int, Int)?
    
    weak var gridDelegate: GridDelegate?
    
    init(isRandom: Bool, gridDelegate: GridDelegate?) {
        
        self.isRandom = isRandom
        
        self.gridDelegate = gridDelegate
    }

    func generateRandomXYPair(emptyBoxXYPairArray: [(Int, Int)]) -> (Int, Int) {
        
        let randomNumber: Int = Int(arc4random_uniform(UInt32(emptyBoxXYPairArray.count)))
        
        let xyPair: (Int, Int) = emptyBoxXYPairArray[randomNumber]
        
        return xyPair
    }

    func generateBox(emptyBoxXYPairArray: [(Int, Int)], boxDelegate: BoxDelegate) -> (Box, Int, Int) {
        
        var number: Int
        
        var xyPair: (Int, Int)
        
        if isRandom == true {
            
//            number = initialNumbersArray[Int(arc4random_uniform(10))]
            
            number = 2
            
            xyPair = generateRandomXYPair(emptyBoxXYPairArray: emptyBoxXYPairArray)
            
        } else {
            
            number = nextNumber!
                
            xyPair = nextXYPair!
        }
        
        let x: Int = xyPair.0
        let y: Int = xyPair.1
        
        let box: Box = Box(x: x, y: y, number: number, delegate: boxDelegate)
        
        return (box, x, y)
    }
}
