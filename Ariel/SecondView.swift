//
//  SecondView.swift
//  Ariel
//
//  Created by あきら on 1/17/20.
//  Copyright © 2020 Akira. All rights reserved.
//

import SwiftUI


struct aBottomBarManu: View {
    @Environment(\.presentationMode) var presentaionMode: Binding<PresentationMode>
    @State private var showingThirdVC = false
   

    var body: some View
    {

        VStack(alignment: .center) {
            Spacer()
            Text("He is human. \nAre you sure you want to break the rule?")
                .font(.system(size: 30, design: .rounded))
                .bold()
                .padding(.horizontal, 20)
                .padding(.vertical, 50)
                .foregroundColor(.red)



            Spacer()

            Button(action: {
              self.showingThirdVC.toggle()
            }) {
                Text("I don't care!\nbecause I love him!!")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 25)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.black, Color.yellow]), startPoint: .leading, endPoint: .trailing))

                    .cornerRadius(30)

            }.sheet(isPresented: $showingThirdVC){
                  ThirdView()
            }



                .padding(.vertical, CGFloat(30))
            Button(action: {
                self.presentaionMode.wrappedValue.dismiss()

            }) {
                Text("I am Sorry, \nI am not going to try to find him anymore.")
                    .font(.system(size: 30, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.red)
                    .cornerRadius(30)


            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()


        }.frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.all)


    }



}



struct SecondView: View {
    var body: some View {

        aBottomBarManu()
    }


}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()

    }
}





