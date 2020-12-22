//
//  MatchCell.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

final class MatchCell: UICollectionViewCell {
    
    let gradient: [UIColor] = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.00),
        UIColor(red: 0.18, green: 0.56, blue: 0.24, alpha: 1.00)
    ]
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var tournament: UILabel!
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var awayTeam: UILabel!
    
    func configure(_ match: Match) {
        let goals = getGoals(match.score)
        
        homeScore.text = goals.first
        awayScore.text = goals.last
        tournament.text = match.tournament.uppercased()
        homeTeam.text = match.home.uppercased()
        awayTeam.text = match.away.uppercased()
        homeLogo.image = setImage(for: match.home)
        awayLogo.image = setImage(for: match.away)
    }
    
    func setEnabled(_ enabled: Bool) {
        if enabled {
            mainView.removeGradient()
        } else {
            addGradient()
        }
    }
    
    private func addGradient() {
        mainView.addGradient(with: gradient,
                             startPoint: CGPoint(x: 1.0, y: 0.0),
                             endPoint: CGPoint(x: 1.0, y: 1.0))
    }
    
    private func getGoals(_ score: String) -> [String]  {
        return score.components(separatedBy: " x ")
    }
    
    private func setImage(for name: String) -> UIImage? {
        if let image = imageCache.object(forKey: name as NSString) {
            return image
        }

        guard let path = Bundle.main.path(forResource: "logo-\(name)", ofType: "png") else {
            return nil
        }
        
        guard let image = UIImage(contentsOfFile: path) else {
            return nil
        }

        imageCache.setObject(image, forKey: name as NSString)

        return image
    }
}
