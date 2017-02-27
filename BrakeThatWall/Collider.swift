//
//  Collider.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-02-27.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public struct CollisionTags
{
    static let Ball : UInt32 = 0x1 << 0
    static let Paddle : UInt32 = 0x1 << 1
    static let Bricks : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3
}

class Collider : SKSpriteNode, SKPhysicsContactDelegate
{
 
    var firstBody : SKPhysicsBody? = nil
    var secondBody : SKPhysicsBody? = nil
    
    init(_ spriteTexture : SKTexture)
    {
        super.init(texture : spriteTexture, color : UIColor.clear, size : spriteTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func Update(_ currentTime: TimeInterval)
    {
        fatalError("This method must be overridden")
    }
    
    
    func SortPhysicsBodies(contact : SKPhysicsContact)
    {
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
    }
}
