//
//  ContentView.swift
//  ScreenCoverTests
//
//  Created by David Malicke on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sheetMode: SheetMode = .none
    @State private var monthMode: MonthMode = .bottom
    @State private var weekMode: WeekMode = .bottom
    
    var body: some View {
        ZStack {
            
            WeekViewSheet(weekMode: $weekMode) {
                
                VStack {
                    Button {
                        switch weekMode {
                        case .bottom:
                            weekMode = .top
                        case .top:
                            weekMode = .bottom
                        }
                    } label: {
                        Text("Week")
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.teal)
                  .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
 
            }

            
            MonthViewSheet(monthMode: $monthMode) {
                
                VStack {
                    Button {
                        switch monthMode {
                        case .bottom:
                            monthMode = .top
                        case .top:
                            monthMode = .bottom
                        }
                    } label: {
                        Text("Month")
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .background(Color.gray)
                  .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
 
            }
            


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
