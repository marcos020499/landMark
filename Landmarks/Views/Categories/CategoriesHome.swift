//
//  CategoriesHome.swift
//  Landmarks
//
//  Created by Joao Mauricio on 15/04/2022.
//

import SwiftUI

struct CategoriesHome: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        NavigationView{
            List{
                modelData.featuredLandmarks.first!.image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                    
                ForEach(modelData.categories.keys.sorted(), id: \.self) { category in
                    CategoriesRow(categoryName: category, items: modelData.categories[category]!)
                }
                .listRowInsets(EdgeInsets())
            }
                .navigationTitle("Featured")
                .listStyle(.plain)
        }
    }
}

struct CategoriesHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesHome()
            .environmentObject(ModelData())
    }
}
