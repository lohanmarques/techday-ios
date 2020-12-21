//
//  MatchesViewController.swift
//  techday-tvOS
//
//  Created by amanda.rodrigues on 21/12/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class MatchesViewController: UICollectionViewController {
    var matches: [Match]? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matches?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let match = self.matches?[indexPath.item] {
            // TODO:
        }
    
        return cell
    }
}
