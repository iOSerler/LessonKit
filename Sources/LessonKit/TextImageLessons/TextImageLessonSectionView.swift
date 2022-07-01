//
//  TextImageLessonSection.swift
//  ReusEd
//
//  Created by Ahror Jabborov on 6/16/22.
//

import SwiftUI

struct TextImageLessonSectionView: View {
    var settings: TextLessonAssets
    var section: TextLessonSection
    var body: some View {
        VStack(alignment: .leading) {
            Text(section.title)
                .font(.custom(settings.titleFont, size: 16))
                .padding(.bottom, 1)
            
            ForEach(section.data) { data in
                TextImageView(settings: settings, textImage: data)
            }
        }
        .padding(.bottom, 30)
    }
}
