import SwiftUI

enum GameTheme: String, CaseIterable {
    case girls = "For the Girls"
    case guys = "For the Guys"
    case all = "For Us All"

    var colorScheme: Color {
        switch self {
        case .girls: return Color.pink
        case .guys: return Color.blue
        case .all: return Color.purple
        }
    }
}

struct ThemeSelectionView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Choose Your Theme")
                .font(.title)
                .bold()

            ForEach(GameTheme.allCases, id: \.self) { theme in
                NavigationLink(destination: PlayerSetupView(selectedTheme: theme)) {
                    Text(theme.rawValue)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(theme.colorScheme)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}
