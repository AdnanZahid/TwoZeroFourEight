//
//  GameViewController.swift
//  TwoZeroFourEightMobile
//
//  Created by Adnan Zahid on 12/20/16.
//  Copyright © 2016 Adnan Zahid. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            gameScene = SKScene(fileNamed: "GameScene") as! GameScene?
            
            if gameScene != nil {
                // Set the scale mode to scale to fit the window
                gameScene?.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(gameScene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func undoButtonTapped(_ sender: AnyObject) {
        
        gameScene?.undoMove()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
