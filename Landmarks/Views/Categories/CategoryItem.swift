//
//  CategoryItem.swift
//  Landmarks
//
//  Created by Joao Mauricio on 15/04/2022.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark
    
    var body: some View {
        VStack(alignment: .leading){
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            
            
            Text(landmark.name)
                .font(.subheadline)
                .foregroundColor(.primary)
            
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: ModelData().landmarks[0])
    }
}
