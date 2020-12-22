//
//  PlayerViewController.swift
//  techday-tvOS
//
//  Created by Vanderlei Martinelli on 21/12/20.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
    var videoURL: URL? {
        didSet {
            guard let videoURL = self.videoURL else {
                return
            }

            DispatchQueue.main.async {
                self.player = AVPlayer(url: videoURL)
                self.play()
            }
        }
    }
    
    var isPlaying: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        loopVideo()
    }
    
    func play() {
        self.player?.play()
        self.isPlaying = true
    }
    
    func pause() {
        self.player?.pause()
        self.isPlaying = false
    }
    
    func replay() {
        self.player?.seek(to: .zero)
        self.play()
    }
    
    private func setUI() {
        videoGravity = .resizeAspectFill

        #if os(tvOS)
        showsPlaybackControls = false
        #endif
    }
    
    private func loopVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { _ in
            self.replay()
        }
    }
}
