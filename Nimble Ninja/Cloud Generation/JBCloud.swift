//
//  JBCloud.swift
//  Nimble Ninja
//
//  Created by Joydeep on 07/08/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit

class JBCloud: SKShapeNode {
    init(size : CGSize) {
        super.init()
        let path = CGPath(ellipseIn: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height), transform: nil)
        zPosition = 10
        
        self.path = path
        fillColor = UIColor.white
        
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving(){
        let moveLeft = SKAction.moveBy(x: -10.0, y: 0.0, duration: 1.0)
        run(SKAction.repeatForever(moveLeft))
    }
}
