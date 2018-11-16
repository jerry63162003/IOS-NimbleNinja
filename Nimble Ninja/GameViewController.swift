//
//  GameViewController.swift
//  Nimble Ninja
//
//  Created by Joydeep on 26/07/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene : MainScene!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        //Create and configure the scene
        scene = SKScene(fileNamed: "MainScene")! as! MainScene
        scene.scaleMode = .aspectFill
        
        //Present the scene
        skView.presentScene(scene)
        
        
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
