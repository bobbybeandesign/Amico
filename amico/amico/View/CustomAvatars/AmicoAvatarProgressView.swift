//
//  AmicoAvatarProgressView.swift
//  amico
//
//  Created by Yuriy B. on 4/14/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

@IBDesignable
final class AmicoAvatarProgressView: UIView {

    @IBInspectable var trackWidth: CGFloat = 1
    @IBInspectable var trackTint: UIColor? = UIColor(white: 0.9, alpha: 1.0)
    @IBInspectable var progressTint: UIColor? = UIColor.orangeColor()
    @IBInspectable var progressViewPadding: CGFloat = 2
    @IBInspectable var progress: Float = 0.7 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var daysLeftLabel: UILabel?
    @IBOutlet weak var hoursLeftLabel: UILabel?

    var eventStartingTime: NSDate?

    //MARK:- drawRect
    override func drawRect(rect: CGRect) {
        let centerX = CGRectGetWidth(rect) / 2
        let startAngle = CGFloat(-1 * M_PI_2)
        var endAngle = startAngle + CGFloat(2 * M_PI)

        let trackArc = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerX), radius: centerX - trackWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        trackArc.lineWidth = trackWidth
        trackTint?.setStroke()
        trackArc.stroke()

        let progressAngle = CGFloat(progress) * CGFloat(2 * M_PI)
        endAngle = startAngle + progressAngle
        let progressArc = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerX), radius: centerX - trackWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressArc.lineWidth = trackWidth
        progressTint?.setStroke()
        progressArc.stroke()
    }

    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

private extension AmicoAvatarProgressView {
    //MARK:- Helpers
    func commonInit() {
        guard let view = NSBundle(forClass: AmicoAvatarProgressView.self).loadNibNamed("AmicoAvatarProgressView", owner: self, options: nil).first as? UIView else {
            return
        }

        view.layer.cornerRadius = (self.bounds.width - progressViewPadding) / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(view, belowSubview: self)
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: progressViewPadding))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: progressViewPadding))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: progressViewPadding))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: progressViewPadding))
    }
}
