//
//  AnimationController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 07/05/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class AnimationController: NSObject {
    private let animationDuration: Double
    private let animationType: AnimationType

    private let pointX: CGFloat
    private let pointY: CGFloat
    private let frame: CGRect
    private let image: UIImage

    enum AnimationType {
        case show
        case dismiss
    }

    // MARK: - Init
    init(animationDuration: Double, animationType: AnimationType, pointX: CGFloat, pointY: CGFloat, frame: CGRect, image: UIImage) {
        self.animationDuration = animationDuration
        self.animationType = animationType
        self.pointY = pointY
        self.pointX = pointX
        self.frame = frame
        self.image = image
    }
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }

        switch animationType {
        case .show:
            transitionContext.containerView.addSubview(toViewController.view)
            let imageView = UIImageView(image: image)
            transitionContext.containerView.addSubview(imageView)
            presentAnimation(with: transitionContext, viewToAnimate: toViewController.view, imageView: imageView)
        case .dismiss:
            transitionContext.containerView.addSubview(toViewController.view)
            transitionContext.containerView.addSubview(fromViewController.view)
            dismissAnimation(with: transitionContext, viewToAnimate: fromViewController.view)
        }
    }

    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, imageView: UIImageView) {
        viewToAnimate.clipsToBounds = true

        viewToAnimate.frame = CGRect(x: viewToAnimate.frame.width, y: 0, width: viewToAnimate.frame.width, height: viewToAnimate.frame.height)
        viewToAnimate.alpha = 0
        viewToAnimate.layoutIfNeeded()
        imageView.frame = frame
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, animations: {
            viewToAnimate.frame.origin = CGPoint(x: 0, y: 0)
            viewToAnimate.alpha = 1
            imageView.frame.size.width = viewToAnimate.frame.width
            imageView.frame.origin = CGPoint(x: 0, y: 0)
            imageView.frame.size.height = viewToAnimate.frame.width + viewToAnimate.safeAreaInsets.top
        }, completion: { _ in
            transitionContext.completeTransition(true)
            imageView.removeFromSuperview()
        })

    }

    func dismissAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
            viewToAnimate.clipsToBounds = true
            let duration = transitionDuration(using: transitionContext)
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
                // MARK: - needs to be implemented
            }, completion: { _ in transitionContext.completeTransition(true)
            })
    }
}
