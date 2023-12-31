//
//  GameViewController.swift
//  Putt-Putt Odyssey
//
//  Created by Anu on 02/12/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Screen is loaded")
        if let view = self.view as! SKView? {
            if let scene = WelcomeScene(fileNamed: "WelcomeScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        }

        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
//        if let scene = GKScene(fileNamed: "GameScene") {
//            
//            // Get the SKScene from the loaded GKScene
//            if let sceneNode = scene.rootNode as! GameScene? {
//                
//                // Copy gameplay related content over to the scene
////                sceneNode.entities = scene.entities
////                sceneNode.graphs = scene.graphs
//                
//                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//                
//                // Present the scene
//                if let view = self.view as! SKView? {
//                    view.presentScene(sceneNode)
//                    
//                    view.ignoresSiblingOrder = true
//                    
//                    view.showsFPS = false
//                    view.showsNodeCount = false
//                }
//            }
//        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
