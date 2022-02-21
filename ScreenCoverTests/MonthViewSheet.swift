//
//  MonthViewSheet.swift
//  ScreenCoverTests
//
//  Created by David Malicke on 2/20/22.
//

import SwiftUI

struct MonthViewSheet<Content: View>: View {
    
    let content: () -> Content
    var monthMode: Binding<MonthMode>
    
    init(monthMode: Binding<MonthMode>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.monthMode = monthMode
    }
    
    private func calculateOffset() -> CGFloat {
        switch monthMode.wrappedValue {
        case .bottom:
            return UIScreen.main.bounds.height - 50
        case .top:
            return UIScreen.main.bounds.height / 10
        }
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.spring(), value: monthMode.wrappedValue)
            .edgesIgnoringSafeArea(.all)
    }
}

enum MonthMode {
    case bottom
    case top
}


struct MonthViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        MonthViewSheet(monthMode: .constant(.bottom)) {
            VStack {
                Text("Hello World")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        }
    }
}


