//
//  HomeView.swift
//  Restart
//
//  Created by Virginia Hendras on 13/12/21.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive = false
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing:20){
                Spacer()
                
                ZStack {
                    CircleBackground(circleColor: .gray, backgroundOpacaity: 0.2)
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .offset(y: isAnimating ? 35 : -35)
                        .animation(
                            .easeOut(duration: 4)
                                .repeatForever(),
                            value: isAnimating
                        )
                        
                }
                
                Text("The time leads us to mastery is depends on the intensity of focus")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action:{
                    withAnimation() {
                        playSound(sound: "success", type: "m4a")
                        isOnboardingViewActive = true
                    }
                    
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Restart")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            }.onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    isAnimating = true
                })
            }) // :VSTACK
        } // :ZSTACK
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
