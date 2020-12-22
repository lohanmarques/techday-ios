//
//  GradientView.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

class GradientView: UIView {
    
    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gradientLayer?.frame = self.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        gradientLayer?.frame = self.bounds
    }

    public func setupGradient(with colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        gradientLayer = self.layer as? CAGradientLayer

        gradientLayer?.colors = colors.map({ return $0.cgColor })
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
    }

    override class var layerClass: AnyClass {
        
        return CAGradientLayer.self
    }
}
