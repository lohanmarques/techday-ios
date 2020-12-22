//
//  ViewController.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

class LiveViewController: UIViewController {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var fullscreenImage: UIImageView!
    
    weak var playerViewController: PlayerViewController?
    weak var matchesViewController: MatchesViewController?
    weak var fullscreenViewController: FullScreenViewController?
    weak var delegate: MatchesDelegates?
    
    lazy var viewModel: ViewModel = ViewModel()
    let tapFullscreen: UIGestureRecognizer = UITapGestureRecognizer()
    
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
            
        case Constants.showFullscreenVCSegue:
            self.fullscreenViewController = segue.destination as? FullScreenViewController
            self.fullscreenViewController?.videoURL = self.getCurrentVideo(match: viewModel.selectedMatch)

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
        performSegue(withIdentifier: Constants.showFullscreenVCSegue, sender: nil)
    }
    
    private func getCurrentVideo(match: Match) -> URL? {
        guard let videoURL = Bundle.main.url(forResource: "\(match.home)-\(match.away)", withExtension: "mp4") else {
            return nil
        }
        
        return videoURL
    }
}

// MARK: DELEGATE
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
