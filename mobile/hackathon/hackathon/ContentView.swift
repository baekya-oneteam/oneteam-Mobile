//
//  ContentView.swift
//  hackathon
//
//  Created by KoNangYeon on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
          if isOnboardingViewActive {
            OnboardingView()
          } else {
              InformationView()
          }
        }
    }
}

#Preview {
    ContentView()
}
