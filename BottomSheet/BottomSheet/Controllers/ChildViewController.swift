//
//  Child2ViewController.swift
//  BottomSheet
//
//  Created by dubkov on 13.07.2020.
//  Copyright © 2020 dubkov. All rights reserved.
//

import UIKit

protocol CustomPresentable {
    var contentHeight: CGFloat { get }
}

class ChildViewController: UIViewController, CustomPresentable {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var contentHeight: CGFloat {
        stackView.frame.size.height
            + mainStackView.frame.size.height
            + view.safeAreaInsets.bottom
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize = CGSize(width: view.bounds.width,
                                      height: contentHeight)
    }
}
