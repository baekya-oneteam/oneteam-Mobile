import SwiftUI

struct FeedbackView: View {
    // MARK: - PROPERTIES
    @State private var feedbackInfo: FeedBackInformation = FeedBackInformation(
        name: "테스트",
        GoodFeedback: "멘토님께서 친절하게 설명해주셔서 좋았습니다. 실제 현업에서의 경험을 바탕으로 조언해주셔서 매우 도움이 되었습니다.",
        BadFeedback: "시간이 너무 짧았던 것 같아요. 더 많은 이야기를 나누고 싶었는데 아쉬웠습니다.",
        HopeFeedback: "다음에는 좀 더 긴 시간으로 매칭이 되었으면 좋겠습니다. 온라인보다는 오프라인으로 만나면 좋을 것 같아요.",
        major: "컴퓨터공학",
        specialty: "IT개발",
        isInterview: true,
        age: 25,
        Isstudent: true,
        introduction: "테스트"
    )
    @State private var navigateToMatching: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "arrowshape.up", firstText: "좋았던 점", color: Color("ColorBlue"))
                                Text(feedbackInfo.GoodFeedback)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray6))
                                    )
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "arrowshape.down", firstText: "아쉬웠던 점", color: Color("ColorBlue"))
                                Text(feedbackInfo.BadFeedback)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray6))
                                    )
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "arrow.3.trianglepath", firstText: "개선점", color: Color("ColorBlue"))
                                Text(feedbackInfo.HopeFeedback)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray6))
                                    )
                            }
                        }
                    }
                    .padding()
                    
                }
            }
            .navigationBarTitle("피드백", displayMode: .inline)
                .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            navigateToMatching = true
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
                        .padding()
                        .navigationBarBackButtonHidden(true)
                        .background(
                            NavigationLink(destination: MatchingView(), isActive: $navigateToMatching) {
                                EmptyView()
                            }
                        )
                    }
                    .padding(.bottom)
                )
                .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}



// MARK: - PREIVEW

struct FeedbackView_Previews: PreviewProvider {
  static var previews: some View {
    FeedbackView()
  }
}
