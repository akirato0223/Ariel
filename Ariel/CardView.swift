//
//   CardView.swift
//  Ariel
//
//  Created by あきら on 1/16/20.
//  Copyright © 2020 Akira. All rights reserved.
//

import SwiftUI


struct CardView: View, Identifiable {
    let id = UUID()
    let image : String
    let name : String
    
    var body: some View{
        Image(image)
        .resizable()
        .scaledToFill()
            .frame(minWidth:0, maxWidth: 360, minHeight: 0, maxHeight: 600)
            .cornerRadius(20)
        .padding(.horizontal, 15)
        
            .overlay(
           
                VStack{
                    Text(name)
                        .font(.system(size:30, design: .rounded ))
                        .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.4))
                    .cornerRadius(20)
                }
               .padding([.bottom], 15)
                
                , alignment: .bottom
                
        )
    }

    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "Arielcharacter1", name: "Flounder")
    }
}
