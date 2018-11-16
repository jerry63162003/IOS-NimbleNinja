//
//  JBHero.swift
//  Nimble Ninja
//
//  Created by Joydeep on 28/07/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit

class JBHero: SKSpriteNode {
    
    var body : SKSpriteNode!
    var arm : SKSpriteNode!
    var leftFoot : SKSpriteNode!
    var rightFoot : SKSpriteNode!
    
    var isUpSideDown = false
    
    
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 32, height: 44))
        zPosition = 10
        
        body = SKSpriteNode(color: UIColor.black, size: CGSize(width: self.frame.size.width, height: 40))
        body.position = CGPoint(x: 0.0, y: 2.0)
        addChild(body)
        
        let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        let face = SKSpriteNode(color: skinColor, size: CGSize(width: self.frame.size.width, height: 12))
        face.position = CGPoint(x: 0.0, y: 6.0)
        body.addChild(face)

        let eyeColor = UIColor.white
        let leftEye = SKSpriteNode(color: eyeColor, size: CGSize(width: 6.0, height: 6.0))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.black, size: CGSize(width: 3.0, height: 3.0))

        pupil.position = CGPoint(x: 2.0, y: 0.0)

        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)

        leftEye.position = CGPoint(x: -4.0, y: 0.0)
        face.addChild(leftEye)

        rightEye.position = CGPoint(x: 14.0, y: 0.0)
        face.addChild(rightEye)

        let eyebrow = SKSpriteNode(color: UIColor.black, size: CGSize(width: 11.0, height: 1.0))
        eyebrow.position = CGPoint(x: -1, y: leftEye.size.height/2)
        leftEye.addChild(eyebrow)
        rightEye.addChild(eyebrow.copy() as! SKSpriteNode)

        let armColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        arm = SKSpriteNode(color: armColor, size: CGSize(width: 8.0, height: 14.0))
        arm.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        arm.position = CGPoint(x: -10.0, y: -7.0)
        body.addChild(arm)

        let hand = SKSpriteNode(color: skinColor, size: CGSize(width: arm.size.width, height: 5.0))
        hand.position = CGPoint(x: 0.0, y: -arm.size.height*0.9 + hand.size.height/2)
        arm.addChild(hand)

        leftFoot = SKSpriteNode(color: UIColor.black, size: CGSize(width: 9.0, height: 4.0))
        leftFoot.position = CGPoint(x: -6.0, y: -size.height/2 + leftFoot.size.height/2)
        addChild(leftFoot)

        rightFoot = leftFoot.copy() as! SKSpriteNode
        rightFoot.position.x = 8
        addChild(rightFoot)
        
        name = "Hero"
        physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 32, height: 44))
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = ColliderType.HERO_COLLIDER
        physicsBody?.collisionBitMask = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip(){
        isUpSideDown = !isUpSideDown
        
        var scale : CGFloat!
        if isUpSideDown{
            scale = -1.0
        } else {
            scale = 1.0
        }
        let translate = SKAction.moveBy(x: 0.0, y: scale*(size.height + KJBGroundHeight), duration: 0.1)
        let flip = SKAction.scaleY(to: scale, duration: 0.1)
        
        run(translate)
        run(flip)
        
    }
    
    func startRunning(){
        let rotateBack = SKAction.rotate(byAngle: .pi/2, duration: 0.1)
        arm.run(rotateBack)

        performOneRunCycle()
    }
    
    func performOneRunCycle(){
        let up = SKAction.moveBy(x: 0.0, y: 2.0, duration: 0.05)
        let down = SKAction.moveBy(x: 0.0, y: -2.0, duration: 0.05)
        
        leftFoot.run(up) {
            self.leftFoot.run(down)
            self.rightFoot.run(up, completion: {
                self.rightFoot.run(down, completion: {
                    self.performOneRunCycle()
                })
            })
        }
    }
    
    
    
    func breathe() {
        let breatheOut = SKAction.moveBy(x: 0.0, y: -2.0, duration: 1)
        let breatheIn = SKAction.moveBy(x: 0.0, y: 2.0, duration: 1)
        
        let breathe = SKAction.sequence([breatheOut, breatheIn])
        body.run(SKAction.repeatForever(breathe))
    }
    
    func stop(){
        body.removeAllActions()
    }
    
}
