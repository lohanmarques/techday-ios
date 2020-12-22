//
//  MatchesViewController.swift
//  techday-tvOS
//
//  Created by amanda.rodrigues on 21/12/20.
//

import UIKit

class MatchesViewController: UICollectionViewController {
    private let reuseIdentifier: String = String(describing: MatchCell.self)
    
    var matches: [Match]? {
        didSet {
            reloadData()
        }
    }
    
    var selectedMatch: Match? {
        didSet {
            reloadData()
        }
    }
    
    lazy var viewModel: ViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: DATASOURCE
extension MatchesViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matches?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let match = self.matches?[indexPath.item], let cell = cell as? MatchCell {
            cell.configure(match)
            cell.setEnabled(match == viewModel?.selectedMatch)
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let match = matches?[indexPath.row] else { return }
        
        viewModel?.selectMatch(match)
    }
}

// MARK: LAYOUT
extension MatchesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
