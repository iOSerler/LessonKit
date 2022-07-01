//
//  QuizQuestionView.swift
//  ReusEd
//
//  Created by Ahror Jabborov on 6/28/22.
//

import SwiftUI

struct QuizQuestionView<TargetView: View>: View {
    
    var settings: QuizLessonAssets
    var quizQuestions: [QuizQuestion]
    @State var currentQuestion: QuizQuestion
    @State var questionCounter: Int = 0
    @State var showResult: Bool = false
    @State var isFinished: Bool = false
    @State var hasSelectedAnswer: Bool = false
    @State var chosenAnswer: String = ""
    @State var score: Int = 0
    @ObservedObject var lessonViewModel: LessonViewModel
    var nextView: TargetView
    var courseId: Int?
    var lessonId: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Button {
                    // save progress
                    print("ON X \(Double(questionCounter) / Double(quizQuestions.count))")
                    
                    lessonViewModel.saveLessonProgress(userId: 1, lessonId: lessonId, progress: (Double(questionCounter) / Double(quizQuestions.count)))
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(settings.cross)
                }

                ProgressView(value: Double(self.questionCounter + 1), total: Double(quizQuestions.count))
                    .accentColor( Color(settings.primaryColor))
                    .padding(.horizontal, 20)
                HStack {
                    Image(settings.asteriks)
                    Text("\(currentQuestion.points)")
                        .font(.custom(settings.titleFont, size: 14))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color(settings.pinkAccentColor))
                .clipShape(Capsule())
            }
            
            HStack {
                Text("Question \(currentQuestion.id + 1) of \(quizQuestions.count)")
                    .font(.custom(settings.descriptionFont, size: 14))
                    .foregroundColor(Color(settings.detailsTextColor))
                    .padding(.top, 10)
                Spacer()
            }

            Text(currentQuestion.questionContent.question)
                .font(.custom(settings.titleFont, size: 16))
                .foregroundColor(Color(settings.mainTextColor))
                .padding(.top, 10)
                .multilineTextAlignment(.leading)
            
            VStack {
                SingleChoiceButtonList(
                    settings: settings,
                    answers: currentQuestion.questionContent.answers!,
                    correctAnswer: currentQuestion.questionContent.correctAnswer, chosenAnswer: $chosenAnswer,
                    showResult: showResult,
                    hasSelectedAnswer: $hasSelectedAnswer
                )
            }
            .disabled(showResult ? true : false)
            
            Spacer()
            NavigationLink(
                isActive: $isFinished,
                destination: { nextView },
                label: {
                    Button(
                        action: {
                            if hasSelectedAnswer {
                                if showResult {
                                    if self.questionCounter == quizQuestions.count - 1 {
                                        self.isFinished = true
                                        lessonViewModel.saveLessonProgress(userId: 1, lessonId: lessonId, progress: 1.0)
                                        // save progress
                                    } else {
                                        self.questionCounter += 1
                                        self.currentQuestion = quizQuestions[questionCounter]
                                        self.showResult = false
                                        self.hasSelectedAnswer = false
                                    }
                                } else {
                                    updateScore()
                                    self.showResult = true
                                }
                            }
                        }, label: {
                            Text(showResult ? (questionCounter == quizQuestions.count - 1 ? "Finish Attempt" : "Next Question") : "Check Answer")
                                .font(Font.custom(settings.titleFont, size: 16))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
                                .background(Color(settings.primaryColor))
                                .accentColor(Color(settings.buttonTextColor))
                                .cornerRadius(UIScreen.main.bounds.width/35)
                                .padding(.bottom, UIScreen.main.bounds.height/30)
                        }
                    )
                }
            )
        }
        .padding(.horizontal, 20)
        .onAppear {
            questionCounter = Int((lessonViewModel.getLessonProgress(userId: 1, lessonId: lessonId) * Double(quizQuestions.count)).rounded()) % quizQuestions.count
            print(questionCounter)
//            0.0 -> 0
//            0.33 -> 1
//            0.66 -> 2
//            1.0 -> 0
          
           
            currentQuestion = quizQuestions[questionCounter]
        }
        .navigationBarHidden(true)
    }
    
    func updateScore() {
        for answer in currentQuestion.questionContent.correctAnswer where chosenAnswer == answer {
                self.score += currentQuestion.points
        }
        print(score)
    }
}



struct SingleChoiceButtonList: View {
    var settings: QuizLessonAssets
    let answers: [String]
    let correctAnswer: [String]
    @Binding var chosenAnswer: String
    var showResult: Bool
    @Binding var hasSelectedAnswer: Bool
    
    var body: some View {
        ScrollView {
            ForEach(answers, id: \.self) { answer in
                SingleChoiceButtonRow(
                    settings: settings,
                    answer: answer,
                    tapAction: {
                        hasSelectedAnswer = true
                        self.chosenAnswer = answer
                    },
                    chosen: chosenAnswer == answer,
                    showResult: self.showResult,
                    isCorrect: self.isCorrect(answer: answer))
                
            }
            .padding(0)
        }
        .onAppear {
            hasSelectedAnswer = false
        }
    }
    
    func isCorrect(answer: String) -> Bool {
        for ans in self.correctAnswer where answer == ans {
            return true
        }
        return false
    }
}

struct SingleChoiceButtonRow: View {
    var settings: QuizLessonAssets
    let answer: String
    let tapAction: () -> Void
    let chosen: Bool
    let showResult: Bool
    let isCorrect: Bool
    
    var body: some View {
        Button(
            action: {
                tapAction()
            }, label: {
                HStack {
                    Text(answer)
                        .font(.custom(settings.titleFont, size: 16))
                        .foregroundColor(chosen ? Color(settings.primaryColor) : .black)
                        .padding(.leading, 20)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 60, height: 66, alignment: .leading)
                
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        showResult ? (isCorrect ? Color(settings.successMain) : (chosen ? Color(settings.errorMain) : Color(settings.borderColor))) :
                            (chosen ? Color(settings.primaryColor) : Color(settings.borderColor)), lineWidth: 2))
                
                .background(
                    showResult ? (isCorrect ? Color(settings.successLighter) : (chosen ? Color(settings.errorLighter) : .white)) : (chosen ? Color(settings.primaryLighterColor) : .white))
                
            }
        )
        .cornerRadius(12)
        .padding(.top, 10)
    }
}
