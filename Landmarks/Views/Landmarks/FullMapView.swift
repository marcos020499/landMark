//
//  FullMapView.swift
//  Landmarks
//
//  Created by João Mauricio UWE ID 18030724 on 04/03/2022.
//

import SwiftUI
import MapKit

struct FullMapView: View {
    
    @State private var defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868),
        span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0)
    )
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $defaultRegion, annotationItems: modelData.landmarks) { location in
                MapAnnotation(coordinate: location.locationCoordinate) {
                    NavigationLink(
                        destination: LandmarkDetail(landmark: location),
                        label: {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                        })
                }
            }
            .ignoresSafeArea()
        }
    }
    
    
}

struct FullMapView_Previews: PreviewProvider {
    static var previews: some View {
        FullMapView()
            .environmentObject(ModelData())
    }
}
