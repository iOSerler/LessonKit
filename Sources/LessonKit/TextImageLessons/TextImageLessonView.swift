//
//  TextImageLessonView.swift
//  ReusEd
//
//  Created by Ahror Jabborov on 6/16/22.
//

import SwiftUI

public struct TextImageLessonView: View {
    var settings: TextLessonAssets
    var textLesson: Lesson
    @ObservedObject var lessonViewModel: LessonViewModel
    @State private var scrollViewHeight: CGFloat
    @State private var proportion: CGFloat
    
    public init (settings: TextLessonAssets, jsonName: String, lessonViewModel: LessonViewModel){
        self.settings = settings
        self.textLesson = LessonData(name: jsonName).lesson!
        self.lessonViewModel = lessonViewModel
        self._scrollViewHeight = State(initialValue: 0)
        self._proportion = State(initialValue: 0)
        
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text(textLesson.description!)
                    .font(.custom(settings.descriptionFont, size: 14))
                    .foregroundColor(Color(settings.descriptionTextColor))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                HStack {
                    Image(settings.durationOffIcon)
                    
                    Text(textLesson.duration!)
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.detailsTextColor))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.leading, 20)
                
                VStack {
                    ForEach(textLesson.sections!) { section in
                        TextImageLessonSectionView(settings: settings, section: section)
                    }
                }.navigationTitle(textLesson.title)
                 .navigationBarTitleDisplayMode(.inline)
                 .padding(.horizontal, 20)
                    
            }
            .background(
                GeometryReader { geo in
                    let scrollLength = geo.size.height - scrollViewHeight
                    let rawProportion = -geo.frame(in: .named("scroll")).minY / scrollLength
                    let proportion = min(max(rawProportion, 0), 1)
                    
                    Color.clear
                        .preference(
                            key: ScrollProportion.self,
                            value: proportion
                        )
                        .onPreferenceChange(ScrollProportion.self) { proportion in
                            self.proportion = proportion
                            
                        }
                }
            )
            
        }
        .onWillDisappear {
            lessonViewModel.saveLessonProgress(userId: 1, lessonId: self.textLesson.id, progress: self.proportion)
        }
        .background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    scrollViewHeight = geo.size.height
                }
            }
        )
        .coordinateSpace(name: "scroll")
    }
}

struct ScrollProportion: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
