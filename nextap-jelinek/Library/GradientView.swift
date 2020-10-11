//
//  GradientView.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 11/10/2020.
//

import Foundation
import UIKit

@IBDesignable class GradientView: UIView {
  
  @IBInspectable var gradientTopColor: UIColor = UIColor.white {
    didSet {
      layoutSubviews()
    }
  }
  
  @IBInspectable var gradientBottomColor: UIColor = UIColor.black {
    didSet {
      layoutSubviews()
    }
  }
  
  private var gradientLayer: CAGradientLayer?
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    gradientLayer?.removeFromSuperlayer()
    
    gradientLayer = CAGradientLayer()
    gradientLayer?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    gradientLayer?.colors = [gradientTopColor.cgColor, gradientBottomColor.cgColor]
    gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.0)
    gradientLayer?.endPoint = CGPoint(x: 1.0, y: 1.0)
    
    layer.addSublayer(gradientLayer!)
  }
}
