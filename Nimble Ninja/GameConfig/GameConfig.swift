//
//  GameConfig.swift
//  Nimble Ninja
//
//  Created by roy on 2018/8/10.
//  Copyright © 2018年 Joydeep. All rights reserved.
//

import UIKit

enum GameMode: String {
    case Easy = "简单"
    case Diff = "困难"
    case Hall = "地狱"
}

class GameConfig: NSObject {
    static let shared = GameConfig()
    
    private var _highScore: Int = 0
    var highScore: Int {
        get {
            let level = GameConfig.shared.gameLevel
            var gameLevelStr = "Sorce"
            gameLevelStr += "_\(level.rawValue)"
            
            return UserDefaults.standard.integer(forKey: gameLevelStr)
        }
        
        set {
            _highScore = newValue
            let level = GameConfig.shared.gameLevel
            var gameLevelStr = "Sorce"
            gameLevelStr += "_\(level.rawValue)"
            
            UserDefaults.standard.set(newValue, forKey: gameLevelStr)
            UserDefaults.standard.synchronize()
        }
    }
    
    var gameLevel: GameMode = (UserDefaults.standard.string(forKey: "gameMode") != nil) ? GameMode(rawValue: UserDefaults.standard.string(forKey: "gameMode")!)! : GameMode.Easy {
        didSet {
            UserDefaults.standard.set(gameLevel.rawValue, forKey: "gameMode")
            UserDefaults.standard.synchronize()
        }
    }
    
    var isGameMusic = UserDefaults.standard.object(forKey: "isGameMusic") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isGameMusic, forKey: "isGameMusic")
            UserDefaults.standard.synchronize()
        }
    }
    var isGameSound = UserDefaults.standard.object(forKey: "isGameSound") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isGameSound, forKey: "isGameSound")
            UserDefaults.standard.synchronize()
        }
    }
    
    func getTimeByMode() -> TimeInterval {
        switch GameConfig.shared.gameLevel {
        case .Easy:
            return 1.0
        case .Diff:
            return 0.8
        case .Hall:
            return 0.6
        }
    }
    
}
