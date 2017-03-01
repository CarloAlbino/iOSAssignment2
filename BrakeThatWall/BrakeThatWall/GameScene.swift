//
//  GameScene.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-02-26.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import SpriteKit
import GameplayKit
import Accelerate

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var dataManager : DataManager = DataManager()
    
    var playerPaddle = SKSpriteNode()
    var ball : Ball = Ball(SKTexture(imageNamed: "Circle"))
    
    var messageDisplay : SKLabelNode?
    var scoreDisplay : SKLabelNode?
    var livesDisplay : SKLabelNode?
    
    var canPlay = false
    var isGameOver = false
    
    // Ball control
    var isHolding = false
    var ballOnPaddle = false
    var firstTap = false
    var tapCount : Double = 0
    
    override func didMove(to view: SKView)
    {
        // Allow physics collisions
        self.physicsWorld.contactDelegate = self
        
        // Set UI
        messageDisplay = self.childNode(withName: "//message") as? SKLabelNode
        scoreDisplay = self.childNode(withName: "//scoreNum") as? SKLabelNode
        livesDisplay = self.childNode(withName: "//livesNum") as? SKLabelNode
        
        // Set player paddle
        playerPaddle = self.childNode(withName: "playerPaddle") as! SKSpriteNode
        playerPaddle.physicsBody?.categoryBitMask = CollisionTags.Paddle

        // Set screen borders
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0;
        border.restitution = 1;
        border.categoryBitMask = CollisionTags.Wall
        self.physicsBody = border
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            if(!canPlay && !isGameOver)
            {
                // Touch to start the game
                messageDisplay?.text = ""   // Clear start message
                
                // Set ball
                ball = Ball(SKTexture(imageNamed: "Circle"))
                self.addChild(ball)
                ball.position.y = playerPaddle.position.y + 50
                ball.shootBall()
                
                canPlay = true
                
                isHolding = false
                firstTap = false
                // Return the paddle back to white
                playerPaddle.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                // Move paddle to touch position
                let location = touch.location(in: self)
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                
                // Double tap the screen to hold the ball
                if(!firstTap)
                {
                    firstTap = true
                }
                else if(firstTap && tapCount < 0.22)
                {
                    isHolding = !isHolding
                    firstTap = false
                    
                    if(isHolding)
                    {
                        // Change the paddle to blue when about to catch the ball
                        playerPaddle.color = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
                    }
                    else
                    {
                        // Return the paddle back to white
                        playerPaddle.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }
                }
            }
            
            if(isGameOver)
            {
                // Touch when game over to go back to main menu
                if let view = self.view {
                    // Load the SKScene from 'MainMenu.sks'
                    if let scene = SKScene(fileNamed: "MainMenu") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene, transition: SKTransition.doorsCloseVertical(withDuration: 2))
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Move paddle to touch position
        for touch in touches
        {
            if(canPlay)
            {
                let location = touch.location(in: self)
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
                
                if(!firstTap)
                {
                    firstTap = true
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Start the double tap count
        if(firstTap)
        {
            tapCount = 0
        }
        
        // Let go of ball if holding it
        if(isHolding && ballOnPaddle)
        {
            isHolding = false
            ballOnPaddle = false
            // relese the ball
            ball.shootBall()
            // Return the paddle back to white
            playerPaddle.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        // Sort collisions
        var firstBody : SKPhysicsBody? = nil
        var secondBody : SKPhysicsBody? = nil
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Check cases
        if (((firstBody?.categoryBitMask)! & CollisionTags.Ball != 0) && ((secondBody?.categoryBitMask)! & CollisionTags.Bricks != 0)){
            // print("Ball and brick hit")
            
            // Destroy brick
            secondBody?.node?.removeFromParent()
            dataManager.AddScore(125)
        }
        
        if (((firstBody?.categoryBitMask)! & CollisionTags.Ball != 0) && ((secondBody?.categoryBitMask)! & CollisionTags.Paddle != 0)){
            // print("Ball and paddle hit")
            
            // Hold the ball
            if(isHolding)
            {
                ball.physicsBody?.velocity = CGVector.zero
                ballOnPaddle = true
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Display UI
        scoreDisplay?.text = String(dataManager.GetScore())
        livesDisplay?.text = String(dataManager.GetLives())
        
        // Tap timer
        if(firstTap)
        {
            tapCount += currentTime / 1000000
        }
        
        // Check for loss
        if(canPlay)
        {
            // Check for out of bounds
            if(ball.position.y < playerPaddle.position.y - 50)
            {
                ball.removeFromParent()
                dataManager.AddLives(-1)
                canPlay = false;
                
                messageDisplay?.text = "Touch to launch"
            }
            
            // Catch the ball
            if(ballOnPaddle)
            {
                ball.position.x = playerPaddle.position.x
            }
            
            // Check for win/loss
            if(IsWin())
            {
                isGameOver = true
                
                ball.removeFromParent()
                
                messageDisplay?.text = "FREEDOM!"
            }
            else if(dataManager.IsLoss())
            {
                isGameOver = true
                
                messageDisplay?.text = "Game Over"
            }
        }
    }
    
    func IsWin() -> Bool
    {
        // Check to see if the brick nodes are all gone, if true the game is won
        for node in self.children
        {
            if(node.name == "Bricks")
            {
                for brickNodes in node.children
                {
                    if(brickNodes.children.count > 0)
                    {
                        return false
                    }
                }
            }
        }
        return true
    }

}
