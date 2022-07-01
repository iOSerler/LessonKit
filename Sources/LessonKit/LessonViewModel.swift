//
//  File.swift
//  
//
//  Created by Anna Dluzhinskaya on 01.07.2022.
//

import Foundation

public class LessonViewModel: ObservableObject {
    
    public init() {
        
    }
    
    public func saveLessonProgress(userId: Int, lessonId: Int, progress: Double) {
        let key = "lesson_\(userId)_\(lessonId)"
        UserDefaults.standard.set(progress, forKey: key)
    }
    
    public func getLessonProgress(userId: Int, lessonId: Int) -> Double {
        let key = "lesson_\(userId)_\(lessonId)"
        let progress = UserDefaults.standard.value(forKey: key) as? Double ?? 0.0
        return progress
    }
}
