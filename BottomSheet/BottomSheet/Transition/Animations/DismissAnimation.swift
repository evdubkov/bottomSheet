//
//  DismissAnimation.swift
//  BottomSheet
//
//  Created by dubkov on 13.07.2020.
//  Copyright © 2020 dubkov. All rights reserved.
//

import UIKit

final class DismissAnimation: NSObject {
    
    private let duration: TimeInterval = 0.3
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard
            let from = transitionContext.view(forKey: .from),
            let `for` = transitionContext.viewController(forKey: .from)
            else {
                return UIViewPropertyAnimator()
        }
    
        let initialFrame = transitionContext.initialFrame(for: `for`)
        
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: .easeOut) {
                from.frame = initialFrame.offsetBy(dx: 0,
                                                   dy: initialFrame.height)
        }
        animator.addCompletion { _ in
            transitionContext
                .completeTransition(
                    !transitionContext.transitionWasCancelled)
        }
        return animator
    }
}

extension DismissAnimation: UIViewControllerAnimatedTransitioning {
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


