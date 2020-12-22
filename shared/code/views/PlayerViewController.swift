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
                self.player?.play()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        loopVideo()
    }
    
    private func setUI() {
        videoGravity = .resizeAspectFill

        #if os(tvOS)
        showsPlaybackControls = false
        #endif
    }
    
    private func loopVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [weak self] _ in
            guard let player = self?.player else {
                return
            }

            player.seek(to: .zero)
            player.play()
        }
    }
}
