//
//  WaterWaveView.swift
//  WaveProgress
//
//  Created by Sanghun Park on 22.09.22.
//

import UIKit

class WaterWaveView: UIView {
    
    //MARK: - Properties
    private let firstLayer = CAShapeLayer()
    private let secondLayer = CAShapeLayer()
    
    private var firstColor: UIColor = .clear
    private var secondColor: UIColor = .clear
    
    private let twoPi: CGFloat = .pi * 2
    private var offset: CGFloat = 0.0
    
    private let width = screenWidth * 0.5
    
    var showSingleWave = false
    private var start = false
    
    var progress: CGFloat = 0.0
    var waveHeight: CGFloat = 0.0
    
    //MARK: - Initializes
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setupViews() {
        bounds = CGRect(x: 0.0, y: 0.0, width: min(width, width), height: min(width, width))
        clipsToBounds = true
        backgroundColor = .cyan
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        waveHeight = 8.0
        
        firstColor = .cyan
        secondColor = .cyan.withAlphaComponent(0.4)
        
        createFirstLayer()
        
        if !showSingleWave {
            createSecondLayer()
        }
    }
    
    private func createFirstLayer() {
        firstLayer.frame = bounds
        firstLayer.anchorPoint = .zero
        firstLayer.fillColor = firstColor.cgColor
        layer.addSublayer(firstLayer)
    }
    
    private func createSecondLayer() {
        secondLayer.frame = bounds
        secondLayer.anchorPoint = .zero
        secondLayer.fillColor = secondColor.cgColor
        layer.addSublayer(secondLayer)
    }
}
