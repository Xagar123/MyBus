import SwiftUI

struct GoingBackBeforePayment: View {
    @State private var showSheet = false

    var body: some View {
        // MARK: - Show Sheet Button
        Button("Show Sheet") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            SheetContent()
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.hidden)
        }
    }
}

// MARK: - Sheet Content View
struct SheetContent: View {
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Close Button
            HStack {
                Spacer()
                    .padding()
                Button(action: {
                    // Action for the close button
                }) {
                    Image(systemName: "multiply")
                        .foregroundColor(Color(hex: "#888888"))
                        .frame(width: 24, height: 24)
                }
            }
            Spacer()

            // MARK: - Image
            Image("Frame 2370")
            Spacer()

            // MARK: - Buttons
            VStack(spacing: 12) {
                Button(action: {
                    // Continue action
                }) {
                    Text("Continue")
                        .foregroundColor(Color(hex: "#111111"))
                        .fontWeight(.bold)
                        .frame(width: 328, height: 48)
                        .background(Color(hex: "#FEFEFE"))
                        .cornerRadius(8)
                }
                Button(action: {
                    // Go Back action
                }) {
                    Text("Go Back")
                        .foregroundColor(Color(hex: "#F2503F"))
                }
            }
            .padding(12)
        }
    }
}

// MARK: - Preview
//#Preview {
//    GoingBackBeforePayment()
//}
