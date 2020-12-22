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
    
    var videoURL: URL?
    let tapFullscreen: UITapGestureRecognizer = UITapGestureRecognizer()
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerVC = segue.destination as? PlayerViewController {
            playerVC.videoURL = videoURL
        }
    }
    
    private func setFullscreenAction() {
        tapFullscreen.addTarget(self, action: #selector(leaveFullscreen))
        
        fullscreenImage.addGestureRecognizer(tapFullscreen)
        fullscreenImage.isUserInteractionEnabled = true
    }
    
    @objc func leaveFullscreen() {
        navigationController?.popViewController(animated: true)
    }
}
