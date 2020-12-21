//
//  Match.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import Foundation

struct Matches: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    let home: String
    let away: String
    let score: String
    let tournament: String
}
