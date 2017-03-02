//
//  Ball.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-02-27.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import Accelerate

class Ball : SKSpriteNode
{
    var ballPower : Int = 20

    init(_ spriteTexture : SKTexture?)
    {
        // Set up ball values
        super.init(texture : spriteTexture, color : UIColor.clear, size : (spriteTexture?.size())!)
        
        self.name = "ball"
        self.size.width = 32
        self.size.height = 32
        
        physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        
        physicsBody?.isDynamic = true
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.pinned = false
        physicsBody?.affectedByGravity = false
        
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        
        physicsBody?.categoryBitMask = CollisionTags.Ball
        physicsBody?.contactTestBitMask = CollisionTags.Paddle | CollisionTags.Bricks | CollisionTags.Wall
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func shootBall()
    {
        // Shoot the ball up in a random direction
        physicsBody?.applyImpulse(CGVector(dx: Int(arc4random_uniform(UInt32(ballPower) + UInt32(ballPower))) - ballPower, dy: ballPower))
    }
    
    public func Update(_ currentTime: TimeInterval) {
        
    }
    
}
