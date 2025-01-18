//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI

struct MatchingView: View {
  // MARK: - PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
  @State private var isAnimating: Bool = false
    @State private var navigateToFeedback: Bool = false
    @State private var navigateToOnboard: Bool = false
  // MARK: - BODY
  
  var body: some View {
    VStack(spacing: 20) {
      // MARK: - HEADER
      
      Spacer()
      
      VStack {
          Text("매칭 성공")
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(Color("ColorBlue"))
            .transition(.opacity)
          
        Image("character-2")
          .resizable()
          .scaledToFit()
          .padding()
          .offset(y: isAnimating ? 15 : -15)
          .animation(
            Animation
              .easeInOut(duration: 2)
              .repeatForever()
            , value: isAnimating
          )
          .frame(width: 300, height: 300)
      }
      
      // MARK: - CENTER
      
      Text("The time that leads to mastery is dependent on the intensity of our focus.")
        .font(.title)
        .fontWeight(.light)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding()
      
      // MARK: - FOOTER
        HStack {  // spacing을 추가하여 버튼 사이 간격 조정
            Button(action: {
                navigateToFeedback = true
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("다시 매칭")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .frame(maxWidth: .infinity)
            .navigationBarBackButtonHidden(true)// 버튼 너비를 최대로 설정
            .background(
                NavigationLink(destination: FeedbackView(), isActive: $navigateToFeedback) {
                    EmptyView()
                }
            )
            
            Button(action: {
                navigateToOnboard = true
                isOnboardingViewActive = true
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("매칭 종료")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .frame(maxWidth: .infinity)  // 버튼 너비를 최대로 설정
            .tint(.red)
            .navigationBarBackButtonHidden(true)// 버튼 색상을 빨간색으로 설정
            .background(
                NavigationLink(destination: OnboardingView(), isActive: $navigateToOnboard) {
                    EmptyView()
                }
            )
            .navigationBarBackButtonHidden(true)
        }
        .padding()
        .navigationBarBackButtonHidden(true)// HStack에 패딩 추가


      Spacer()
        
    } //: VSTACK
    .onAppear(perform: {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
        isAnimating = true
      })
    })
  }
}

// MARK: - PREVIEW
struct Matching_Previews: PreviewProvider {
  static var previews: some View {
    MatchingView()
  }
}
