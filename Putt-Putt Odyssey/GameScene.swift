//
//  GameScene.swift
//  Putt-Putt Odyssey
//
//  Created by Anu on 02/12/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball: SKSpriteNode!
    var hole: SKSpriteNode!
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .green
        
        // Create and add the ball
        ball = SKSpriteNode(color: .white, size: CGSize(width: 30, height: 30))
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.allowsRotation = false
        addChild(ball)

        // Create and add the hole
        hole = SKSpriteNode(color: .black, size: CGSize(width: 40, height: 40))
        hole.position = CGPoint(x: frame.maxX - 50, y: frame.maxY - 50)
        addChild(hole)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Calculate vector for ball movement
        let dx = touchLocation.x - ball.position.x
        let dy = touchLocation.y - ball.position.y
        let impulseVector = CGVector(dx: dx, dy: dy)

        ball.physicsBody?.applyImpulse(impulseVector)
    }
    
}

