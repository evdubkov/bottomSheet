//
//  ViewController.swift
//  BottomSheet
//
//  Created by dubkov on 13.07.2020.
//  Copyright © 2020 dubkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let transition = ModalTransitioningDelegate()

    @IBAction func showBottomSheet(_ sender: Any) {
        let myViewController = ChildViewController(nibName: "ChildViewController", bundle: nil)
        myViewController.transitioningDelegate = transition
        myViewController.modalPresentationStyle = .custom
        present(myViewController, animated: true)
    }
}

