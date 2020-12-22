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
    
    weak var playerViewController: PlayerViewController?
    weak var matchesViewController: MatchesViewController?
    weak var delegate: MatchesDelegates?
    
    lazy var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchMatches()
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

        guard let videoURL = Bundle.main.url(forResource: "\(match.home)-\(match.away)", withExtension: "mp4") else {
            return
        }

        self.playerViewController?.videoURL = videoURL
        self.matchesViewController?.selectedMatch = match
    }
}
