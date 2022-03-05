//
//  AnalyticsViewController.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 01.03.2022.
//

import UIKit

protocol AnalyticsDisplayLogic: AnyObject {
    func displayContent()
}

class AnalyticsViewController: UIViewController {

    private let segmentController: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Week", "Month", "Year"])
        segment.selectedSegmentIndex = 0
        
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = ""
       
        self.title = "Analytics"
        self.view.backgroundColor = .white
        
        setupView()
    }
    
    
    private func setupView() {
        view.addSubview(segmentController)
        
        segmentController.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        segmentController.pin(to: view, [.left: 20, .right: 20])
    }
    
}
