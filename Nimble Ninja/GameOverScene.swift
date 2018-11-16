//
//  GameOverScene.swift
//  Nimble Ninja
//
//  Created by roy on 2018/8/9.
//  Copyright © 2018年 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var scoreLabel: SKLabelNode = SKLabelNode()
    var gameAginSprite: SKSpriteNode = SKSpriteNode()
    var goBackSprite: SKSpriteNode = SKSpriteNode()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "得分 \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        gameAginSprite = self.childNode(withName: "gameAgin") as! SKSpriteNode
        goBackSprite = self.childNode(withName: "goBack") as! SKSpriteNode
        
        scoreLabel.text = "得分 \(score)"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let touchLocaion = touch.location(in: self)
            
            if atPoint(touchLocaion).name == "gameAgin" {
                let gameScene = GameScene(size: view!.bounds.size)
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorway(withDuration: 1))
            }
            
            if atPoint(touchLocaion).name == "goBack" {
                let mainScene = SKScene(fileNamed: "MainScene")!
                mainScene.scaleMode = .aspectFill
                view?.presentScene(mainScene, transition: SKTransition.doorway(withDuration: 1))
            }
        }
    }
}
