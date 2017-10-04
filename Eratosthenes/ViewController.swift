//
//  ViewController.swift
//  Eratosthenes
//
//  Created by doug harper on 9/18/17.
//  Copyright © 2017 Doug Harper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var blueView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    blueView.roundViewCorners(.bottomRight, radius: 50)
    
    let redView: UIView = {
      let view = UIView()
      view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
      view.backgroundColor = .red
      view.roundViewCorners(UIRectCorner.allCorners, radius: 20)
      return view
    } ()
    
    view.addSubview(redView)
    
  }

}

public extension UIView {

  public func roundViewCorners(_ corners: UIRectCorner, radius: CGFloat) {

    if #available(iOS 11.0, *) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = getMaskedCorners(from: corners)
    } else {
      // fallback
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
    }
  }

  private func getMaskedCorners(from corners: UIRectCorner) -> CACornerMask {
    var maskedCorners: CACornerMask = []
    if corners.contains(.bottomLeft) {
      maskedCorners = maskedCorners.union(.layerMinXMaxYCorner)
    }
    if corners.contains(.topLeft) {
      maskedCorners = maskedCorners.union(.layerMinXMinYCorner)
    }
    if corners.contains(.bottomRight) {
      maskedCorners = maskedCorners.union(.layerMaxXMaxYCorner)
    }
    if corners.contains(.topRight) {
      maskedCorners = maskedCorners.union(.layerMaxXMinYCorner)
    }
    if corners.contains(.allCorners) {
      maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    return maskedCorners
  }

}


