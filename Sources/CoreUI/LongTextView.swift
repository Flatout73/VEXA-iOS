// https://stackoverflow.com/questions/59485532/swiftui-how-know-number-of-lines-in-text

import SwiftUI
import Resources

public struct LongTextView: View {

    /* Indicates whether the user want to see all the text or not. */
    @State
    private var expanded: Bool = false

    /* Indicates whether the text has been truncated in its display. */
    @State
    private var truncated: Bool = false

    private var text: String

    var lineLimit = 4

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        VStack(spacing: 4) {
            // Render the real text (which might or might not be limited)
            Text(text)
                .font(.body)
                .foregroundColor(VEXAColors.text)
                .lineLimit(expanded ? nil : lineLimit)

                .background(

                    // Render the limited text and measure its size
                    Text(text).lineLimit(lineLimit)
                        .background(GeometryReader { displayedGeometry in

                            // Create a ZStack with unbounded height to allow the inner Text as much
                            // height as it likes, but no extra width.
                            ZStack {

                                // Render the text without restrictions and measure its size
                                Text(self.text)
                                    .background(GeometryReader { fullGeometry in

                                        // And compare the two
                                        Color.clear.onAppear {
                                            self.truncated = fullGeometry.size.height > displayedGeometry.size.height
                                        }
                                    })
                            }
                            .frame(height: .greatestFiniteMagnitude)
                        })
                        .hidden() // Hide the background
            )

            if truncated {
                toggleButton
            }
        }
    }

    var toggleButton: some View {
        Button(action: {
            self.expanded.toggle()
        }) {
            Text(self.expanded ? LocalizedStringKey("hide") : LocalizedStringKey("see_more"))
                .font(.subheadline)
                .foregroundColor(VEXAColors.mainGreen)
        }
    }
}
