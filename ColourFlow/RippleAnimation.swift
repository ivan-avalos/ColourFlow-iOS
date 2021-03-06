//
//  RippleAnimation.swift
//  RippleAnimationView
//
//  Created by Motoki on 2015/12/22.
//  Copyright (c) 2015 MotokiNarita. All rights reserved.
//

import UIKit

private let DefaultScalingAnimateDuration: TimeInterval = 1.0
private let DefaultAlphaAnimateDuration: TimeInterval   = 0.2
private let DefaultScale: CGFloat = 100

// MARK: - UIView - Ripple Animation Extension
public extension UIView {

    fileprivate var rippleDefaultStartRect: CGRect {
        return CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }

    struct RippleConfiguration {
        var color: UIColor
        var clipsToBounds = false
        var startRect: CGRect? = nil
        var boundSize: CGFloat? = nil
        var scale: CGFloat = DefaultScale
        var scaleAnimateDuration = DefaultScalingAnimateDuration
        var fadeAnimateDuration = DefaultAlphaAnimateDuration
        var completionHandler: (() -> Void)? = nil

        init(frame: CGRect, color: UIColor) {
            self.color = color
        }
    }

    func rippleAnimate(with config: UIView.RippleConfiguration, completionHandler: (() -> Void)?) {

        clipsToBounds = config.clipsToBounds
        let startRect = config.startRect ?? rippleDefaultStartRect
        let boundSize = config.boundSize ?? self.frame.width

        rippleAnimate(with: config.color, scale: DefaultScale, startRect: startRect, boundSize: boundSize, scaleAnimateDuration: config.scaleAnimateDuration, fadeAnimateDuration: config.fadeAnimateDuration, completionHandler: completionHandler)
    }

    // swiftlint:disable function_parameter_count
    private func rippleAnimate(with color: UIColor, scale: CGFloat, startRect: CGRect, boundSize: CGFloat,  scaleAnimateDuration: TimeInterval, fadeAnimateDuration: TimeInterval, completionHandler: (() -> Void)?) {

        var rippleView: RippleView? = RippleView(frame: startRect, backgroundColor: color)
        addSubview(rippleView!)
        let scaleAnimation = {
            let widthRatio = boundSize / rippleView!.frame.width
            rippleView?.transform = CGAffineTransform(scaleX: widthRatio * scale, y: widthRatio * scale)
        }

        // start scale animation
        UIView.animate(withDuration: scaleAnimateDuration, animations: scaleAnimation, completion: { completion in

            guard completion else { return }

            // start fade animation
//            UIView.animate(withDuration: fadeAnimateDuration, animations: fadeAnimation, completion: { completion in
//                guard completion else { return }
//                rippleView?.removeFromSuperview()
//                rippleView = nil
//                completionHandler?()
//            })
            rippleView?.removeFromSuperview()
            rippleView = nil
            completionHandler?()
        })
    }
    // swiftlint:enable function_parameter_count
}

/// Custom UIView for ripple effects
private final class RippleView: UIView {
    
    init(frame: CGRect, backgroundColor: UIColor) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.backgroundColor = backgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.width / 2)
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

}
