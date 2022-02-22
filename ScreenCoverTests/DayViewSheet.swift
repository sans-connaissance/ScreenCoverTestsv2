//
//  DayViewSheet.swift
//  ScreenCoverTests
//
//  Created by David Malicke on 2/20/22.
//

import SwiftUI

struct DayViewSheet<Content: View>: View {
    
    let content: () -> Content
    var dayMode: Binding<DayMode>
    
    init(dayMode: Binding<DayMode>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.dayMode = dayMode
    }
    
    private func calculateOffset() -> CGFloat {
        switch dayMode.wrappedValue {
        case .bottom:
            return UIScreen.main.bounds.height - 150
        case .top:
            return UIScreen.main.bounds.height / 20
        }
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.spring(), value: dayMode.wrappedValue)
            .edgesIgnoringSafeArea(.all)
    }
}

enum DayMode {
    case bottom
    case top
}

struct DayViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        DayViewSheet(dayMode: .constant(.bottom)) {
            VStack {
                Text("Hello World")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        }
    }
}
