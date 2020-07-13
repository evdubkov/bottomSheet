//
//  PresentAnimation.swift
//  BottomSheet
//
//  Created by dubkov on 13.07.2020.
//  Copyright © 2020 dubkov. All rights reserved.
//

import UIKit

final class PresentAnimation: NSObject {
    
    private let duration: TimeInterval = 0.3

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard
            let to = transitionContext.view(forKey: .to),
            let `for` = transitionContext.viewController(forKey: .to)
            else {
                return UIViewPropertyAnimator()
        }
        
        let finalFrame = transitionContext.finalFrame(for: `for`)
        to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: .easeOut) {
                to.frame = finalFrame
        }
        animator.addCompletion { _ in
            transitionContext
                .completeTransition(
                    !transitionContext.transitionWasCancelled)
        }
        return animator
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}
