//
//  ViewController.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 26.02.2022.
//

import UIKit

class ViewController: UIViewController {

    let viewT = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        viewT.backgroundColor = .red
        
        view.addSubview(viewT)
        
        viewT.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewT.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            viewT.widthAnchor.constraint(equalToConstant: 100),
            viewT.heightAnchor.constraint(equalToConstant: 120)
        ])
    }


}

