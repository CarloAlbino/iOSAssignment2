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

class Ball : Collider
{
    var ballPower : Int = 20
    
    override init(_ spriteTexture : SKTexture)
    {
        super.init(spriteTexture)
        
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
    
    func shootBall()
    {
        physicsBody?.applyImpulse(CGVector(dx: -ballPower, dy: -ballPower))
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {

        SortPhysicsBodies(contact: contact)
        
        if (((firstBody?.categoryBitMask)! & CollisionTags.Ball != 0) &&
            ((secondBody?.categoryBitMask)! & CollisionTags.Bricks != 0)){
            secondBody?.node?.removeFromParent()
            //print("Ball and brick hit")
        }
        
        if (((firstBody?.categoryBitMask)! & CollisionTags.Bricks != 0) &&
            ((secondBody?.categoryBitMask)! & CollisionTags.Ball != 0)) {
            //print("Brick and ball hit")
        }
        
        if (((firstBody?.categoryBitMask)! & CollisionTags.Ball != 0) &&
            ((secondBody?.categoryBitMask)! & CollisionTags.Paddle != 0)) {
            //print("Ball and paddle hit")
        }
        
        if (((firstBody?.categoryBitMask)! & CollisionTags.Paddle != 0) &&
            ((secondBody?.categoryBitMask)! & CollisionTags.Ball != 0)) {
            //print("Paddle and ball hit")
        }
    }
    
    
    
}
