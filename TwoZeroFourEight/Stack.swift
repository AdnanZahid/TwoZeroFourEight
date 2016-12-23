//
//  Stack.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 12/23/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

class Stack {
    
    fileprivate var stackArray: [[[Box?]]] = []
    
    func clear() {
        
        stackArray.removeAll()
    }
    
    func push(_ moveState: [[Box?]]) {
        
        stackArray.append(moveState)
    }
    
    func pop() -> [[Box?]]? {
        
        if let moveState = stackArray.last {
            
            stackArray.removeLast()
            
            return moveState
            
        } else {
            
            return nil
        }
    }
}
