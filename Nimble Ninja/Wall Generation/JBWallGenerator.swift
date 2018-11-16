//
//  JBWallGenerator.swift
//  Nimble Ninja
//
//  Created by Joydeep on 07/08/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit

class JBWallGenerator: SKSpriteNode {
    var generationTimer : Timer?
    
    func startGeneratingWallsEvery(seconds : TimeInterval){
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(self.generateWall), userInfo: nil, repeats: true)
    }
    
    @objc func generateWall(){
        var scale : CGFloat
        let rand = arc4random_uniform(UInt32(2))
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        
        let wall = JBWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale*(KJBGroundHeight/2 + wall.size.height/2)
        addChild(wall)
    }
}
