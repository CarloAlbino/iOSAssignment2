//
//  GameScene.swift
//  BrakeThatWall
//
//  Created by Carlo Albino on 2017-02-26.
//  Copyright © 2017 Carlo Albino. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var dataManager : DataManager = DataManager()
    
    var playerPaddle = SKSpriteNode()
    var ball : Ball = Ball(SKTexture(imageNamed: "Circle"))
    
    var scoreDisplay : SKLabelNode?
    var livesDisplay : SKLabelNode?
    
    var canPlay = false
    var isGameOver = false
    
    override func didMove(to view: SKView) {
        // Allow physics collisions
        self.physicsWorld.contactDelegate = self
        
        // Set UI
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
                
                // Set ball
                ball = Ball(SKTexture(imageNamed: "Circle"))
                self.addChild(ball)
                ball.position.y = playerPaddle.position.y + 50
                ball.shootBall()
                
                canPlay = true
            }
            
            if(canPlay && !isGameOver)
            {
                // Move paddle to touch position
                let location = touch.location(in: self)
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            if(canPlay && !isGameOver)
            {
                // Move paddle to touch position
                let location = touch.location(in: self)
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
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
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Display UI
        scoreDisplay?.text = String(dataManager.GetScore())
        livesDisplay?.text = String(dataManager.GetLives())
        
        // Check for loss
        if(canPlay)
        {
            if(ball.position.y < playerPaddle.position.y - 50)
            {
                ball.removeFromParent()
                dataManager.AddLives(-1)
                canPlay = false;
                
                if(dataManager.GetLives() <= 0)
                {
                    isGameOver = true
                }
            }
        }
    }

}
