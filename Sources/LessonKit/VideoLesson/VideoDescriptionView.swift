//
//  VideoDescriptionView.swift
//  ReusEd
//
//  Created by Anna Dluzhinskaya on 16.06.2022.
//

import SwiftUI

public struct VideoDescriptionView: View {
    var settings: LessonAssets
    var videoLesson: Lesson
    
    public init(settings: LessonAssets, videoLesson: Lesson){
        self.settings = settings
        self.videoLesson = videoLesson
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(videoLesson.title)
                .font(Font.custom(settings.titleFont, size: 18))
                .foregroundColor(Color(settings.mainTextColor))
            
            HStack {
                Image(settings.timeImage)
                Text(videoLesson.duration!)
                    .font(Font.custom(settings.descriptionFont, size: 14))
                    .foregroundColor(Color(settings.detailsTextColor))
            }
            
            Text(videoLesson.description!)
                .font(Font.custom(settings.descriptionFont, size: 14))
                .foregroundColor(Color(settings.descriptionTextColor))
        }
    }
}
