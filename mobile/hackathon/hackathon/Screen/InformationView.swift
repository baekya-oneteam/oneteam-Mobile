
import SwiftUI

struct InformationView: View {
    // MARK: - PROPERTIES
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var navigateToMatching = false
    @State private var userInfo = UserInformation(
        name: "",
        introduction: "",
        age: 0,
        specialty: "",
        personalHistory: "",
        major: "",
        isInterview: false,
        isStudent: false
    )
    
    let majors = [
        "국어국문학과", "영어영문학과", "중어중문학과", "철학과", "사학과",
        "지리학과", "미디어커뮤니케이션학과", "수학과", "화학과", "물리학과",
        "건축학과", "컴퓨터공학", "전기전자공학", "화학공학과", "기계공학과",
        "정치외교학과", "경제학과", "행정학과", "통계학과", "경영학과"
    ]
    
    let specialties = [
        "기획전략", "마케팅홍보조사", "회계세무재무", "인사노무HRD", "총무법무사무",
        "IT개발데이터", "디자인", "영업판매무역", "고객상담TM", "구매자재물류",
        "상품기획MD", "운전운송배송", "서비스", "생산", "건설건축",
        "의료", "연구R&D", "교육", "미디어문화스포츠", "금융보험", "공공복지"
    ]
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "person", firstText: "이름", color: Color("ColorRed"))
                                TextField("이름을 입력하세요", text: $userInfo.name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "checkmark.seal", firstText: "한줄 소개", color: Color("ColorRed"))
                                TextField("소개를 입력하세요", text: $userInfo.introduction)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "number.circle.fill", firstText: "나이", color: Color("ColorRed"))
                                TextField("나이를 입력하세요", value: $userInfo.age, format: .number)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "pencil", firstText: "전문 분야", color: Color("ColorRed"))
                                Picker("전문 분야 선택", selection: $userInfo.specialty) {
                                    Text("전문 분야를 선택하세요").tag("")
                                    ForEach(specialties, id: \.self) { specialty in
                                        Text(specialty).tag(specialty)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "flag", firstText: "경력", color: Color("ColorRed"))
                                Picker("경력 선택", selection: $userInfo.personalHistory) {
                                    Text("경력을 선택하세요").tag("")
                                    Text("10년").tag("10년")
                                    Text("20년").tag("20년")
                                    Text("30년").tag("30년")
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )

                            }
                        }
                        
                        Group {
                            // 전공 Picker로 변경
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "doc.append.rtl", firstText: "전공", color: Color("ColorRed"))
                                Picker("전공 선택", selection: $userInfo.major) {
                                    Text("전공을 선택하세요").tag("")
                                    ForEach(majors, id: \.self) { major in
                                        Text(major).tag(major)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "face.smiling", firstText: "대면 여부", color: Color("ColorRed"))
                                Picker("대면 여부", selection: $userInfo.isInterview) {
                                    Text("대면").tag(true)
                                    Text("비대면").tag(false)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            VStack(alignment: .leading) {
                                FormRowStaticView(icon: "person.2.wave.2", firstText: "멘토 / 멘티", color: Color("ColorRed"))
                                Picker("멘토/멘티", selection: $userInfo.isStudent) {
                                    Text("멘토").tag(false)
                                    Text("멘티").tag(true)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            Button(action: {
                                saveToJSON()
                                navigateToMatching = true
                            }) {
                                Text("저장")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("ColorRed"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.top)
                            .navigationBarBackButtonHidden(true)
                            .background(
                                NavigationLink(destination: MatchingView(), isActive: $navigateToMatching) {
                                    EmptyView()
                                }
                            )

                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("자기소개", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func saveToJSON() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]  // JSON을 보기 좋게 출력
            let jsonData = try encoder.encode(userInfo)
            
            // 인코딩된 JSON 데이터를 문자열로 변환하여 출력
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("전송되는 JSON 데이터:\n\(jsonString)")
            }
            
            let url = URL(string: "http://your-server:8080/api/endpoint")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("전송 실패: \(error.localizedDescription)")
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("서버 응답 상태 코드: \(httpResponse.statusCode)")
                    }
                    
                    if let data = data,
                       let responseString = String(data: data, encoding: .utf8) {
                        print("서버 응답 데이터:\n\(responseString)")
                    }
                }
            }.resume()
        } catch {
            print("JSON 인코딩 실패: \(error.localizedDescription)")
        }
    }

}


// MARK: - PREIVEW

struct InformationView_Previews: PreviewProvider {
  static var previews: some View {
    InformationView()
  }
}
