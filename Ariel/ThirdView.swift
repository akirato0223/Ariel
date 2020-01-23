//
//  ThirdView.swift
//  Ariel
//
//  Created by あきら on 1/17/20.
//  Copyright © 2020 Akira. All rights reserved.
//

import SwiftUI


struct bTopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            Spacer()
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 35))
            Spacer()
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 30))
        }
            .padding()
    }
}
struct bBottomBarManu: View {

//    @State private var showAlert = false
    @State private var showingSecondVC = false
    var body: some View
    {
        HStack (alignment: .center){

Spacer()
            Button(action: {
//                self.showAlert = true
                self.showingSecondVC.toggle()
            }) {
                Text("Text him and apologize?😭😭😭")
                    .font(.system(size: 30, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(20)

            }
                .padding(.horizontal, 20)
            Spacer()
        }
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("Warning"), message: Text("This person is human and you are not allowed to get close to humans"), primaryButton: .default(Text("I don't care because I love him!"), action: {
//
//
//
//                        }), secondaryButton: .cancel(Text("I am sorry"))
//                )
//        }
        .sheet(isPresented: $showingSecondVC) {
            SecondView()
        }
    }
}

struct ThirdView: View {
    @GestureState private var dragState = DragState.inactive
    private let dragThreshold: CGFloat = 80.0

    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }


    }

    @State private var lastIndex = 1
    private func moveCard() {
        cardViews.removeFirst()

        self.lastIndex += 1
        let character = characters2[lastIndex % characters2.count]

        let newCardView = CardView(image: character.image, name: character.name)

        cardViews.append(newCardView)
    }
    @State var cardViews: [CardView] = {
        var views = [CardView]()

        for index in 0..<2 {
            views.append(CardView(image: characters2[index].image, name: characters2[index].name))

        }
        return views
    }()

    private func isTopCard(cardView: CardView) -> Bool {

        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id
        }) else {
            return false
        }
        return index == 0
    }


    var body: some View {

        VStack {
            Spacer()
            TopBarMenu()
            Spacer()

            ZStack {
                ForEach(cardViews) {
                    cardView in cardView.zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                Image(systemName: "x.circle")
                                    .foregroundColor(.black)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width < -self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)

                                Image(systemName: "heart.circle")
                                    .foregroundColor(.red)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width > self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)

                            })
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.95 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width / 10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100))
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break

                                    }

                                })
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragThreshold || drag.translation.width > self.dragThreshold {
                                        self.moveCard()
                                    }
                                })
                        )
                }
            }


            Spacer(minLength: 10)

            bBottomBarManu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            Spacer()


        }.frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.all)

    }

}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}

extension AnyTransition {
    static var btrailingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    static var bleadingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: AnyTransition.move(edge: .bottom)))
    }
}




