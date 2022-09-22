//
//  ViewController.swift
//  WaveProgress
//
//  Created by Sanghun Park on 22.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    let waterWaveView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        waterWaveView.clipsToBounds = true
        waterWaveView.backgroundColor = .cyan
        
        view.addSubview(waterWaveView)
        waterWaveView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            waterWaveView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            waterWaveView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            waterWaveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waterWaveView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

