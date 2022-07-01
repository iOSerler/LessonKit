//
//  File.swift
//  
//
//  Created by Anna Dluzhinskaya on 01.07.2022.
//

import Foundation
import SwiftUI

public protocol LessonAssets {
    var titleFont: String { get }
    var descriptionFont: String { get }
    var mainTextColor: UIColor { get }
    var descriptionTextColor: UIColor { get }
    var detailsTextColor: UIColor { get }
    var primaryColor: UIColor { get }
    var borderColor: UIColor { get }
    var timeImage: String { get }
}
