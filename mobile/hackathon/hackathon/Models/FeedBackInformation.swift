//
//  FeedBackInformation.swift
//  hackathon
//
//  Created by KoNangYeon on 1/18/25.
//

import Foundation

struct FeedBackInformation: Codable {
    var name: String
    var GoodFeedback: String
    var BadFeedback: String
    var HopeFeedback: String
    var major: String
    var specialty: String
    var isInterview: Bool
    var age: Int
    var Isstudent: Bool
    var introduction: String
}
