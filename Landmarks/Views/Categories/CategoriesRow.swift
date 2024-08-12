//
//  CategoriesRow.swift
//  Landmarks
//
//  Created by Joao Mauricio on 15/04/2022.
//

import SwiftUI

struct CategoriesRow: View {
    
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(items){ landmark in
                        NavigationLink(destination: {LandmarkDetail(landmark: landmark)},
                                       label: {CategoryItem(landmark: landmark)})
                        
                    }
                }
            }.frame(height: 185)
        }
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}

struct CategoriesRow_Previews: PreviewProvider {
    static var previews: some View {
        let landmarks = ModelData().landmarks
        CategoriesRow(categoryName: "Rivers", items: [landmarks[0], landmarks[6], landmarks[10], landmarks[1]])
    }
}
