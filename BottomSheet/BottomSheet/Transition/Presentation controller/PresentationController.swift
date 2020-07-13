//
//  PresentationController.swift
//  BottomSheet
//
//  Created by dubkov on 13.07.2020.
//  Copyright © 2020 dubkov. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    var transition: ModalInteractiveTransition?
    
    private var presentedViewRect: CGRect {
        if let vc = presentedViewController as? CustomPresentable,
            let view = containerView {
            let height = min(vc.contentHeight, view.bounds.height)
            let rect = CGRect(x: 0,
                              y: view.bounds.height - height,
                              width: view.bounds.width,
                              height: height)
            return rect
        }
        return .zero
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        presentedViewRect
    }
    
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        presentedView?.frame = presentedViewRect
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard
            let view = presentedView
            else {
                return
        }
        containerView?.addSubview(view)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if completed {
            transition?.direction = .dismiss
        }
    }
}
