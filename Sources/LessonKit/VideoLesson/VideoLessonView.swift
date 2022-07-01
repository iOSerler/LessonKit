//
//  VideoLessonView.swift
//  ReusEd
//
//  Created by Anna Dluzhinskaya on 15.06.2022.
//

import SwiftUI
import AVKit

public struct VideoLessonView: View {
    var settings: VideoLessonAssets
    var videoLesson: Lesson
    @ObservedObject var lessonViewModel: LessonViewModel
    
    @State var player: AVPlayer
    
    public init(settings: VideoLessonAssets, jsonName: String, lessonViewModel: LessonViewModel) {
        self.settings = settings
        self.videoLesson = LessonData(name: jsonName).lesson!
        self.lessonViewModel = lessonViewModel
        self._player = State(initialValue: AVPlayer(url: URL(string: videoLesson.url!)!))
    }
    
    public var body: some View {
        VStack {
            
            AutoRotateVideoPlayerView(player: $player)
                .onAppear {
                    DispatchQueue.main.async {
                        
                        let progress = lessonViewModel.getLessonProgress(userId: 1, lessonId: self.videoLesson.id)
                        
                        player.seek(to: CMTime(seconds: progress * CMTimeGetSeconds(player.currentItem!.asset.duration), preferredTimescale: player.currentTime().timescale))
                    }
                }
                .onWillDisappear {
                    DispatchQueue.main.async {
                        lessonViewModel.saveLessonProgress(userId: 1, lessonId: self.videoLesson.id, progress: CMTimeGetSeconds(player.currentTime())/CMTimeGetSeconds(player.currentItem!.asset.duration))
                        
                    }
                }
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    VideoDescriptionView(settings: settings,
                                         videoLesson: videoLesson)
                    
                    VideoStampsIView(settings: settings,
                                     stamps: videoLesson.stamps!,
                                     player: $player)
                    
                    
                }.padding()
            }
            
        }
    }
}
