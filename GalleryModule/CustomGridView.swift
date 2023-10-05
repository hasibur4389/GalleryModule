//
//  CustomGridView.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 4/10/23.
//

import SwiftUI

struct CustomGridView: View {
    var body: some View {
      //  ScrollView(.vertical){
         
            HList<Text>(numberOfItems: 100, itemWidth: 80) { index in
                Text("\(index)")
                    .foregroundColor(Color.red)
            }
            .frame(width: 200, height: 60)
            .border(Color.black, width: 2)
            .clipped()
        }
        
   // }
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView()
    }
}
