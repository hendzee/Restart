//
//  OnboardingView.swift
//  Restart
//
//  Created by Virginia Hendras on 13/12/21.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive:Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    
    @State private var buttonOffset: CGFloat = 0.0
    
    @State private var isAnimating: Bool = false
    
    @State private var imageOffset: CGSize = .zero
    
    @State private var arrowOpacity: Double = 1
    
    @State private var title: String = "Share."
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                
                // MARK: HEADER
                
                Spacer()
                
                VStack {
                    Text(title)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(title)
                    
                    Text("""
                    It's not how much we give but how much lov we put into giving.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: CENTER
                
                ZStack{
                    CircleBackground(circleColor: .white, backgroundOpacaity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                    }
                                    
                                    withAnimation(.linear(duration: 0.5)) {
                                        arrowOpacity = 0
                                        title = "Give."
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.5)) {
                                        arrowOpacity = 1
                                        title = "Share."
                                    }

                                }
                        )
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                    
                }.overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(arrowOpacity),
                    alignment: .bottom
                    
                ) // :ZSTACK
                
                Spacer()
                
                // MARK: FOOTER
                
                ZStack {
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(x: 20)
                    
                    HStack{
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .frame(width: 80, height: 80, alignment: .center)
                        .foregroundColor(.white)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if (gesture.translation.width > 0 && buttonOffset <= buttonWidth - 20){
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeOut(duration: 1)) {
                                        playSound(sound: "chimeup", type: "mp3")
                                        if (buttonOffset > buttonWidth / 2) {
                                            buttonOffset = buttonWidth - 20
                                            isOnboardingViewActive = false
                                        } else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        
                        Spacer()
                    }
                }
                .frame(height: 80, alignment: .center)
                .padding(8)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }.onAppear(perform: {
            isAnimating = true
        }) // :ZSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
