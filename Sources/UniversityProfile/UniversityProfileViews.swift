//
//  File.swift
//  
//
//  Created by Егор on 21.06.2022.
//

import SwiftUI
import SharedModels
import MapKit
import Resources

struct TopView: View {
    
    let university: UniversityModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            VStack() {
                HStack (spacing: 10) {
                    ForEach(university.photos, id: \.self) { content in
                        AsyncImage(url: content) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 175)
                    }
                    .padding(10)
                }
            }
        }
    }
    
}

struct ButtonView: View {
    
    let university: UniversityModel
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 20) {
                ForEach(0..<university.tags.count, id: \.self) { index in
                    Text(self.university.tags[index])
                }
                .padding(6)
                .background(Color(UIColor.systemGray5))
                .foregroundColor(.secondary)
                .font(.subheadline)
                .cornerRadius(5)
                .lineSpacing(10)
            }
            
            HStack(spacing: 20) {
                Group {
                    Button(action: {
                        print("Follow Button Action")
                    }) {
                        Text("Follow")
                    }
                    
                    Button(action: {
                        print("Add Video Button Action")
                    }) {
                        Text("Add Video")
                    }
                }
                .padding()
                .background(VEXAColors.mainGreen)
                .foregroundColor(.white)
                .font(.title3)
                .cornerRadius(10)
                
                
                Button(action: {
                    print("Add Video Button Action")
                }) {
                    Text("Apply")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(VEXAColors.mainGreen)
                        .border(VEXAColors.mainGreen, width: 2)
                        .font(.title3)
                        .cornerRadius(5)
                }
            }
        }

    }
    
}

struct AmbassadorsView: View {
    
    let university: UniversityModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            VStack(spacing: 5) {
                HStack(spacing: 10) {
                    ForEach(university.ambassadors, id: \.self) { ambassador in
                        Button(action: {
                            print("Process to ambassador page")
                        }) {
                            VStack(alignment: .leading) {
                                Image(ambassador, bundle: .module)
                                    .resizable()
                                    .frame(width: 85, height: 85)
                                Text(ambassador)
                                    .font(.subheadline)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .bold()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct VideosView: View {
    
    let university: UniversityModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            VStack(spacing: 5) {
                HStack(spacing: 10) {
                    ForEach(university.ambassadors, id: \.self) { video in
                        Button(action: {
                            print("Process to video")
                        }) {
                            VStack(alignment: .leading) {
                                Image(video, bundle: .module)
                                    .resizable()
                                    .frame(width: 85, height: 85)
                                HStack {
                                    Image("like", bundle: .module)
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                    Text("125")
                                        .foregroundColor(.red)
                                        .bold()
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


struct UniversitySizeView: View {
    
    let university: UniversityModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image("sizePicture", bundle: .module)
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text("Size of University")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text("\(university.studentsCount)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }
}

struct RequirementsView: View {
    
    let university: UniversityModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image("checklist", bundle: .module)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Requirements")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()
            }
            .padding()
            
            HStack() {
                Text("GPA: ")
                    .bold()
                Text("\(university.gpa)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            Divider()
            
            HStack() {
                Text("Exams: ")
                    .bold()
                Text("\(university.exams)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            Divider()
            
            HStack() {
                Text("Other: ")
                    .bold()
                Text("\(university.requirementsDescription)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }
}

struct FacilitiesView: View {
    
    let university: UniversityModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image("facilities", bundle: .module)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Facilities")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()
                Spacer()
            }
            
            Text("\(university.facilities)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }
}

struct PriceView: View {
    
    let university: UniversityModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image("facilities", bundle: .module)
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text("Price Range")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text("\(university.price)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }
}

struct ContactView: View {
    
    let university: UniversityModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image("phone", bundle: .module)
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(university.phone)
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text("\(university.address)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }
}



