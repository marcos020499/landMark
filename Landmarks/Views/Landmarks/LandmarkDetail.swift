//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by João Mauricio UWE ID 18030724 on 02/03/2022.
//

import SwiftUI

struct LandmarkDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var landmark: Landmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where : { $0.id == landmark.id})!
    }
    
    var body: some View {
        
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)
                .ignoresSafeArea(edges: .top)
            
            CircleImage(image: landmark.image)
                .padding(.bottom, -130)
                .offset(y: -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }
                
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(landmark.name)")
                    .font(.title2)
                    .padding(.vertical)
                
                Text(landmark.description)
                
                
            }
            .padding()
        }
        .onDisappear{try! modelData.save()}
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LandmarkDetail(landmark: ModelData().landmarks[0])
                .environmentObject(ModelData())
        }
    }
}
