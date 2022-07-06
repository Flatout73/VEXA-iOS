//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import Resources

struct AboutView: View {
    let email: String
    let dateOfBirth: Date
    let country: String
    let nativeLanguage: String

    @State
    private var showingMore = false

    var body: some View {
        VStack (spacing: 10) {

            HStack(spacing: 10) {

                Image("aboutIMG", bundle: .module)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)

                Text("About")
                    .foregroundColor(.black)
                    .font(.title3)
                Spacer()
            }

            HStack {
                Text("Email:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text(email)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }

            Divider()

            HStack {
                Text("Date of Birth:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text(dateOfBirth, formatter: DateFormatter())
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }

            Divider()

            HStack {
                Text("Country:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text(country)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }

            Divider()

            HStack {
                Text("Native Language:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text(nativeLanguage)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }

            Divider()

            Group {
                Button(action: {
                    showingMore.toggle()
                }) {
                    Text(showingMore ? LocalizedStringKey("Hide") : LocalizedStringKey("See more"))
                        .foregroundColor(VEXAColors.mainGreen)
                        .font(.subheadline)
                }
                if showingMore {
                    textView
                }
            }
        }
        .padding()
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }

    // MARK: - Extra Text Fields for view

    var textView: some View {
        VStack {
            HStack {
                Text("Extra Text:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text("User Info")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }

            Divider()

            HStack {
                Text("Extra Text:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text("User Info")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
        }


    }
}
