//
//  UIView.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

extension UIView {
    
    func addGradient(with colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientView = GradientView(frame: self.bounds)
        gradientView.setupGradient(with: colors, startPoint: startPoint, endPoint: endPoint)
        
        self.insertSubview(gradientView, at: .zero)
    }
}
