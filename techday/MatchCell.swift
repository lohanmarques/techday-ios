//
//  MatchCell.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

final class MatchCell: UICollectionViewCell {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var tournament: UILabel!
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var awayTeam: UILabel!
    
    func configure(_ match: Match) {
        score.text = match.score
        tournament.text = match.tournament.uppercased()
        homeTeam.text = match.home.uppercased()
        awayTeam.text = match.away.uppercased()
        homeLogo.image = setImage(for: match.home)
        awayLogo.image = setImage(for: match.away)
    }
    
    private func setImage(for name: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: "logo-\(name)", ofType: "png") else {
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
}
