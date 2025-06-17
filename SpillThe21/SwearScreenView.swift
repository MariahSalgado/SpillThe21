import SwiftUI

struct SwearScreenView: View {
    @State private var hasSworn = false

    var body: some View {
        Group {
            if hasSworn {
                StartView()
            } else {
                ZStack {
                    Color.black
                        .ignoresSafeArea()

                    VStack(spacing: 30) {
                        Spacer()

                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)

                        Text("Before You Begin")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        Text("This game requires honesty.\n\nSwear to answer at least 1 of the 3 questions per level — truthfully.")
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        Button(action: {
                            hasSworn = true
                        }) {
                            Text("I Swear I’ll Be Honest")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 1.0, green: 0.2, blue: 0.5)) // hot pink
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }

                        Spacer()

                        Text("“No lies. No skips. Just honesty.”")
                            .italic()
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.bottom, 40)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
