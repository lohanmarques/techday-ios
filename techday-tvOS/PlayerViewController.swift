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

        // Do any additional setup after loading the view.
    }
}
