//
//  File.swift
//  
//
//  Created by Anna Dluzhinskaya on 01.07.2022.
//

import Foundation
import SwiftUI

public protocol VideoLessonAssets {
    var titleFont: String { get }
    var descriptionFont: String { get }
    var mainTextColor: UIColor { get }
    var descriptionTextColor: UIColor { get }
    var detailsTextColor: UIColor { get }
    var primaryColor: UIColor { get }
    var durationOnIcon: String { get }
}

public protocol TextLessonAssets {
    var titleFont: String { get }
    var descriptionFont: String { get }
    var mainTextColor: UIColor { get }
    var descriptionTextColor: UIColor { get }
    var detailsTextColor: UIColor { get }
    var primaryColor: UIColor { get }
    var timeImage: String { get }
    var durationOffIcon: String { get }
}

public protocol QuizLessonAssets {
    var titleFont: String { get }
    var descriptionFont: String { get }
    var mainTextColor: UIColor { get }
    var descriptionTextColor: UIColor { get }
    var detailsTextColor: UIColor { get }
    var primaryColor: UIColor { get }
    var primaryLighterColor: UIColor { get }
    var borderColor: UIColor { get }
    var buttonTextColor: UIColor { get }
    var pinkAccentColor: UIColor { get }
    var successMain: UIColor { get }
    var successLighter: UIColor { get }
    var errorMain: UIColor { get }
    var errorLighter: UIColor { get }
    var durationOffIcon: String { get }
    var cross: String { get }
    var asteriks: String { get }
    var asteriksCircle: String { get }
    var questionMark: String { get }
    var quizHeader: String { get }
    var quizPopup: String { get }
    var quizPopupImage: String { get }
    
}
