import SwiftUI

struct StartView: View {
    @State private var playerNames: [String] = [""]
    @State private var selectedTheme: GameTheme = .all
    @State private var showLevelView = false
    @State private var showError = false

    var themeButtonColor: Color {
        switch selectedTheme {
        case .girls, .all:
            return Color(red: 1.0, green: 0.2, blue: 0.5)
        case .guys:
            return Color.blue
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 25) {
                    Spacer()

                    // Logo
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)

                    // Theme Picker
                    VStack(spacing: 10) {
                        Text("Select Theme")
                            .foregroundColor(.white)
                            .font(.headline)

                        Picker("Select Theme", selection: $selectedTheme) {
                            Text("For the Girls").tag(GameTheme.girls)
                            Text("For the Guys").tag(GameTheme.guys)
                            Text("For Us All").tag(GameTheme.all)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    // Player Name Inputs
                    VStack(spacing: 12) {
                        ForEach(playerNames.indices, id: \.self) { index in
                            TextField("Player \(index + 1)", text: $playerNames[index])
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .font(.body)
                                .shadow(radius: 2)
                        }

                        Button("Add Another Player") {
                            playerNames.append("")
                        }
                        .foregroundColor(themeButtonColor)
                        .font(.subheadline)
                    }
                    .padding(.horizontal)

                    // Start Game Button
                    Button(action: {
                        let trimmed = playerNames.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
                        if trimmed.isEmpty {
                            showError = true
                        } else {
                            playerNames = trimmed
                            showLevelView = true
                        }
                    }) {
                        Text("Start Game")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(themeButtonColor)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .padding(.horizontal)
                    }

                    Spacer()

                    NavigationLink(destination: LevelView(theme: selectedTheme, playerNames: playerNames), isActive: $showLevelView) {
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .alert("Please enter at least one player name.", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

