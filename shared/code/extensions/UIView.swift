//
//  UIView.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

extension UIView {
    
    func addGradient(with colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let hasGradient = self.subviews.contains(where: { $0 is GradientView})
        
        if !hasGradient {
            self.backgroundColor = .clear
            
            let gradientView = GradientView(frame: self.bounds)
            gradientView.setupGradient(with: colors, startPoint: startPoint, endPoint: endPoint)
            
            self.insertSubview(gradientView, at: .zero)
        }
    }
    
    func removeGradient() {
        guard let subview = self.subviews.first(where: { $0 is GradientView}) else { return }
        subview.removeFromSuperview()
        
        self.backgroundColor = Constants.Colors.selectedColor
    }
}
