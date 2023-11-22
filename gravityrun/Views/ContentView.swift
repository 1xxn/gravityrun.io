import SwiftUI

struct ContentView: View {
    var body: some View {
        SpriteKitContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
    }
}
