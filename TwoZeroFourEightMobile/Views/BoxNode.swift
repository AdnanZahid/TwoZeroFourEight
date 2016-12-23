//
//  BoxNode.swift
//  TwoZeroFourEight
//
//  Created by Adnan Zahid on 12/20/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

import SpriteKit

class BoxNode: SKSpriteNode {
    
    var labelNode: SKLabelNode?
    
    convenience init(blockSize: CGFloat) {
        
        self.init(color: UIColor.randomColor(), size: CGSize(width: blockSize, height: blockSize))
        
        labelNode = SKLabelNode(text: "0")
        labelNode?.isHidden = true
        labelNode?.setScale(2.0)
        labelNode?.position = CGPoint(x: labelNode!.frame.midX, y: -labelNode!.frame.midY)
        
        addChild(labelNode!)
    }
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeNumber(number: Int) {
        
        if number == 0 {
            
            labelNode?.text = ""
            
        } else {
            
            if labelNode?.isHidden == true {
                
                labelNode?.isHidden = false
            }
            
            labelNode?.text = String(number)
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
