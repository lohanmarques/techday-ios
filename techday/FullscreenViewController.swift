//
//  FullscreenViewController.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit
import AVKit

protocol FullscreenDelegate: class {
    func backToLiveVC(with time: CMTime?)
}

final class FullScreenViewController: UIViewController {
    
    @IBOutlet weak var fullscreenImage: UIImageView!
    @IBOutlet weak var pauseAndPlayImage: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoView: BorderView!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoContentLabel: UILabel!
    
    weak var playerViewController: PlayerViewController!
    weak var delegate: FullscreenDelegate?
    
    var videoURL: URL?
    var currentTime: CMTime?
    var selectedMatch: Match?
    let tapFullscreen: UITapGestureRecognizer = UITapGestureRecognizer()
    let tapPauseAndPlay: UITapGestureRecognizer = UITapGestureRecognizer()
    let tapInfo: UITapGestureRecognizer = UITapGestureRecognizer()
    var isShowingInfo: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Orientation.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        playerViewController.pause()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFullscreenAction()
        setPauseAndPlayAction()
        setInfoAction()
        setInfoView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerVC = segue.destination as? PlayerViewController {
            playerViewController = playerVC
            playerVC.videoURL = videoURL
            playerVC.currentTime = currentTime
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
    
    private func setInfoAction() {
        tapInfo.addTarget(self, action: #selector(displayInfo))
        
        infoImage.addGestureRecognizer(tapInfo)
        infoImage.isUserInteractionEnabled = true
    }
    
    private func setInfoView() {
        infoView.isHidden = true
        infoView.alpha = 0
        
        let containsInfo = selectedMatch?.info != nil
        infoImage.isHidden = !containsInfo
        
        if containsInfo {
            infoTitleLabel.text = selectedMatch?.info?.title
            infoContentLabel.text = selectedMatch?.info?.content
        }
    }
    
    private func setInfoState() {
        infoImage.isHidden = selectedMatch?.info == nil
    
        if isShowingInfo {
            infoImage.image = UIImage(named: "info-icon-enabled")
            fadeIn()
        } else {
            infoImage.image = UIImage(named: "info-icon")
            fadeOut()
        }
    }
    
    private func fadeIn() {
        infoView.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.infoView.alpha = 1
        }
    }
    
    private func fadeOut() {
        UIView.animate(withDuration: 0.5) {
            self.infoView.alpha = 0
        } completion: { _ in
            self.infoView.isHidden = true
        }
    }
    
    private func backToLive() {
        navigationController?.popViewController(animated: true)
        delegate?.backToLiveVC(with: playerViewController.getCurrentTime())
    }
    
    @objc func leaveFullscreen() {
        if !infoView.isHidden {
            infoView.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.backToLive()
            }
        } else {
            backToLive()
        }
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
    
    @objc func displayInfo() {
        isShowingInfo = !isShowingInfo
        setInfoState()
    }
}
