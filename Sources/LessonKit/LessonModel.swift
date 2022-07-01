//
//  File.swift
//  
//
//  Created by Anna Dluzhinskaya on 01.07.2022.
//

import Foundation

public struct Lesson: Identifiable, Decodable {
    public var id: Int
    public var type: String
    public var title: String
    public var description: String?
    public var duration: String?
    public var quizData: QuizData?
    public var background: String?
    public var sections: [TextLessonSection]?
    public var url: String?
    public var stamps: [VideoLessonStamp]?
}

public struct TextLessonData: Identifiable, Decodable {
    public var id: Int
    public var text: String
    public var image: String
}
public struct TextLessonSection: Identifiable, Decodable {
    public var id: Int
    public var title: String
    public var data: [TextLessonData]
}

public struct VideoLessonStamp: Decodable {
    public var seconds: Double
    public var textTime: String
    public var textDescription: String
}

public struct QuizData: Identifiable, Decodable {
    public var id: Int
    public var title: String
    public var description: String
    public var quizQuestions: [QuizQuestion]
}

public struct QuizQuestion: Identifiable, Decodable {
    public var id: Int
    public var type: String
    public var points: Int
    public var questionContent: QuizQuestionContent
}


public struct QuizQuestionContent: Decodable {
    public var topic: String
    public var question: String
    public var answers: [String]?
    public var correctAnswer: [String]
}
