//
//  GameViewController.swift
//  gravityrun.io
//
//  Created by Leon on 14.04.23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            
            /*let gradientLayer = CAGradientLayer()
                   gradientLayer.frame = view.bounds
                   gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
                   gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                   gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
                   view.layer.insertSublayer(gradientLayer, at: 0)*/
        }
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
