//
//  Collider.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-02-27.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import Foundation

public struct CollisionTags
{
    static let Ball : UInt32 = 0x1 << 0
    static let Paddle : UInt32 = 0x1 << 1
    static let Bricks : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3
}
