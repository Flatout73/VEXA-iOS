//
//  File.swift
//  
//
//  Created by Егор on 22.06.2022.
//

import SwiftUI
import SharedModels
import MapKit
import Resources

public struct PlaceUni: Identifiable {
    public let id = UUID()
    let name: String
    let coordinated: CLLocationCoordinate2D
}

public struct MapView: View {
    
    public init() {}
    
    @State
    private var showUniversityPage = false
    
    @State private var region = MKCoordinateRegion(
        
        center: CLLocationCoordinate2D(latitude: 37.808208, longitude: -122.415802),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        
    )
    
    let annotations =  [
        PlaceUni(name: "Harper College", coordinated: CLLocationCoordinate2D(latitude: 37.807920, longitude: -122.422949)),
        //        PlaceUni(name: "University of Central Florida", coordinated: CLLocationCoordinate2D(latitude: 37.804895, longitude: -122.429654)),
        //        PlaceUni(name: "Tacos", coordinated: CLLocationCoordinate2D(latitude: 37.807319, longitude: -122.421907))
    ]
    
    public var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { place in
            MapAnnotation(coordinate: place.coordinated) {
                Button(action: {
                    print("Showing university")
                    showUniversityPage.toggle()
                }) {
                    HStack {
                        Image("Harper College", bundle: .module)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .padding(10)
                    .background(Color.white)
                    .clipShape(
                        Circle()
                        //                        .stroke(VEXAColors.mainGreen, lineWidth: 4)
                    )
                    .overlay(
                        Image(systemName: "arrowtriangle.left.fill")
                            .rotationEffect(Angle(degrees: 270))
                            .foregroundColor(.white)
                            .offset(y: 10)
                        , alignment: .bottom)
                }
            }
        }
        .overlay {
            if showUniversityPage {
                MapUniversityProfileView(isPresented: $showUniversityPage)
                    .cornerRadius(30)
                    .frame(width: 300, height: 200)
            }
        }
    }
}
