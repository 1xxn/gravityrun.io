//
//  Background.swift
//  gravityrun
//
//  Created by Leon Privat on 17.11.23.
//

import Foundation
import SpriteKit

class BackgroundNode: SKSpriteNode {
    init(color: SKColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
