//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by Joydeep on 26/07/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var scoreLabel: SKLabelNode = SKLabelNode()
    
    var movingGround : JBMovingGround!
    var hero : JBHero!
    var cloudGenerator : JBCloudGenerator!
    var wallGenerator : JBWallGenerator!
    
    var isStarted = false
    var score: Int = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.init(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        physicsWorld.contactDelegate = self
        
        let bg = SKSpriteNode(imageNamed: "bg_game")
        bg.size = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        bg.position = CGPoint(x: view.center.x, y: view.center.y)
        addChild(bg)
        
        
        let scoreSprite = SKSpriteNode(imageNamed: "实时分数")
        scoreSprite.size = CGSize(width: 85, height: 40)
        scoreSprite.position = CGPoint(x: 340, y: 700)
        addChild(scoreSprite)
        
//        let backSprite = SKSpriteNode(imageNamed: "返回")
//        backSprite.size = CGSize(width: 37, height: 37)
//        backSprite.position = CGPoint(x: 40, y: 700)
//        backSprite.name = "backHome"
//        addChild(backSprite)
        
        //Add groud
        movingGround = JBMovingGround(size: CGSize(width: view.frame.size.width, height: KJBGroundHeight))

        movingGround.position = CGPoint(x: 0, y: view.frame.height / CGFloat(2))
        addChild(movingGround)
        
        //Add hero
        
        hero = JBHero()
        hero.position = CGPoint(x: 70.0, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
        
        //Add cloud generator
        cloudGenerator = JBCloudGenerator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = view.center
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 7)
        cloudGenerator.startGeneratingWithSpawnTime(seconds: 7)
        
        // Add wall generator
        wallGenerator = JBWallGenerator(color: UIColor.clear, size: view.frame.size)
        wallGenerator.position = view.center
        addChild(wallGenerator)
        
        // Add Tap to start label
        let tapToStartLabel = SKLabelNode(text: "点击开始!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view.center.x
        tapToStartLabel.position.y = view.center.y + 40
        tapToStartLabel.fontColor = UIColor.black
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontSize = 22.0
        addChild(tapToStartLabel)
        
        //add score label
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.zPosition = 10
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 25.0
        scoreLabel.fontColor = UIColor(red: 188/255.0, green: 66/255.0, blue: 38/255.0, alpha: 1.0)
        scoreLabel.position = CGPoint(x:  350, y: 690)
        addChild(scoreLabel)
    }
    
    func start(){
        isStarted = true
        let tapToStartLabel = childNode(withName: "tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        hero.stop()
        hero.startRunning()
        movingGround.start()
        wallGenerator.startGeneratingWallsEvery(seconds:  GameConfig.shared.getTimeByMode())
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addScore), userInfo: nil, repeats: true)
    }
    
    @objc func addScore() {
        if !isStarted {
            return
        }
    
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    func gameOver() {
        isStarted = false
        
        if score > GameConfig.shared.highScore {
            GameConfig.shared.highScore = score
        }
        
        let gameOverScene = SKScene(fileNamed: "GameOverScene")!
        gameOverScene.scaleMode = .aspectFill
        (gameOverScene as! GameOverScene).score = score
        view?.presentScene(gameOverScene, transition: SKTransition.doorway(withDuration: 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isStarted{
            start()
        } else {
            hero.flip()
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var first: SKPhysicsBody?
        if contact.bodyA.node?.name == "Hero" || contact.bodyA.node?.name == "Wall" {
            first = contact.bodyA
        }else {
            first = contact.bodyB
        }
        
        first?.node?.removeFromParent()
        
        gameOver()
    }
}
