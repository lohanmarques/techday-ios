//
//  FullscreenViewController.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit
import AVKit

final class FullScreenViewController: UIViewController {
    
    @IBOutlet weak var fullscreenImage: UIImageView!
    @IBOutlet weak var pauseAndPlayImage: UIImageView!
    
    weak var playerViewController: PlayerViewController!
    
    var videoURL: URL?
    let tapFullscreen: UITapGestureRecognizer = UITapGestureRecognizer()
    let tapPauseAndPlay: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Orientation.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFullscreenAction()
        setPauseAndPlayAction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerVC = segue.destination as? PlayerViewController {
            playerViewController = playerVC
            playerVC.videoURL = videoURL
        }
    }
    
    private func setFullscreenAction() {
        tapFullscreen.addTarget(self, action: #selector(leaveFullscreen))
        
        fullscreenImage.addGestureRecognizer(tapFullscreen)
        fullscreenImage.isUserInteractionEnabled = true
    }
    
    private func setPauseAndPlayAction() {
        tapPauseAndPlay.addTarget(self, action: #selector(pauseAndPlayVideo))
        
        pauseAndPlayImage.addGestureRecognizer(tapPauseAndPlay)
        pauseAndPlayImage.isUserInteractionEnabled = true
    }
    
    @objc func leaveFullscreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pauseAndPlayVideo() {
        if playerViewController.isPlaying {
            playerViewController.pause()
            pauseAndPlayImage.image = UIImage(named: "play-icon")
        } else {
            playerViewController.play()
            pauseAndPlayImage.image = UIImage(named: "pause-icon")
        }
    }
}
