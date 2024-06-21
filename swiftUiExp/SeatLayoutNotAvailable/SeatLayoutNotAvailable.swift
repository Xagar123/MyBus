import SwiftUI

struct SeatLayoutNotAvailable: View {
    var body: some View {
        // MARK: - Main Container
        VStack(alignment: .center) {
            // MARK: - Image
            Image("Frame 2393")
                .padding()
            
            // MARK: - Button
            Button("Okay") {
                // Action for button
            }
            .frame(width: 140, height: 48)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(8)
        }
        .frame(width: 300, height: 280)
        .padding(.all, 16)
        .background(Color(hex: "#222222"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "#333333"), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    SeatLayoutNotAvailable()
}
