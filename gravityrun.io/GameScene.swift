import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var cube = SKShapeNode(rectOf: CGSize(width: 32, height: 32))
    private var moveLeft = false
    private var moveRight = false
    private var isMoving = false
    private var cameraNode = SKCameraNode()
    private var ground = SKNode()
    private var ceiling = SKNode()
    private var trailCubes: [SKShapeNode] = []
    private var obstacles: [SKNode] = []
    private let maxTrailCubes = 20
    private var lastObstacleXPosition: CGFloat = 0
    
    
    
    override func didMove(to view: SKView) {
        // set fps to 60 or 120 fps depends on device
        if UIScreen.main.maximumFramesPerSecond == 60 {
            self.view?.preferredFramesPerSecond = 60
        } else if UIScreen.main.maximumFramesPerSecond == 120 {
            self.view?.preferredFramesPerSecond = 120
        }

        // build the scene
        backgroundColor = .cyan
        
        // draw the player texture
        cube.position = CGPoint(x: frame.midX, y: frame.midY)
        cube.fillColor = UIColor.white
        cube.strokeColor = UIColor.red
        cube.lineWidth = 5
        addChild(cube)
        
        // set up physics body
        cube.physicsBody = SKPhysicsBody(rectangleOf: cube.frame.size)
        cube.physicsBody?.isDynamic = true
        cube.physicsBody?.allowsRotation = false // prevent cube from rotating
        
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
        
    
        /*// leftButton for moving left
         leftButton.fillColor = .gray
         addChild(leftButton)
         
         // rightButton for moving right
         rightButton.fillColor = .gray
         addChild(rightButton)
         
         // gravityButton for switching gravity
         gravityButton.fillColor = .red
         addChild(gravityButton)*/
        
        // move cube automatically to right
        let moveRight2 = SKAction.moveBy(x: 4, y: 0, duration: 0.01)
        let moveForever = SKAction.repeatForever(moveRight2)
        cube.run(moveForever)
        isMoving = true
        
        // camera node
        addChild(cameraNode)
        camera = cameraNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        physicsWorld.gravity.dy *= -1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveLeft = false
        moveRight = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // moving
        if moveLeft {
            cube.position.x -= 2
        } else if moveRight {
            cube.position.x += 2
        }
        
        if isMoving {
            if trailCubes.count >= maxTrailCubes {
                let oldestTrailCube = trailCubes.removeFirst()
                oldestTrailCube.removeFromParent()
            }
            
            let trailCube = SKShapeNode(rectOf: CGSize(width: 32, height: 32))
            trailCube.position = cube.position
            trailCube.fillColor = UIColor.white.withAlphaComponent(0.5)
            trailCube.strokeColor = UIColor.red.withAlphaComponent(0.5)
            trailCube.lineWidth = 5
            trailCube.alpha = 0.2
            addChild(trailCube)
            trailCubes.append(trailCube)
        }
        
        
        // move camera to follow the cube
        let cameraPositionInScene = cameraNode.parent?.convert(cube.position, from: self) ?? cube.position
        cameraNode.position.x = cameraPositionInScene.x
        ground.position.x = cameraNode.position.x
        ceiling.position.x = cameraNode.position.x
        
        if obstacles.count < 5 {
            addObstacle()
        }
        
        // remove obstacles
        removeObstacles()
    }
    
    private func addObstacle() {
        let obstacle = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 30))
        let yGrounds: CGFloat = -218
        let yCeiling: CGFloat = 218
        let isGroundObstacle = Bool.random()
        let randomValue = Bool.random() ? yGrounds : yCeiling
        let xOffset = CGFloat(Int.random(in: 100...800))

        obstacle.name = "obstacle"
        obstacle.position = CGPoint(x: lastObstacleXPosition + xOffset, y: randomValue)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = 0b0001
        obstacle.physicsBody?.contactTestBitMask = 0b0001
        addChild(obstacle)
        obstacles.append(obstacle)
        lastObstacleXPosition = obstacle.position.x

        
    }
    
    private func removeObstacles() {
        obstacles.filter { obstacle in
            let obstaclePositionInCamera = cameraNode.convert(obstacle.position, from: self)
            return obstaclePositionInCamera.x < -size.width/2
        }.forEach { obstacle in
            obstacle.removeFromParent()
        }
        obstacles.removeAll { obstacle in
            let obstaclePositionInCamera = cameraNode.convert(obstacle.position, from: self)
            return obstaclePositionInCamera.x < -size.width/2
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
            
        let bodyA = contact.bodyA
            let bodyB = contact.bodyB
                if (bodyA.node == cube && bodyB.node?.name == "obstacle") || (bodyA.node?.name == "obstacle" && bodyB.node == cube) {
                    if let window = view?.window {
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                        window.rootViewController = viewController
                    }
                }
        }
    
}
