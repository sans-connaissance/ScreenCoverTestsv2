//
//  HourView.swift
//  ScreenCoverTests
//
//  Created by David Malicke on 2/23/22.
//

import SwiftUI

struct HourView: View {
    
    var hour: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(hour)
                .font(.largeTitle)
                .fontWeight(.ultraLight)
                .padding()
                //.fontWeight(.bold)
            Spacer()
        }
    }
}

struct HourView_Previews: PreviewProvider {
    static var previews: some View {
        HourView(hour: "8:00")
    }
}
