//
//  PlayerViewController.swift
//  techday-tvOS
//
//  Created by Vanderlei Martinelli on 21/12/20.
//

import UIKit
import AVKit
#if canImport(NotificationCenter)
import NotificationCenter
#endif

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
    }
    
    private func loopVideo() {
        #if canImport(NotificationCenter)
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { _ in
                self.player?.seek(to: .zero)
                self.player?.play()
            }
        #endif
    }
}
