//
//  ContentView.swift
//  ScreenCoverTests
//
//  Created by David Malicke on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    
    let hours = ["8:00", "9:00", "10:00", "11:00", "12:00", "1:00", "2:00", "3:00", "4:00"]
    
    @State private var monthMode: MonthMode = .bottom
    @State private var weekMode: WeekMode = .bottom
    @State private var dayMode: DayMode = .bottom
    
    
    @State private var count = 10
    
    var body: some View {
        ZStack {
            
            
            DayViewSheet(dayMode: $dayMode) {
                
                VStack {
                    Button {
                        switch dayMode {
                        case .bottom:
                            dayMode = .top
                        case .top:
                            dayMode = .bottom
                            weekMode = .bottom
                            monthMode = .bottom
                            count = count + 100 // only happens on the way down
                        }
                    } label: {
                        Text("Day")
                    }
                    List{
                        ForEach(hours, id: \.self) { hour in
                            HourView(hour: hour)
                            
                        }
                    }
                    .listStyle(.inset)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
                
            }
            
            
            WeekViewSheet(weekMode: $weekMode) {
                
                VStack {
                    Button {
                        switch weekMode {
                        case .bottom:
                            weekMode = .top
                            dayMode = .top
                        case .top:
                            weekMode = .bottom
                            monthMode = .bottom
                        }
                    } label: {
                        Text("Week")
                    }
                    Text("HI")
                    Text("HI")
                    Text("HI")
                    Text("HI")
                    Text("\(count)")
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
                            weekMode = .top
                            dayMode = .top
                        case .top:
                            monthMode = .bottom
                        }
                    } label: {
                        Text("Month")
                    }
                    Text("HI")
                    Text("HI")
                    Text("HI")
                    Text("HI")
                    Text("\(count)")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
            }
            // MAKE THE WHOLE TOP BAR CLICKABLE
            
//            .offset(y: offset.height )
//            .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    offset = gesture.translation
//                }
//                .onEnded { _ in
//                    if offset.height > UIScreen.main.bounds.height / 2 {
//                        self.monthMode = .top
//                    }
//
//                }
//            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
