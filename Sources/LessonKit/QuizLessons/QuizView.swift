//
//  QuizView.swift
//  ReusEd
//
//  Created by Ahror Jabborov on 6/28/22.
//

import SwiftUI

public struct QuizView<TargetView: View>: View {
    
    var settings: QuizLessonAssets
    var lesson: Lesson
    @Binding var score: Int
    @ObservedObject var lessonViewModel: LessonViewModel
    var nextView: TargetView
    var courseId: Int?
    
    public init(settings: QuizLessonAssets, jsonName: String, lessonViewModel: LessonViewModel, nextView: TargetView, numPoints: Binding<Int>){
        self.settings = settings
        self.lesson = LessonData(name: jsonName).lesson!
        self.lessonViewModel = lessonViewModel
        self.nextView = nextView
        self._score = numPoints
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 30) {
            ZStack(alignment: .center) {
                Image(settings.quizHeader)
                    .resizable()
                    .scaledToFit()
                
                Text(lesson.title)
                    .font(.custom(settings.titleFont, size: 18))
                    .foregroundColor(Color(settings.buttonTextColor))
                    .padding(.top)
            }
            
            Text(lesson.quizData!.title)
                .font(.custom(settings.titleFont, size: 20))
                .foregroundColor(Color(settings.primaryColor))
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(settings.borderColor))
                HStack {
                    HStack {
                        Spacer()
                        
                        Image(settings.questionMark)
                        Text(String(lesson.quizData!.quizQuestions.count)+" Questions")
                            .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.mainTextColor))
                        
                        Spacer()
                    }
                    
                    Divider()
                        .frame(height: UIScreen.main.bounds.height/15 - 15, alignment: .center)
                    
                    HStack {
                        Spacer()
                        
                        Image(settings.asteriksCircle)
                        Text(String(getQuizPoints())+" Points")
                            .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.mainTextColor))
                        
                        Spacer()
                    }
                }
            }.frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height/15, alignment: .center)
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("DESCRIPTION")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.descriptionTextColor))
                    
                    Text(lesson.quizData!.description)
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.mainTextColor))
                    
                    Text("QUESTIONS & TOPICS")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.descriptionTextColor))
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(lesson.quizData!.quizQuestions) { question in
                            HStack {
                                Text("\u{2022}")
                                    .foregroundColor(Color(settings.mainTextColor))
                                
                                Text(String(question.id + 1))
                                    .font(.custom(settings.descriptionFont, size: 14))
                                    .foregroundColor(Color(settings.primaryColor))
                                
                                Text(": "+question.questionContent.topic)
                                    .font(.custom(settings.descriptionFont, size: 14))
                                    .foregroundColor(Color(settings.mainTextColor))
                            }
                        }
                    }
                    
                }.padding(.horizontal)
            }
            
            NavigationLink(destination: QuizQuestionView(
                settings: settings,
                quizQuestions: lesson.quizData!.quizQuestions,
                currentQuestion: lesson.quizData!.quizQuestions[0],
                score: $score,
                lessonViewModel: lessonViewModel,
                nextView: nextView,
                courseId: courseId,
                lessonId: lesson.id
            ), label: {
                Text("Start Attempt")
                    .font(Font.custom(settings.titleFont, size: 16))
                    .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
                    .background(Color(settings.primaryColor))
                    .foregroundColor(Color(settings.buttonTextColor))
                    .cornerRadius(UIScreen.main.bounds.width/35)
                    .padding(.bottom, UIScreen.main.bounds.height/10)
            })
            
           
        }.ignoresSafeArea()
    }
    
    func getQuizPoints() -> Int {
        var count = 0
        
        if self.lesson.type == "quiz" || self.lesson.type == "finalQuiz"{
            for question in lesson.quizData!.quizQuestions {
                count += question.points
            }
            return count
        } else {
            return 0
        }
    }
}
