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
    
    let dr: TimeInterval = 10.0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let scWidth = view.window?.windowScene?.screen.bounds.size.width
        
        view.addSubview(waterWaveView)
        waterWaveView.setupProgress(waterWaveView.progress)
        
        NSLayoutConstraint.activate([
            waterWaveView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            waterWaveView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            waterWaveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waterWaveView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
//            let dr = CGFloat(1.0 / (self.dr / 0.01))
//            
//            self.waterWaveView.progress += dr
//            self.waterWaveView.setupProgress(self.waterWaveView.progress)
//            
//            if self.waterWaveView.progress >= 0.95 {
//                self.timer?.invalidate()
//                self.timer = nil
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.waterWaveView.percentAnim()
//                }
//            }
//        })
    }
}

