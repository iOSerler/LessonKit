//
//  AutoRotateVideoPlayerView.swift
//  ReusEd
//
//  Created by Anna Dluzhinskaya on 16.06.2022.
//

import SwiftUI
import AVKit

public struct AutoRotateVideoPlayerView: View {
    @State private var showFullScreen: Bool
    @Binding var player: AVPlayer
    
    public init(player: Binding<AVPlayer>){
        self.showFullScreen = false
        self._player = player
    }
    
    public var body: some View {
        playerView
            .ignoresSafeArea()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                DispatchQueue.main.async {
                    if UIDevice.current.orientation.isLandscape {
                        self.showFullScreen = true
                    } else {
                        self.showFullScreen = false
                    }
                }
            }
    }
    
    private var playerView: some View {
        showFullScreen ?
        AVPlayerControllerRepresentable(showFullScreen: true, player: player) :
        AVPlayerControllerRepresentable(showFullScreen: false, player: player)
    }
}

struct AVPlayerControllerRepresentable: UIViewControllerRepresentable {
    let showFullScreen: Bool
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller  = AVPlayerViewControllerRotatable()
        controller.player = player
        chooseScreenType(controller)
        return controller
    }
    
    func updateUIViewController(_ controller: AVPlayerViewController, context content: Context) {
        chooseScreenType(controller)
    }
    
    private func chooseScreenType(_ controller: AVPlayerViewController) {
        showFullScreen ? controller.enterFullScreen(animated: true) : controller.exitFullScreen(animated: true)
        
    }
    
}

class AVPlayerViewControllerRotatable: AVPlayerViewController {
    
    override var shouldAutorotate: Bool {
        return true
    }
    
}

extension AVPlayerViewController {
    func enterFullScreen(animated: Bool) {
        perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
    
    func exitFullScreen(animated: Bool) {
        perform(NSSelectorFromString("exitFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
}
