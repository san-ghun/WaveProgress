//
//  ViewController.swift
//  WaveProgress
//
//  Created by Sanghun Park on 22.09.22.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width

class ViewController: UIViewController {
    
    let waterWaveView = WaterWaveView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let scWidth = view.window?.windowScene?.screen.bounds.size.width
        
        view.addSubview(waterWaveView)
        
        NSLayoutConstraint.activate([
            waterWaveView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            waterWaveView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            waterWaveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waterWaveView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

