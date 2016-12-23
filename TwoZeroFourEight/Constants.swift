//
//  Constants.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 12/20/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

let maxX = 3
let maxY = 3

enum Direction {
    
    case Up
    case Left
    case Right
    case Down
}

struct EvaluationMove {
    
    let direction: Direction?
    let evaluationValue: Int
}
