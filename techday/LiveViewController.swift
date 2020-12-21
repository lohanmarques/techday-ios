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
    
    lazy var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchMatches()
    }
    
    private func updateCollection() {
        
    }
    
    private func updatePlayer() {
        
    }
}

// MARK: DELEGATE
extension LiveViewController: MatchesDelegates {
    
    func matchesDidChange() {
        self.updateCollection()
    }

    func selectedMatchDidChange() {
        self.updatePlayer()
    }
}

// MARK: COLLECTION VIEW DATASOURCE
extension LiveViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellName = String(describing: MatchCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath)
    }
}

// MARK: COLLECTION VIEW DELEGATE
extension LiveViewController: UICollectionViewDelegate {
    
}
