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
    
    private let percentLable = UILabel()
    
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
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        waveHeight = 15.0
        
//        firstColor = .cyan
//        secondColor = .cyan.withAlphaComponent(0.4)
//        firstColor = UIColor(red: 0.16, green: 0.30, blue: 0.60, alpha: 1.00)
//        secondColor = UIColor(red: 0.08, green: 0.42, blue: 0.81, alpha: 1.00)
        firstColor = UIColor(red: 0.08, green: 0.60, blue: 0.93, alpha: 1.00)
        secondColor = UIColor(red: 0.27, green: 0.74, blue: 1.00, alpha: 1.00)
        
        createFirstLayer()
        
        if !showSingleWave {
            createSecondLayer()
        }
        
        createPercentLabel()
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
    
    private func createPercentLabel() {
        percentLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        percentLable.textAlignment = .center
        percentLable.text = ""
        percentLable.textColor = .darkGray
        
        addSubview(percentLable)
        
        percentLable.translatesAutoresizingMaskIntoConstraints = false
        percentLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        percentLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func percentAnim() {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = 1.5
        anim.fromValue = 0.0
        anim.toValue = 1.0
        anim.repeatCount = .infinity
        anim.isRemovedOnCompletion = false
        
        percentLable.layer.add(anim, forKey: nil)
    }
    
    func setupProgress(_ pr: CGFloat) {
        progress = pr
        
        percentLable.text = String(format: "%ld%%", NSNumber(value: Float(pr * 100)).intValue)
        
        let top: CGFloat = 1 * bounds.size.height / 2
//        let top: CGFloat = pr * bounds.size.height
        firstLayer.setValue(width - top, forKeyPath: "position.y")
        secondLayer.setValue(width - top, forKeyPath: "position.y")
        
        if !start {
            DispatchQueue.main.async {
                self.startAnim()
            }
        }
    }
    
    private func startAnim() {
        start = true
        waterWaveAnim()
    }
    
    private func waterWaveAnim() {
        let w = bounds.size.width
        let h = bounds.size.height
        
        let bezier = UIBezierPath()
        let path = CGMutablePath()
        
        let startOffsetY = waveHeight * CGFloat(sinf(Float(offset * twoPi * w)))
        var originOffsetY: CGFloat = 0.0
        
        path.move(to: CGPoint(x: 0.0, y: startOffsetY), transform: .identity)
        bezier.move(to: CGPoint(x: 0.0, y: startOffsetY))
        
        for i in stride(from: 0.0, to: w * 1000, by: 1) {
            originOffsetY = waveHeight * CGFloat(sinf(Float(twoPi / w * i + offset * twoPi / w)))
            bezier.addLine(to: CGPoint(x: i, y: originOffsetY))
        }
        
        bezier.addLine(to: CGPoint(x: w * 1000, y: originOffsetY))
        bezier.addLine(to: CGPoint(x: w * 1000, y: h))
        bezier.addLine(to: CGPoint(x: 0.0, y: h))
        bezier.addLine(to: CGPoint(x: 0.0, y: originOffsetY))
        bezier.close()
        
        let anim = CABasicAnimation(keyPath: "transform.translation.x")
        anim.duration = 3.0
        anim.fromValue = -w * 0.5
        anim.toValue = -w - w * 0.5
        anim.repeatCount = .infinity
        anim.isRemovedOnCompletion = false
        
        firstLayer.fillColor = firstColor.cgColor
        firstLayer.path = bezier.cgPath
        firstLayer.add(anim, forKey: nil)
        
        if !showSingleWave {
            let bezier = UIBezierPath()
            
            let startOffsetY = (waveHeight - 15) * CGFloat(sinf(Float(offset * twoPi * w)))
            var originOffsetY: CGFloat = 0.0
            
            bezier.move(to: CGPoint(x: 0.0, y: startOffsetY))
            
            for i in stride(from: 0.0, to: w * 1000, by: 1) {
                originOffsetY = (waveHeight - 0) * CGFloat(cosf(Float(twoPi / w * i + offset * twoPi / w)))
                bezier.addLine(to: CGPoint(x: i, y: originOffsetY))
            }
            
            bezier.addLine(to: CGPoint(x: w * 1000, y: originOffsetY))
            bezier.addLine(to: CGPoint(x: w * 1000, y: h))
            bezier.addLine(to: CGPoint(x: 0.0, y: h))
            bezier.addLine(to: CGPoint(x: 0.0, y: originOffsetY))
            bezier.close()
            
            let anim2 = CABasicAnimation(keyPath: "transform.translation.x")
            anim2.duration = 1.8
            anim2.fromValue = -w * 0.5
            anim2.toValue = -w - w * 0.5
            anim2.repeatCount = .infinity
            anim2.isRemovedOnCompletion = false
            
            secondLayer.fillColor = secondColor.cgColor
            secondLayer.path = bezier.cgPath
            secondLayer.add(anim2, forKey: nil)
        }
    }
}
