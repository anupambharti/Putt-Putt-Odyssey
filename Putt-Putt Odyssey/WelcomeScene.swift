//
//  WelcomeScene.swift
//  Putt-Putt Odyssey
//
//  Created by Anu on 05/12/23.
//

import Foundation

import SpriteKit

class WelcomeScene: SKScene {

    var startGameButton: SKLabelNode!

    override func didMove(to view: SKView) {
        backgroundColor = .white

        // Setup Welcome Message
        let welcomeLabel = SKLabelNode(fontNamed: "Chalkduster")
        welcomeLabel.text = "Fairway Saga"
        welcomeLabel.fontSize = 40
        welcomeLabel.fontColor = SKColor.blue
        welcomeLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(welcomeLabel)

        // Setup Start Game Button
        startGameButton = SKLabelNode(fontNamed: "Chalkduster")
        startGameButton.text = "BEGIN"
        startGameButton.fontSize = 30
        startGameButton.fontColor = SKColor.blue
        startGameButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        startGameButton.name = "startGameButton"
        addChild(startGameButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)

        for node in nodes {
            if node.name == "startGameButton" {
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    gameScene.scaleMode = .aspectFill
                    view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
                }
            }
        }
    }
}

