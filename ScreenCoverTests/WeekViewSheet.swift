//
//  WeekViewSheet.swift
//  ScreenCoverTests
//
//  Created by David Malicke on 2/20/22.
//

import SwiftUI

struct WeekViewSheet<Content: View>: View {
   
    let content: () -> Content
    var weekMode: Binding<WeekMode>
    
    init(weekMode: Binding<WeekMode>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.weekMode = weekMode
    }
    
    private func calculateOffset() -> CGFloat {
        switch weekMode.wrappedValue {
        case .bottom:
            return UIScreen.main.bounds.height - 100
        case .top:
            return UIScreen.main.bounds.height / 10
        }
    }
    
    var body: some View {
        content()
        .offset(y: calculateOffset())
        .animation(.spring(), value: weekMode.wrappedValue)
        .edgesIgnoringSafeArea(.all)
}
}


enum WeekMode {
    case bottom
    case top
}

struct WeekViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        WeekViewSheet(weekMode: .constant(.bottom)) {
            VStack {
                Text("Hello World")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        }
    }
}


