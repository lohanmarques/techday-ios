//
//  FullscreenViewController.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit
import AVKit

final class FullScreenViewController: AVPlayerViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return [.landscape] }
    
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
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }
    }
}
