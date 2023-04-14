import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var cube = SKShapeNode(rectOf: CGSize(width: 32, height: 32))
    private var moveLeft = false
    private var moveRight = false
    private var leftButton = SKShapeNode(rectOf: CGSize(width: 60, height: 60))
    private var rightButton = SKShapeNode(rectOf: CGSize(width: 60, height: 60))
    private var cameraNode = SKCameraNode()
    private var ground = SKNode()
    private var ceiling = SKNode()

    
    override func didMove(to view: SKView) {
        // build the scene
        //backgroundColor = .cyan
        let backgroundTexture = SKTexture(imageNamed: "bgimage")
        let background = SKSpriteNode(texture: backgroundTexture, size: self.frame.size)
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = -1 // set background behind all other nodes
        addChild(background)
        
        // draw the player texture
        cube.position = CGPoint(x: frame.midX, y: frame.midY)
        cube.fillColor = UIColor.white
        cube.strokeColor = UIColor.red
        cube.lineWidth = 5
        addChild(cube)
        
        // set up physics world
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        // ground
        let groundSprite = SKSpriteNode(color: .gray, size: CGSize(width: size.width, height: 30))
        ground.position = CGPoint(x: frame.midX, y: -250)
        ground.addChild(groundSprite)
        ground.physicsBody = SKPhysicsBody(rectangleOf: groundSprite.size)
        ground.physicsBody?.isDynamic = false
        addChild(ground)
        
        // ceiling
        let ceilingSprite = SKSpriteNode(color: .gray, size: CGSize(width: size.width, height: 30))
        ceiling.position = CGPoint(x: frame.midX, y: 250)
        ceiling.addChild(ceilingSprite)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceilingSprite.size)
        ceiling.physicsBody?.isDynamic = false
        addChild(ceiling)
        
        // leftButton for moving left
        leftButton.fillColor = .gray
        addChild(leftButton)
        
        // rightButton for moving right
        rightButton.fillColor = .gray
        addChild(rightButton)
        
        /*// move cube automatically to right
        let moveRight2 = SKAction.moveBy(x: 1, y: 0, duration: 0.01)
        let moveForever = SKAction.repeatForever(moveRight2)
        cube.run(moveForever)*/
        
        // camera node
        addChild(cameraNode)
        camera = cameraNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        if leftButton.contains(touchLocation) {
            moveLeft = true
            moveRight = false
        } else if rightButton.contains(touchLocation) {
            moveLeft = false
            moveRight = true
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveLeft = false
        moveRight = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if moveLeft {
                   cube.position.x -= 2
               } else if moveRight {
                   cube.position.x += 2
               }

        
        // move camera to follow the cube
        let cameraPositionInScene = cameraNode.parent?.convert(cube.position, from: self) ?? cube.position
        cameraNode.position.x = cameraPositionInScene.x
        ground.position.x = cameraNode.position.x
        ceiling.position.x = cameraNode.position.x
        
        // update the positions of the buttons based on the camera's position
        let buttonOffset: CGFloat = 100
        leftButton.position.x = cameraNode.position.x - buttonOffset
        leftButton.position.y = cameraNode.position.y - buttonOffset

        rightButton.position.x = cameraNode.position.x + buttonOffset
        rightButton.position.y = cameraNode.position.y - buttonOffset
    }
}
