//
//  ContentView.swift
//  snapCTest
//
//  Created by David Malicke on 2/28/22.
//

import SwiftUI

public class UIStateModel: ObservableObject {
    @Published var activeDate: Int = 1
    @Published var screenDrag: Float = 0.0
}

struct DaySliders: View {
    
    @StateObject var UIState = UIStateModel()
    

    var body: some View {
        let spacing: CGFloat = 16
        let widthOfHiddenCards: CGFloat = -10 // UIScreen.main.bounds.width - 10
        let cardHeight: CGFloat = UIScreen.main.bounds.height

        let items = [
            Card(id: 0, name: "Hey", dates: ["8:00", "9:00", "10:00", "11:00", "12:00", "1:00", "2:00", "3:00", "4:00"]),
            Card(id: 1, name: "Ho", dates: ["8:00", "9:00", "10:00", "11:00", "12:00", "1:00", "2:00", "3:00", "4:00"]),
            Card(id: 2, name: "Lets", dates: ["8:00", "9:00", "10:00", "11:00", "12:00", "1:00", "2:00", "3:00", "4:00"]),
            Card(id: 3, name: "Go", dates: ["8:00", "9:00", "10:00", "11:00", "12:00", "1:00", "2:00", "3:00", "4:00"])
        ]

        return Canvas({
            //
            // TODO: find a way to avoid passing same arguments to Carousel and Item
            //
            Carousel(UIState: UIState, numberOfItems: CGFloat(items.count), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards)
            {
                ForEach(items, id: \.self.id) { item in
                    Item(UIState: UIState, _id: Int(item.id),
                         spacing: spacing,
                         widthOfHiddenCards: widthOfHiddenCards,
                         cardHeight: cardHeight) {
                        List {
                            ForEach(item.dates, id: \.self) { date in
                                Text(date)
                            }
                        }
                    }
                    .foregroundColor(Color.red)
                    .background(Color.black)
                  //  .cornerRadius(8)
                   // .shadow(color: Color("shadow1"), radius: 4, x: 0, y: 4)
                   // .transition(AnyTransition.slide)
                    .animation(.spring())
                }
            }
            //.environmentObject(self.UIState)
        }, UIState: UIState)
    }
}

struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
    var dates: [String]
}


struct Carousel<Items: View>: View {
    let items: Items
    let numberOfItems: CGFloat // = 8
    let spacing: CGFloat // = 16
    let widthOfHiddenCards: CGFloat // = 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat

    @GestureState var isDetectingLongPress = false

    var UIState: UIStateModel

    @inlinable public init(
UIState: UIStateModel,
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items
    ) {
        self.UIState = UIState
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2) // 279
    }

    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing

        let activeOffset = xOffsetToShift + leftPadding - (totalMovement * CGFloat(UIState.activeDate))
        let nextOffset = xOffsetToShift + leftPadding - (totalMovement * CGFloat(UIState.activeDate) + 1)

        var calcOffset = Float(activeOffset)

        if calcOffset != Float(nextOffset) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }

        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, _, _ in
            self.UIState.screenDrag = Float(currentState.translation.width)

        }.onEnded { value in
            self.UIState.screenDrag = 0

            if value.translation.width < -50 {
                self.UIState.activeDate = self.UIState.activeDate + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }

            if value.translation.width > 50 {
                self.UIState.activeDate = self.UIState.activeDate - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

struct Canvas<Content: View>: View {
    let content: Content
    var UIState: UIStateModel

    @inlinable init(@ViewBuilder _ content: () -> Content, UIState: UIStateModel) {
        self.content = content()
        self.UIState = UIState
    }

    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    @inlinable public init(
UIState: UIStateModel,
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        
        self.UIState = UIState
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2) // 279
        self.cardHeight = cardHeight
        self._id = _id
    }

    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeDate ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

struct DaySliders_Previews: PreviewProvider {
    static var previews: some View {
        DaySliders(UIState: UIStateModel())
    }
}
