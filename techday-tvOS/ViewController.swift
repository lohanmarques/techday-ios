//
//  ViewController.swift
//  techday-tvOS
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewModel: ViewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchMatches()
    }


}

