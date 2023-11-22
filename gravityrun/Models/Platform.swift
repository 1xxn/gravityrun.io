import SpriteKit

class Platform: SKSpriteNode {
    static let platformWidth: CGFloat = 500 // Width of a single platform segment

    init() {
        let platformSize = CGSize(width: Platform.platformWidth, height: 20)
        super.init(texture: nil, color: SKColor.darkGray, size: platformSize)
        
        // Setup physics
        self.physicsBody = SKPhysicsBody(rectangleOf: platformSize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.restitution = 0.5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
