//
//  MainMenu.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-03-01.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MainMenu : SKScene
{
    var playButton = SKSpriteNode()
    var instructionButton = SKSpriteNode()
    
    var playLabel : SKLabelNode?
    var instructionLabel : SKLabelNode?
    
    override func didMove(to view: SKView)
    {
        playButton = self.childNode(withName: "//playButton") as! SKSpriteNode
        instructionButton = self.childNode(withName: "//instructionButton") as! SKSpriteNode
        
        playLabel = self.childNode(withName: "//playText") as? SKLabelNode
        instructionLabel = self.childNode(withName: "//instText") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let positionInScene = touches.first?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if(touchedNode.name == playButton.name || touchedNode.name == playLabel?.name)
        {
            playButton.color = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        }
        else if(touchedNode.name == instructionButton.name || touchedNode.name == instructionLabel?.name)
        {
            instructionButton.color = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let positionInScene = touches.first?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if(touchedNode.name == playButton.name || touchedNode.name == playLabel?.name)
        {
            playButton.color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            if let view = self.view {
                // Load the SKScene from 'GameScene.sks'
                if let scene = SKScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 2))
                }
            }
        }
        else if(touchedNode.name == instructionButton.name || touchedNode.name == instructionLabel?.name)
        {
            instructionButton.color = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
            if let view = self.view {
                // Load the SKScene from 'Instructions.sks'
                if let scene = SKScene(fileNamed: "Instructions") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1))
                }
            }
        }
    }
}
