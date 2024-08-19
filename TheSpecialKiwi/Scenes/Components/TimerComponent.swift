//
//  TimerComponent.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 19/08/24.
//

import SwiftUI

struct TimerComponent: View {
    @ObservedObject var timerHelper: TimerHelper

    var body: some View {
        VStack(alignment: .center){
            GeometryReader{ geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 12)
                    
                    Rectangle()
                        .fill(Color.brown.opacity(1.0))
                        .frame(width: abs(geometry.size.width * timerHelper.progress), height: 12)
                        .animation(.linear(duration: 1), value: timerHelper.progress)
                }
            }
        }
        .frame(width: 844,height: 12)
        //.padding(.top, -186)
        .offset(x: -12)
//        .onAppear {
//            timerHelper.startTimer()
//        }
    }
}

#Preview {
    TimerComponent(timerHelper: TimerHelper(totalTime: 10))
}
