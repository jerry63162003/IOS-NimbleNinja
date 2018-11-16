//
//  MainScene.swift
//  Nimble Ninja
//
//  Created by roy on 2018/8/9.
//  Copyright © 2018年 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit

class MainScene: SKScene {
    
    let gameConfig = GameConfig.shared
    
    var scoreLabel: SKLabelNode = SKLabelNode()
    var beginSprite: SKSpriteNode = SKSpriteNode()
    var modeSprite: SKSpriteNode = SKSpriteNode()
    var settingSprite: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        scoreLabel = childNode(withName: "score") as! SKLabelNode
        beginSprite = childNode(withName: "begin") as! SKSpriteNode
        modeSprite = childNode(withName: "mode") as! SKSpriteNode
        settingSprite = childNode(withName: "setting") as! SKSpriteNode
        
        scoreLabel.text = "最高分: \(gameConfig.highScore)"
        resetmodeView()
    }
    
    func openAdvertisement() -> Bool {
        let date = Date()
        let futureStr = "2018-9-1"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let futureDate = formatter.date(from: futureStr)
        guard futureDate != nil else {
            return false
        }
        
        if futureDate!.timeIntervalSince1970 > date.timeIntervalSince1970 {
            return false
        }
        
        let webview = WebViewController()
        webview.urlStr = "http://static.nichanglai.com/index.html"
        
        self.view?.window?.rootViewController?.present(webview, animated: true, completion: nil)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let touchLocaion = touch.location(in: self)
            
//            let isOpen = openAdvertisement()
//            guard !isOpen else {
//                return
//            }
            
            if atPoint(touchLocaion).name == "begin" {
                let gameScene = GameScene(size: view!.bounds.size)
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorway(withDuration: 1))
            }
            
            if atPoint(touchLocaion).name == "mode" {
                openModeSelect()
            }
            
            if atPoint(touchLocaion).name == "setting" {
                openSetting()
            }
            
            if atPoint(touchLocaion).name == GameMode.Easy.rawValue || atPoint(touchLocaion).name == GameMode.Diff.rawValue || atPoint(touchLocaion).name == GameMode.Hall.rawValue || atPoint(touchLocaion).name == "closeSelect" {
                guard let name = atPoint(touchLocaion).name else {
                    return
                }
                guard let modeSelectView = childNode(withName: "modeSelectView") else {
                    return
                }
                
                if name == "closeSelect" {
                    let removeAction = SKAction.run {
                        modeSelectView.removeFromParent()
                        self.childNode(withName: "bg")?.removeFromParent()
                    }
                    let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                    modeSelectView.run(SKAction.sequence([scaleAction, removeAction]))
                    return
                }
                
                guard let level = GameMode(rawValue: name) else {
                    return
                }
                
                gameConfig.gameLevel = level
                
                let removeAction = SKAction.run {
                    modeSelectView.removeFromParent()
                    self.childNode(withName: "bg")?.removeFromParent()
                }
                let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                modeSelectView.run(SKAction.sequence([scaleAction, removeAction]))
                
                resetmodeView()
            }
            
            if atPoint(touchLocaion).name == "closeSetting" {
                guard let name = atPoint(touchLocaion).name else {
                    return
                }
                guard let settingView = childNode(withName: "settingView") else {
                    return
                }
                
                if name == "closeSetting" {
                    let removeAction = SKAction.run {
                        settingView.removeFromParent()
                        self.childNode(withName: "bg")?.removeFromParent()
                    }
                    let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                    settingView.run(SKAction.sequence([scaleAction, removeAction]))
                    return
                }
            }
            
            if atPoint(touchLocaion).name == "music" || atPoint(touchLocaion).name == "sound" || atPoint(touchLocaion).name == "aboutUs" {
                guard let name = atPoint(touchLocaion).name else {
                    return
                }
                guard let settingView = childNode(withName: "settingView") else {
                    return
                }
                
                if name == "music" {
                    gameConfig.isGameMusic = !gameConfig.isGameMusic
                    let node = settingView.childNode(withName: "music") as! SKSpriteNode
                    if gameConfig.isGameMusic {
                        node.texture = SKTexture(image: #imageLiteral(resourceName: "on"))
                    }else {
                        node.texture = SKTexture(image: #imageLiteral(resourceName: "off"))
                    }
                }
                if name == "sound" {
                    gameConfig.isGameSound = !gameConfig.isGameSound
                    let node = settingView.childNode(withName: "sound") as! SKSpriteNode
                    if gameConfig.isGameSound {
                        node.texture = SKTexture(image: #imageLiteral(resourceName: "on"))
                    }else {
                        node.texture = SKTexture(image: #imageLiteral(resourceName: "off"))
                    }
                }
                
                if name == "aboutUs" {
                    let webview = WebViewController()
                    webview.urlStr = "http://static.nichanglai.com/index.html"
                    
                    self.view?.window?.rootViewController?.present(webview, animated: true, completion: nil)
                }
            }
        }
    }
    
    func resetmodeView() {
        let levelStr = gameConfig.gameLevel.rawValue
        guard let image = UIImage(named: "难度\(levelStr)") else {
            return
        }
        modeSprite.texture = SKTexture(image: image)
    }
    
    func openModeSelect() {
        let backColorSprite = SKSpriteNode(color: .black, size: frame.size)
        backColorSprite.name = "bg"
        backColorSprite.alpha = 0.7
        backColorSprite.zPosition = 9
        backColorSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let backGroud = SKSpriteNode(imageNamed: "难度选择弹窗")
        backGroud.name = "modeSelectView"
        backGroud.zPosition = 10
        backGroud.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let close = SKSpriteNode(imageNamed: "关闭")
        close.name = "closeSelect"
        close.zPosition = 11
        close.position = CGPoint(x: 180, y: 220)
        backGroud.addChild(close)
        
        let easySprite = SKSpriteNode(imageNamed: GameMode.Easy.rawValue)
        easySprite.zPosition = 11
        easySprite.name = GameMode.Easy.rawValue
        easySprite.position = CGPoint(x: 0, y: 80)
        backGroud.addChild(easySprite)
        
        let midSprite = SKSpriteNode(imageNamed: GameMode.Diff.rawValue)
        midSprite.zPosition = 11
        midSprite.name = GameMode.Diff.rawValue
        midSprite.position = CGPoint(x: 0, y: -40)
        backGroud.addChild(midSprite)
        
        let diffSprite = SKSpriteNode(imageNamed: GameMode.Hall.rawValue)
        diffSprite.zPosition = 11
        diffSprite.name = GameMode.Hall.rawValue
        diffSprite.position = CGPoint(x: 0, y: -160)
        backGroud.addChild(diffSprite)
        
        switch gameConfig.gameLevel {
        case .Easy:
            easySprite.texture = SKTexture(imageNamed: "\(GameMode.Easy.rawValue)绿")
            break
        case .Diff:
            midSprite.texture = SKTexture(imageNamed: "\(GameMode.Diff.rawValue)绿")
            break
        case .Hall:
            diffSprite.texture = SKTexture(imageNamed: "\(GameMode.Hall.rawValue)绿")
            break
        }
        
        //actions
        let action = SKAction.run {
            backGroud.setScale(0.1)
            self.addChild(backColorSprite)
            self.addChild(backGroud)
        }
        run(action)
        
        let scaleAction = SKAction.scale(to: 1, duration: 0.3)
        backGroud.run(scaleAction)
    }
    
    func openSetting() {
        let backColorSprite = SKSpriteNode(color: .black, size: frame.size)
        backColorSprite.name = "bg"
        backColorSprite.alpha = 0.7
        backColorSprite.zPosition = 9
        backColorSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let backGroud = SKSpriteNode(imageNamed: "设置弹窗")
        backGroud.name = "settingView"
        backGroud.zPosition = 10
        backGroud.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let close = SKSpriteNode(imageNamed: "关闭")
        close.name = "closeSetting"
        close.zPosition = 11
        close.position = CGPoint(x: 180, y: 220)
        backGroud.addChild(close)
        
        let musicLabel = SKLabelNode(text: "音乐")
        musicLabel.fontName = "AvenirNext-Bold"
        musicLabel.fontSize = 35
        musicLabel.fontColor = UIColor.init(red: 188/255.0, green: 66/255.0, blue: 38/255.0, alpha: 1.0)
        musicLabel.position = CGPoint(x: -90, y: 50)
        backGroud.addChild(musicLabel)
        
        let soundLabel = SKLabelNode(text: "音效")
        soundLabel.fontName = "AvenirNext-Bold"
        soundLabel.fontSize = 35
        soundLabel.fontColor = UIColor.init(red: 188/255.0, green: 66/255.0, blue: 38/255.0, alpha: 1.0)
        soundLabel.position = CGPoint(x: -90, y: -40)
        backGroud.addChild(soundLabel)
        
        let musicSprite = SKSpriteNode(imageNamed: "on")
        musicSprite.name = "music"
        musicSprite.position = CGPoint(x: 30, y: 50)
        backGroud.addChild(musicSprite)
        if gameConfig.isGameMusic {
            musicSprite.texture = SKTexture(image: #imageLiteral(resourceName: "on"))
        }else {
            musicSprite.texture = SKTexture(image: #imageLiteral(resourceName: "off"))
        }
        
        let soundSprite = SKSpriteNode(imageNamed: "on")
        soundSprite.name = "sound"
        soundSprite.position = CGPoint(x: 30, y: -40)
        backGroud.addChild(soundSprite)
        if gameConfig.isGameSound {
            soundSprite.texture = SKTexture(image: #imageLiteral(resourceName: "on"))
        }else {
            soundSprite.texture = SKTexture(image: #imageLiteral(resourceName: "off"))
        }
        
        let aboutUs = SKSpriteNode(imageNamed: "关于我们")
        aboutUs.name = "aboutUs"
        aboutUs.position = CGPoint(x: 0, y: -180)
        backGroud.addChild(aboutUs)
        
        //actions
        let action = SKAction.run {
            backGroud.setScale(0.1)
            self.addChild(backColorSprite)
            self.addChild(backGroud)
        }
        run(action)
        
        let scaleAction = SKAction.scale(to: 1, duration: 0.3)
        backGroud.run(scaleAction)
    }
}
