//
//  GameScene.swift
//  Putt-Putt Odyssey
//
//  Created by Anu on 02/12/23.
//

import SpriteKit

class GameScene: SKScene {
    
    var ball: SKSpriteNode!
    var hole: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        isUserInteractionEnabled = true
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // Adjust gravity as needed
        backgroundColor = .systemIndigo // Example background color
        // Set up the physics body for the scene
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            self.physicsBody?.restitution = 0.5 // Adjust the restitution as needed
            self.physicsBody?.friction = 0.5 // Adjust the friction as needed
        createGameElements()
    }
    
    func createGameElements() {
        // Create and position the ball
        ball = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 30))
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.mass = 0.2 // Adjust as needed
        ball.physicsBody?.friction = 0.5 // Adjust as needed
        ball.physicsBody?.restitution = 0.3 // Adjust as needed
        ball.physicsBody?.allowsRotation = true

        addChild(ball)

        // Create and position the hole
        hole = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 50))
        hole.position = CGPoint(x: frame.maxX - 380, y: frame.maxY - 200)
        addChild(hole)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        for node in nodes {
            if node.name == "restartButton" {
                // Code to restart the game
                restartGame()
                return
            }
        }
        
        
        
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let dx = touchLocation.x - ball.position.x
            let dy = touchLocation.y - ball.position.y
            let impulseStrength: CGFloat = 0.9 // Adjust as needed
            
            let vector = CGVector(dx: dx, dy: dy)
            ball.physicsBody?.applyImpulse(vector)
        }
        
        func restartGame() {
            // Create a new scene or reset the current scene
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
            }
            
        }
        
    }
    
 

    override func update(_ currentTime: TimeInterval) {
        // Check if the ball has reached the hole
        checkForWin()
    }

    func checkForWin() {
        if ball.frame.intersects(hole.frame) {
            // Handle win scenario
            let winLabel = SKLabelNode(fontNamed: "Chalkduster")
                   winLabel.text = "Yayieeee you've done it!"
                   winLabel.fontSize = 30
                   winLabel.fontColor = SKColor.white
                   winLabel.position = CGPoint(x: frame.midX, y: frame.midY)
                   addChild(winLabel)
            
            // Stop all game activity
                    self.physicsWorld.speed = 0
                    ball.physicsBody?.isDynamic = false

                    // Optionally, present a button or label to restart or exit the game
                    presentRestartOptions()
        }
    }
    func presentRestartOptions() {
        // Create a restart button or label
        let restartLabel = SKLabelNode(fontNamed: "Chalkduster")
        restartLabel.text = "Restart"
        restartLabel.fontSize = 25
        restartLabel.fontColor = SKColor.blue
        restartLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        restartLabel.name = "restartButton" // Set a name to identify it in touchesBegan method
        addChild(restartLabel)
    }

}
