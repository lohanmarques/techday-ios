//
//  ViewController.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit
import AVKit

class LiveViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return [.portrait]}
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var fullscreenImage: UIImageView!
    
    weak var playerViewController: PlayerViewController?
    weak var matchesViewController: MatchesViewController?
    weak var fullscreenViewController: FullScreenViewController?
    weak var delegate: MatchesDelegates?
    
    lazy var viewModel: ViewModel = ViewModel()
    let tapFullscreen: UIGestureRecognizer = UITapGestureRecognizer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Orientation.lockOrientation(.portrait, andRotateTo: .portrait)
        playerViewController?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        playerViewController?.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchMatches()
        
        setFullscreenAction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.playerVCSegue:
            self.playerViewController = segue.destination as? PlayerViewController

        case Constants.matchesVCSegue:
            self.matchesViewController = segue.destination as? MatchesViewController
            self.matchesViewController?.viewModel = viewModel

        default:
            break
        }
    }
    
    private func setFullscreenAction() {
        tapFullscreen.addTarget(self, action: #selector(enterFullscreen))
        
        fullscreenImage.addGestureRecognizer(tapFullscreen)
        fullscreenImage.isUserInteractionEnabled = true
    }
    
    @objc func enterFullscreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        if let vc = storyboard.instantiateViewController(identifier: Constants.fullscreenVC) as? FullScreenViewController {
            self.fullscreenViewController = vc
            self.fullscreenViewController?.delegate = self
            self.fullscreenViewController?.videoURL = self.getCurrentVideo(match: viewModel.selectedMatch)
            self.fullscreenViewController?.currentTime = self.playerViewController?.getCurrentTime()
            self.fullscreenViewController?.selectedMatch = self.matchesViewController?.selectedMatch
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getCurrentVideo(match: Match) -> URL? {
        guard let videoURL = Bundle.main.url(forResource: "\(match.home)-\(match.away)", withExtension: "mp4") else {
            return nil
        }
        
        return videoURL
    }
}

// MARK: MATCHES DELEGATE
extension LiveViewController: MatchesDelegates {
    
    func matchesDidChange() {
        self.matchesViewController?.matches = self.viewModel.matches
    }

    func selectedMatchDidChange() {
        guard let match = self.viewModel.selectedMatch else {
            return
        }
        
        self.playerViewController?.videoURL = getCurrentVideo(match: match)
        self.matchesViewController?.selectedMatch = match
    }
}

extension LiveViewController: FullscreenDelegate {
    
    func backToLiveVC(with time: CMTime?) {
        self.playerViewController?.currentTime = time
    }
}
