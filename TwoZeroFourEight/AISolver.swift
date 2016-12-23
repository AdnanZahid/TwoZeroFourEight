//
//  AISolver.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 12/22/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

protocol AIDelegate: class {
    
    func didCalculateMoveDirection(direction: Direction)
    
    func gameOver()
}

class AISolver {
    
    let thinkingDepth: Int = 3
    
    let directionsList: [Direction] = [Direction.Left, Direction.Right, Direction.Up, Direction.Down]
    
    let randomBoxGenerator: RandomBoxGenerator
    
    weak var delegate: AIDelegate?
    
    init() {
        
        randomBoxGenerator = RandomBoxGenerator(isRandom: false, gridDelegate: nil)
    }
    
    func calculateMoveDirection(grid: Grid) {
        
        grid.randomBoxGenerator = randomBoxGenerator
        
        if let direction: Direction = firstExpectimax(grid: grid, depth: thinkingDepth).direction {
        
            delegate?.didCalculateMoveDirection(direction: direction)
            
        } else {
            
            delegate?.gameOver()
        }
    }
    
    func firstExpectimax(grid: Grid, depth: Int) -> EvaluationMove {
        
        var bestMove: EvaluationMove = EvaluationMove(direction: nil, evaluationValue: Int.min)
        
        for direction in directionsList {
            
            for xyPair in grid.emptyBoxXYPairArray {
                
                randomBoxGenerator.nextNumber = 2
                randomBoxGenerator.nextXYPair = xyPair
            
                if grid.takeTurn(direction: direction) {
                    
                    let evaluationMove: EvaluationMove = EvaluationMove(direction: direction, evaluationValue: expectimax(grid: grid, depth: depth - 1))
                    
                    grid.undoMove()
                    
                    if evaluationMove.evaluationValue > bestMove.evaluationValue {
                        
                        bestMove = evaluationMove
                    }
                }
            }
        }
        
        return bestMove
    }
    
    func expectimax(grid: Grid, depth: Int) -> Int {
        
        if depth == 0 {
            
            return calculateEmptyBoxScore(grid: grid)
        }
        
        var bestEvaluationValue: Int = Int.min
        
        for direction in directionsList {
            
            for xyPair in grid.emptyBoxXYPairArray {
                
                randomBoxGenerator.nextNumber = 2
                randomBoxGenerator.nextXYPair = xyPair
            
                if grid.takeTurn(direction: direction) {
                
                    let evaluationValue: Int = expectimax(grid: grid, depth: depth - 1)
                    
                    grid.undoMove()
                    
                    if evaluationValue > bestEvaluationValue {
                        
                        bestEvaluationValue = evaluationValue
                    }
                }
            }
        }
        
        return bestEvaluationValue
    }
    
    func calculateEmptyBoxScore(grid: Grid) -> Int {
        
        var evaluationValue: Int = 0
        
        for y in 0 ..< grid.boxArray.count {
            
            for x in 0 ..< grid.boxArray[y].count {
                
                if grid.boxArray[x][y] == nil {
                    
                    evaluationValue += 1
                }
            }
        }
        
        return evaluationValue
    }
}
