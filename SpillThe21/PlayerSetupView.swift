import SwiftUI

struct PlayerSetupView: View {
    let selectedTheme: GameTheme
    @State private var numberOfPlayers: Int = 2
    @State private var playerNames: [String] = Array(repeating: "", count: 5)

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Player Names")
                .font(.title2)
                .padding(.top)

            Stepper("Players: \(numberOfPlayers)", value: $numberOfPlayers, in: 2...5)
                .padding()

            ForEach(0..<numberOfPlayers, id: \.self) { index in
                TextField("Player \(index + 1) Name", text: $playerNames[index])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }

            NavigationLink(destination: LevelView(theme: selectedTheme, playerNames: Array(playerNames.prefix(numberOfPlayers)))) {
                Text("Start Game")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedTheme.colorScheme)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}
