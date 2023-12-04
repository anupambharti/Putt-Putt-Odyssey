//
//  GameScene.swift
//  Putt-Putt Odyssey
//
//  Created by Anu on 02/12/23.
//

//import SpriteKit
//import GameplayKit
//
//class GameScene: SKScene {
//    
//    var ball: SKSpriteNode!
//    var hole: SKSpriteNode!
//    var entities = [GKEntity]()
//    var graphs = [String : GKGraph]()
//    
//    private var lastUpdateTime : TimeInterval = 0
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    
//    
//    override func didMove(to view: SKView) {
//        backgroundColor = .green
//        
//        // Create and add the ball
//        ball = SKSpriteNode(color: .white, size: CGSize(width: 30, height: 30))
//        ball.position = CGPoint(x: frame.midX, y: frame.midY)
//        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
//        ball.physicsBody?.isDynamic = true
//        ball.physicsBody?.allowsRotation = false
//        addChild(ball)
//
//        // Create and add the hole
//        hole = SKSpriteNode(color: .black, size: CGSize(width: 40, height: 40))
//        hole.position = CGPoint(x: frame.maxX - 50, y: frame.maxY - 50)
//        addChild(hole)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let touchLocation = touch.location(in: self)
//        
//        // Calculate vector for ball movement
//        let dx = touchLocation.x - ball.position.x
//        let dy = touchLocation.y - ball.position.y
//        let impulseVector = CGVector(dx: dx, dy: dy)
//
//        ball.physicsBody?.applyImpulse(impulseVector)
//    }
//    
//}



import SpriteKit

class GameScene: SKScene {
    
    var ball: SKSpriteNode!
    var hole: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        isUserInteractionEnabled = true
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // Adjust gravity as needed
        backgroundColor = .green // Example background color
        // Set up the physics body for the scene
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            self.physicsBody?.restitution = 0.5 // Adjust the restitution as needed
            self.physicsBody?.friction = 0.5 // Adjust the friction as needed
        createGameElements()
    }
    
    func createGameElements() {
        // Create and position the ball
        ball = SKSpriteNode(color: .white, size: CGSize(width: 30, height: 30))
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
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let dx = touchLocation.x - ball.position.x
            let dy = touchLocation.y - ball.position.y
            let impulseStrength: CGFloat = 0.9 // Adjust as needed
            
            let vector = CGVector(dx: dx, dy: dy)
            ball.physicsBody?.applyImpulse(vector)
        }
    }

    
 

    override func update(_ currentTime: TimeInterval) {
        // Check if the ball has reached the hole
        checkForWin()
    }

    func checkForWin() {
        if ball.frame.intersects(hole.frame) {
            // Handle win scenario
            print("You Win!")
            let winLabel = SKLabelNode(fontNamed: "Chalkduster")
                   winLabel.text = "Yayieeee you've done it!"
                   winLabel.fontSize = 30
                   winLabel.fontColor = SKColor.white
                   winLabel.position = CGPoint(x: frame.midX, y: frame.midY)
                   addChild(winLabel)
        }
    }
}
