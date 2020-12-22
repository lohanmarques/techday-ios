//
//  PlayerViewController.swift
//  techday-tvOS
//
//  Created by Vanderlei Martinelli on 21/12/20.
//

import UIKit
import AVKit
import NotificationCenter

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

        videoGravity = .resizeAspectFill
        loopVideo()
    }
    
    private func loopVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }
    }
}
