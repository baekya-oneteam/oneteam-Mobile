//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI

struct OnboardingView: View {
  // MARK: - PROPERTY
  
  @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
  
  @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0
  @State private var isAnimating: Bool = false
  @State private var imageOffset: CGSize = .zero
  @State private var indicatorOpacity: Double = 1.0
  @State private var textTitle: String = "매칭 타임"
  
  let hapticFeedback = UINotificationFeedbackGenerator()
  
  // MARK: - BODY
  
  var body: some View {
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        // MARK: - HEADER
        
        Spacer()
        
        VStack(spacing: 0) {
          Text(textTitle)
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .transition(.opacity)
            .id(textTitle)
          
          Text("""
          멘토 멘티와 소중한 경험을 쌓아보세요.
          """)
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
        } //: HEADER
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -40)
        .animation(.easeOut(duration: 1), value: isAnimating)
        
        // MARK: - CENTER
        
        ZStack {
          CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
            .offset(x: imageOffset.width * -1)
            .blur(radius: abs(imageOffset.width / 5))
            .animation(.easeOut(duration: 1), value: imageOffset)
          
          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
            .offset(x: imageOffset.width * 1.2, y: 0)
            .rotationEffect(.degrees(Double(imageOffset.width / 20)))
            .animation(.easeOut(duration: 1), value: imageOffset)
        } //: CENTER
        
        Spacer()
        
        // MARK: - FOOTER
        
        ZStack {
          // PARTS OF THE CUSTOM BUTTON
          
          // 1. BACKGROUND (STATIC)
          
          Capsule()
            .fill(Color.white.opacity(0.2))
          
          Capsule()
            .fill(Color.white.opacity(0.2))
            .padding(8)
          
          // 2. CALL-TO-ACTION (STATIC)
          
          Text("시작하기")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .offset(x: 20)
          
          // 3. CAPSULE (DYNAMIC WIDTH)
          
          HStack {
            Capsule()
              .fill(Color("ColorRed"))
              .frame(width: buttonOffset + 80)
            
            Spacer()
          }
          
          // 4. CIRCLE (DRAGGABLE)
          
          HStack {
            ZStack {
              Circle()
                .fill(Color("ColorRed"))
              Circle()
                .fill(.black.opacity(0.15))
                .padding(8)
              Image(systemName: "chevron.right.2")
                .font(.system(size: 24, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                  }
                }
                .onEnded { _ in
                  withAnimation(Animation.easeOut(duration: 0.4)) {
                    if buttonOffset > buttonWidth / 2 {
                      hapticFeedback.notificationOccurred(.success)
                      buttonOffset = buttonWidth - 80
                      isOnboardingViewActive = false
                    } else {
                      hapticFeedback.notificationOccurred(.warning)
                      buttonOffset = 0
                    }
                  }
                }
            ) //: GESTURE
            
            Spacer()
          } //: HSTACK
        } //: FOOTER
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
      } //: VSTACK
    } //: ZSTACK
    .onAppear(perform: {
      isAnimating = true
    })
    .preferredColorScheme(.dark)
  }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}


