//
//  Instructions.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-03-01.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Instructions : SKScene
{
    var backButton = SKSpriteNode()
    var backLabel : SKLabelNode?
    
    override func didMove(to view: SKView)
    {
        backButton = self.childNode(withName: "//backButton") as! SKSpriteNode
        
        backLabel = self.childNode(withName: "//backText") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let positionInScene = touches.first?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if(touchedNode.name == backButton.name || touchedNode.name == backLabel?.name)
        {
            backButton.color = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let positionInScene = touches.first?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if(touchedNode.name == backButton.name || touchedNode.name == backLabel?.name)
        {
            backButton.color = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
            if let view = self.view {
                // Load the SKScene from 'MainMenu.sks'
                if let scene = SKScene(fileNamed: "MainMenu") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1))
                }
            }
        }
    }
}
