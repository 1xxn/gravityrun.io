import SpriteKit

class GameScene: SKScene {
    private var player: Player!
    private var platforms: [Platform] = []
    private let numberOfPlatforms = 3 // Number of platforms to maintain
    private var changeColorTimer: Timer?
    private var cameraNode: SKCameraNode!

    override func didMove(to view: SKView) {
        // Initial background color
        backgroundColor = SKColor(red: 209/255.0, green: 179/255.0, blue: 227/255.0, alpha: 1.0)
        
        // Set up a timer to change the background color
        changeColorTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(changeBackgroundColor), userInfo: nil, repeats: true)
        
        // Add camera to the scene
        cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)

        
        // Other initializations
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player = Player(size: self.size)
        addChild(player)
        for _ in 0..<numberOfPlatforms {
            let platform = Platform()
            platforms.append(platform)
            addChild(platform)
        }
        positionPlatforms()
        player.startMoving()
    }

    func positionPlatforms() {
        for i in 0..<platforms.count {
            platforms[i].position = CGPoint(x: CGFloat(i) * Platform.platformWidth, y: size.height / 2 - 200)
        }
    }
    
    @objc func changeBackgroundColor() {
        // Change the background color
        backgroundColor = SKColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }

    override func update(_ currentTime: TimeInterval) {
        // Update logic for the player
        player.update()
        
        // Update camera position to follow the player
        cameraNode.position.x = player.position.x
        
        updatePlatforms()
    }

    deinit {
        // Invalidate the timer when the scene is deinitialized
        changeColorTimer?.invalidate()
    }
    
    func updatePlatforms() {
            for platform in platforms {
                if platform.position.x + Platform.platformWidth < player.position.x - size.width / 2 {
                    // If a platform segment is off-screen to the left, reposition it to the right
                    platform.position.x += Platform.platformWidth * CGFloat(numberOfPlatforms)
                }
            }
        }
}
