//
//  JBMovingGround.swift
//  Nimble Ninja
//
//  Created by Joydeep on 27/07/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit


class JBMovingGround : SKSpriteNode{
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 10.0/255.0, green: 140.0/255.0, blue: 0.7/225.0, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 110.0/255.0, alpha: 1.0)
    
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.brown, size: CGSize(width: size.width*2, height: size.height))
        anchorPoint = CGPoint(x: 0, y: 0.5)
        zPosition = 10
        
        for number in 0..<NUMBER_OF_SEGMENTS {
            var segmentColor : UIColor!
            if number % 2 == 0{
                segmentColor = COLOR_ONE
            }else{
                segmentColor = COLOR_TWO
            }
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width / CGFloat(NUMBER_OF_SEGMENTS), height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            segment.position = CGPoint(x: CGFloat(number) * segment.size.width, y: 0)
            addChild(segment)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented") 
    }
    func start() {
        let adjustedDuration = frame.size.width / KDefaultxToMovePerSecond
        let moveLeft = SKAction.moveBy(x: -frame.size.width / 2, y: 0.0, duration: TimeInterval(adjustedDuration/2))
        let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        run(SKAction.repeatForever(moveSequence))
    }
    
}
