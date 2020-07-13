//
//  ModalInteractiveTransition.swift
//  BottomSheet
//
//  Created by dubkov on 13.07.2020.
//  Copyright © 2020 dubkov. All rights reserved.
//

import UIKit

class ModalInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var direction: TransitionDirection = .present
    
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    private var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
    // MARK: - Linking
    func link(to controller: UIViewController) {
        presentedController = controller
        panRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
    }
    
    // MARK: - Override
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        set {}
    }
}

// MARK: - Gesture Handling
private extension ModalInteractiveTransition {
    
    @objc func handle(recognizer r: UIPanGestureRecognizer) {
        guard
            let gestureView = r.view
            else {
                return
        }
        switch r.state {
        case .began:
            pause()
            if direction == .dismiss {
                if !isRunning {
                    presentedController?.dismiss(animated: true)
                }
            }
        case .changed:
            switch direction {
            case .present:
                let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
                update(percentComplete + increment)
            case .dismiss:
                let persent = percentComplete + r.incrementToBottom(maxTranslation: maxTranslation)

                    self.update(persent)
                
            }
        case .ended, .cancelled:
            let velocity = r.velocity(in: gestureView).y
            percentComplete > 0.4 || velocity > 1600 ? finish() : cancel()
        case .failed:
            cancel()
        default:
            break
        }
    }
}

private extension UIPanGestureRecognizer {
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
}
