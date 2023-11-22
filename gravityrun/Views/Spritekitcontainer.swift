import SwiftUI
import SpriteKit

struct SpriteKitContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.preferredFramesPerSecond = 120  // High refresh rate support
        view.showsFPS = true
        view.showsNodeCount = true
        
        // Create and configure the scene
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill

        // Present the scene
        view.presentScene(scene)

        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        // Update the view if needed
    }
}
