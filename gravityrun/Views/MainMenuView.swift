import SpriteKit
import SwiftUI

struct MainMenuView: View {
    @State private var isPlaying = false

    var body: some View {
        ZStack {
            Color.init(red: 209/255.0, green: 179/255.0, blue: 227/255.0)

            VStack(spacing: 20) {
                Text("gravityrun.io")
                    .font(.custom("YourCustomFontName", size: 28))
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                
                StartGameButton(isPlaying: $isPlaying)
                    .animation(.easeInOut, value: isPlaying)
            }
            .padding()
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isPlaying) {
            ContentView()
        }
    }
}

struct StartGameButton: View {
    @Binding var isPlaying: Bool

    var body: some View {
        Button(action: {
            isPlaying = true
        }) {
            Text("Start Game")
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .hoverEffect(.lift)
        }
    }
}
