//
//  UIView+Animation.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit

public enum AnimationEdge {
    case none
    case top
    case bottom
    case left
    case right
}

public extension UIView {
    
    @discardableResult func pulse(duration: TimeInterval = 1.3,
                                   delay: TimeInterval = 0,
                                   completion: ((Bool) -> Void)? = nil) -> UIView {
        UIView.animate(withDuration: 1.3,
                       delay: 0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations:{
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (finished) in
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
        return self
    }
    
//    @discardableResult func fadeIn1(duration: TimeInterval = 1.55,
//                                   delay: TimeInterval = 0,
//                                   completion: ((Bool) -> Void)? = nil) -> UIView {
//        isHidden = false
//        alpha = 0
//        UIViewPropertyAnimator(duration: duration, curve: AnimationOptions.curveEaseOut, animations: {
//            self.alpha = 1.0
//        })
//        
//        UIViewPropertyAnimator(withDuration: duration,
//                               delay: delay,
//                               options: .curveEaseOut
//            , animations: {
//                self.alpha = 1
//        }, completion: completion)
//        return self
//    }
    
    @discardableResult func fadeIn(duration: TimeInterval = 1.55,
                                   delay: TimeInterval = 0,
                                   completion: ((Bool) -> Void)? = nil) -> UIView {
        isHidden = false
        alpha = 0
        UIView.animate(
            withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
                self.alpha = 1
        }, completion: completion)
        return self
    }
    
    @discardableResult func fadeOut(duration: TimeInterval = 0.25,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
                self.alpha = 0
        }, completion: completion)
        return self
    }
    
    @discardableResult func slideIn(from edge: AnimationEdge = .none,
                                    x: CGFloat = 0,
                                    y: CGFloat = 0,
                                    duration: TimeInterval = 1.4,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
        let offset = offsetFor(edge: edge)
        transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        isHidden = false
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 2,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
        }, completion: completion)
        return self
    }
    
    @discardableResult func fadeColor(toColor: UIColor = UIColor.red,
                                      duration: TimeInterval = 0.25,
                                      delay: TimeInterval = 0,
                                      completion: ((Bool) -> Void)? = nil) -> UIView {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                self.backgroundColor = toColor
        }, completion: completion)
        return self
    }
    
    @discardableResult func slideOut(to edge: AnimationEdge = .none,
                                     x: CGFloat = 0,
                                     y: CGFloat = 0,
                                     duration: TimeInterval = 0.25,
                                     delay: TimeInterval = 0,
                                     completion: ((Bool) -> Void)? = nil) -> UIView {
        let offset = offsetFor(edge: edge)
        let endTransform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseOut, animations: {
                self.transform = endTransform
        }, completion: completion)
        return self
    }
    
    @discardableResult func bounceIn(from edge: AnimationEdge = .none,
                                     x: CGFloat = 0,
                                     y: CGFloat = 0,
                                     duration: TimeInterval = 0.5,
                                     delay: TimeInterval = 0,
                                     completion: ((Bool) -> Void)? = nil) -> UIView {
        let offset = offsetFor(edge: edge)
        transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        isHidden = false
        UIView.animate(
            withDuration: duration, delay: delay, usingSpringWithDamping: 0.58, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
        }, completion: completion)
        return self
    }
    
    private func offsetFor(edge: AnimationEdge) -> CGPoint {
        if let parentSize = self.superview?.frame.size {
            switch edge {
            case .none: return CGPoint.zero
            case .top: return CGPoint(x: 0, y: -frame.maxY)
            case .bottom: return CGPoint(x: 0, y: parentSize.height - frame.minY)
            case .left: return CGPoint(x: -frame.maxX, y: 0)
            case .right: return CGPoint(x: parentSize.width - frame.minX, y: 0)
            }
        }
        return .zero
    }
}

