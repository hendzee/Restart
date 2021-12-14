//
//  CircleBackground.swift
//  Restart
//
//  Created by Virginia Hendras on 13/12/21.
//

import SwiftUI

struct CircleBackground: View {
    @State var circleColor: Color
    @State var backgroundOpacaity: Double
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(circleColor.opacity(backgroundOpacaity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(circleColor.opacity(backgroundOpacaity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
        // :ZSTACK

    }
}

struct CircleBackground_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            CircleBackground(circleColor: .white, backgroundOpacaity: 0.2)
        }
    }
}
