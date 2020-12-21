//
//  ViewModel.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import Foundation

protocol MatchesDelegates: class {
    func matchesDidChange()
    func selectedMatchDidChange()
}

final class ViewModel {
    
    var matches: [Match] = []
    var selectedMatch: Match!
    weak var delegate: MatchesDelegates?
    
    func fetchMatches() {
        Repository().fetchMatches { result in
            switch result {
            case .success(let matches):
                self.matches = matches
                
                self.delegate?.matchesDidChange()
                self.selectFirstMatch()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectMatch(_ match: Match)  {
        selectedMatch = match
        delegate?.selectedMatchDidChange()
    }
    
    private func selectFirstMatch() {
        if let firstMatch = matches.first {
            self.selectMatch(firstMatch)
        }
    }
}
