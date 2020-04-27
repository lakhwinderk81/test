//
//  Extensions.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import NVActivityIndicatorView

extension UIView{
    func getSlantCut() {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: self.bounds.width, y: self.bounds.height-100))
        path.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint.init(x: 0, y: 0))
        path.addLine(to: CGPoint.init(x: 0, y: 0))
        path.close()
        layer.path = path.cgPath;
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = nil;
        self.layer.addSublayer(layer)
    }
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x:0,y:0,width:40,height:40))
        activityIndicatorView.center = self.center
        activityIndicatorView.startAnimating()
        backgroundView.addSubview(activityIndicatorView)
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647) {
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

extension UITextField{
    func setLeftImage(image: UIImage) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 20, height: 20))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
    }
}

extension String{
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func strikeThrought() -> NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.gray, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func attributedString(nonBoldRange: NSRange?) -> NSAttributedString {
        let attrs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        ]
        let nonBoldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
        ]
        let attrStr = NSMutableAttributedString(string: self, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
}

