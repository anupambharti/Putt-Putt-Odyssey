//
//  LevelTwoScene.swift
//  Putt-Putt Odyssey
//
//  Created by Anu on 06/12/23.
//

import SpriteKit

class LevelTwoScene: SKScene {
    
    var ball: SKSpriteNode!
    var hole: SKSpriteNode!
    var obstacles: [SKSpriteNode] = []
    var collectibles: [SKSpriteNode] = []

    
    override func didMove(to view: SKView) {
        
        // Create a more complex layout
               createComplexLayout()

               // Add obstacles
               addObstacles()

               // Add collectibles or power-ups
               addCollectibles()

        
        // Setup your scene here
        isUserInteractionEnabled = true
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // Adjust gravity as needed
        backgroundColor = GameConfiguration.backgroundColor
        // Set up the physics body for the scene
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            self.physicsBody?.restitution = 0.5 // Adjust the restitution as needed
            self.physicsBody?.friction = 0.5 // Adjust the friction as needed
        createGameElements()
    }
    
    func createComplexLayout() {
        // Define the layout for Level 2, including multiple holes or targets
    }

    func addObstacles() {
        // Create and position obstacles in the scene
        let obstacle1 = SKSpriteNode(color: GameConfiguration.obstructionColor, size: CGSize(width: 100, height: 20))
            obstacle1.position = CGPoint(x: frame.midX, y: frame.midY + 100)
            obstacle1.physicsBody = SKPhysicsBody(rectangleOf: obstacle1.size)
            obstacle1.physicsBody?.isDynamic = false // Makes the obstacle static
            addChild(obstacle1)

            let obstacle2 = SKSpriteNode(color: GameConfiguration.obstructionColor, size: CGSize(width: 20, height: 100))
            obstacle2.position = CGPoint(x: frame.midX - 150, y: frame.midY)
            obstacle2.physicsBody = SKPhysicsBody(rectangleOf: obstacle2.size)
            obstacle2.physicsBody?.isDynamic = false
            addChild(obstacle2)
        
            let obstacle3 = SKSpriteNode(color:  GameConfiguration.obstructionColor, size: CGSize(width: 20, height: 100))
            obstacle3.position = CGPoint(x: frame.midX + 150, y: frame.midY)
            obstacle3.physicsBody = SKPhysicsBody(rectangleOf: obstacle3.size)
            obstacle3.physicsBody?.isDynamic = false
            addChild(obstacle3)

    }

    func addCollectibles() {
        // Create and position collectibles or power-ups
    }
    
    func createGameElements() {
        // Create and position the ball
        ball = SKSpriteNode(color: GameConfiguration.ballColor, size: CGSize(width: 30, height: 30))
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
            
            else if node.name == "levelThreeButton" {
                            startLevelThree()
                            return
                        }
        }
        
        
        func startLevelThree() {
            // Logic to start level 3
            // For example, loading a new scene for level 2
            if let levelThreeScene = LevelThreeScene(fileNamed: "LevelThreeScene") {
                levelThreeScene.scaleMode = .aspectFill
                view?.presentScene(levelThreeScene, transition: SKTransition.fade(withDuration: 1.0))
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
            winLabel.fontColor = GameConfiguration.textColor
                   winLabel.position = CGPoint(x: frame.midX, y: frame.midY)
                   addChild(winLabel)
            
            // Stop all game activity
                    self.physicsWorld.speed = 0
                    ball.physicsBody?.isDynamic = false

                    // Optionally, present a button or label to restart or exit the game
                    presentRestartOptions()
                    presentLevelTwoOptions()
        }
    }
    
    func presentRestartOptions() {
        // Create a restart button or label
        let restartLabel = SKLabelNode(fontNamed: "Chalkduster")
        restartLabel.text = "Restart"
        restartLabel.fontSize = 25
        restartLabel.fontColor = GameConfiguration.textColor2
        restartLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        restartLabel.name = "restartButton" // Set a name to identify it in touchesBegan method
        addChild(restartLabel)
    }
    
    func presentLevelTwoOptions() {
           // Create a "Level 3" button
           let levelThreeButton = SKLabelNode(fontNamed: "Chalkduster")
           levelThreeButton.text = "Level 3"
           levelThreeButton.fontSize = 25
           levelThreeButton.fontColor = GameConfiguration.textColor2
           levelThreeButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
           levelThreeButton.name = "levelThreeButton"
           addChild(levelThreeButton)
       }

}
