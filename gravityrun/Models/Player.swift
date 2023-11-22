import SpriteKit

class Player: SKShapeNode {
    
    init(size sceneSize: CGSize) {
        super.init()

        // appearance
        let cubeSize = CGSize(width: 25, height: 25)
        let cubeRect = CGRect(x: -cubeSize.width / 2, y: -cubeSize.height / 2, width: cubeSize.width, height: cubeSize.height)
        self.path = CGPath(rect: cubeRect, transform: nil)
        self.fillColor = SKColor.purple
        self.strokeColor = SKColor.clear
        // position
        self.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height / 2)
        //physics
        self.physicsBody = SKPhysicsBody(rectangleOf: cubeSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        // Rotate the cube
        self.zRotation += 0.05
    }
    
    func startMoving() {
        let moveRight = SKAction.moveBy(x: 300, y: 0, duration: 2)
        let repeatAction = SKAction.repeatForever(moveRight)
        self.run(repeatAction)
    }
}
