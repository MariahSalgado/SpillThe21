import SwiftUI

struct QuestionLevel: Codable, Identifiable {
    let id = UUID()
    let level: Int
    let questions: [String]
}

struct LevelView: View {
    let theme: GameTheme
    let playerNames: [String]

    @State private var levels: [QuestionLevel] = []
    @State private var currentLevel: Int = 0
    @State private var currentPlayerIndex: Int = 0
    @State private var playerResponses: [String: String] = [:]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Level \(currentLevel + 1)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top)

                if levels.isEmpty {
                    ProgressView("Loading Questions...")
                        .foregroundColor(.white)
                        .onAppear(perform: loadQuestions)
                } else {
                    Menu {
                        ForEach(0..<playerNames.count, id: \.self) { index in
                            Button(playerNames[index]) {
                                currentPlayerIndex = index
                            }
                        }
                    } label: {
                        Text(playerNames[currentPlayerIndex])
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.1))
                            .foregroundColor(themeColor)
                            .cornerRadius(10)
                    }

                    VStack(spacing: 16) {
                        ForEach(currentQuestions, id: \.self) { question in
                            Button(action: {
                                let player = playerNames[currentPlayerIndex]
                                playerResponses[player] = question
                            }) {
                                Text(question)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(themeColor.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(themeColor, lineWidth: 2)
                                    )
                            }
                        }
                    }
                    .padding()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Player Status")
                            .font(.headline)
                            .foregroundColor(.white)
                        ForEach(playerNames, id: \.self) { name in
                            if let answer = playerResponses[name] {
                                Text("\(name) chose: \"\(answer)\"")
                                    .foregroundColor(.green)
                            } else {
                                Text("\(name) waiting...")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        if currentLevel + 1 < levels.count {
                            currentLevel += 1
                            playerResponses = [:]
                        }
                    }) {
                        Text(currentLevel + 1 < levels.count ? "Next Level" : "Game Complete")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(allPlayersAnswered ? themeColor : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    .disabled(!allPlayersAnswered)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
        }
    }

    var currentQuestions: [String] {
        if levels.indices.contains(currentLevel) {
            return levels[currentLevel].questions
        }
        return []
    }

    var allPlayersAnswered: Bool {
        playerResponses.keys.count == playerNames.count
    }

    var themeColor: Color {
        switch theme {
        case .girls, .all:
            return Color(red: 1.0, green: 0.2, blue: 0.5) // 🔥 hot pink
        case .guys:
            return .blue
        }
    }

    func loadQuestions() {
        let filename: String
        switch theme {
        case .girls: filename = "questions_for_girls"
        case .guys: filename = "questions_for_guys"
        case .all: filename = "questions_for_all"
        }

        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedLevels = try JSONDecoder().decode([QuestionLevel].self, from: data)
                self.levels = decodedLevels
                print("✅ Loaded \(decodedLevels.count) levels from \(filename).json")
            } catch {
                print("❌ Error loading questions: \(error.localizedDescription)")
            }
        }
    }
}

