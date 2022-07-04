//
//  File.swift
//  
//
//  Created by Anna Dluzhinskaya on 01.07.2022.
//

import Foundation

struct LessonData {
    var lesson: Lesson?
    
    init(name: String, lessonId: Int) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json")
        else {
            print(name+" json file not found")
            self.lesson = nil
            return
        }
        
        let data = try? Data(contentsOf: url)
        let pages = try? JSONDecoder().decode([Lesson].self, from: data!)
        self.lesson = pages![lessonId - 1]
    }
}
struct Lesson: Identifiable, Decodable {
    var id: Int
    var type: String
    var title: String
    var description: String?
    var duration: String?
    var quizData: QuizData?
    var background: String?
    var sections: [TextLessonSection]?
    var url: String?
    var stamps: [VideoLessonStamp]?
}

struct TextLessonData: Identifiable, Decodable {
    var id: Int
    var text: String
    var image: String
}
struct TextLessonSection: Identifiable, Decodable {
    var id: Int
    var title: String
    var data: [TextLessonData]
}

struct VideoLessonStamp: Decodable {
    var seconds: Double
    var textTime: String
    var textDescription: String
}

struct QuizData: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String
    var quizQuestions: [QuizQuestion]
}

struct QuizQuestion: Identifiable, Decodable {
    var id: Int
    var type: String
    var points: Int
    var questionContent: QuizQuestionContent
}


struct QuizQuestionContent: Decodable {
    var topic: String
    var question: String
    var answers: [String]?
    var correctAnswer: [String]
}
