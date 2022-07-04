//
//  QuizAlertView.swift
//  ReusEd
//
//  Created by Anna Dluzhinskaya on 29.06.2022.
//

import SwiftUI

public struct QuizAlertView: View {
    var settings: QuizLessonAssets
    @Binding var showAlert: Bool
    
    public init (settings: QuizLessonAssets, showAlert: Binding<Bool>){
        self.settings = settings
        self._showAlert = showAlert
    }
    
    public var body: some View {
        ZStack {
            Image(settings.quizPopup)
                .scaledToFit()
            VStack(alignment: .center, spacing: 18) {
                Image(settings.quizPopupImage)
                Text("Opps, Wait a sec!")
                    .font(.custom(settings.titleFont, size: 16))
                    .foregroundColor(Color(settings.mainTextColor))
                Group {
                    Text("You can not pass the quiz before you complete at least ")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.descriptionTextColor))
                    +
                    Text("80% of the course. ")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.primaryColor))
                    +
                    Text("Go back and learn a little more and come take quiz.")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.descriptionTextColor))
                }.multilineTextAlignment(.center)
                 .fixedSize(horizontal: false, vertical: true)
                
                Button(
                    action: {
                        showAlert.toggle()
                    }, label: {
                        Text("Go Back to Course")
                            .font(Font.custom(settings.titleFont, size: 14))
                            .frame(width: UIScreen.main.bounds.height/2.5 - 60, height: 45, alignment: .center)
                            .background(Color(settings.primaryColor))
                            .accentColor(Color(settings.buttonTextColor))
                            .cornerRadius(UIScreen.main.bounds.width/35)
                            .padding(.bottom, UIScreen.main.bounds.height/30)
                    }
                )
                
            }.padding(.horizontal, UIScreen.main.bounds.width/10)
        }.frame(width: UIScreen.main.bounds.height/2.5, height: UIScreen.main.bounds.height/2.5, alignment: .center)
    }
}
