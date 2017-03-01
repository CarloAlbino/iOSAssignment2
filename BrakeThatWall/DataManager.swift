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
