//
//  DataManager.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-02-27.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class DataManager
{
    var lives : Int = 3
    var score : Int = 0
    var highScore : Int = 0
    
    init()
    {
        // Grab the high score for comparison
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    
    public func GetLives() -> Int
    {
        return lives
    }
    
    public func GetScore() -> Int
    {
        return score
    }
    
    public func AddLives(_ inc : Int)
    {
        lives += inc
        
        if(lives < 0)
        {
            lives = 0
        }
    }
    
    public func AddScore(_ inc : Int)
    {
        score += inc
        
        if(score < 0)
        {
            score = 0
        }
        
        // Set and save high score
        if(score > highScore)
        {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScore")
            UserDefaults.standard.synchronize()
        }
    }
    
    public func IsLoss() -> Bool
    {
        if(lives <= 0)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
}
