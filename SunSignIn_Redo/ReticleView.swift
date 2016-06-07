//
//  ReticleView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/2/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ReticleView: UIView
{
    var actualAzimuthAngle: CGFloat = 0.0
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    var actualAzimuthUnitVector = CGVector(dx: 0, dy: 0)
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    var actualAltitudeAngle: CGFloat = 0.0
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    var predictedAzimuthAngle: CGFloat = 0.0
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    var predictedAzimuthUnitVector = CGVector(dx: 0, dy: 0)
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    var predictedAltitudeAngle: CGFloat = 0.0
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
    
    let reticleLayer = CALayer()
    let radius: CGFloat = 80
    var reticleImage: UIImage!
    let reticleColor = UIColor(hue: 0.516, saturation: 0.38, brightness: 0.85, alpha: 0.4)
    let dotRadius: CGFloat = 8.0
    let lineWidth: CGFloat = 2.0
    
    var predictedDotLayer = CALayer()
    var predictedLineLayer = CALayer()
    let predictedIndicatorColor = UIColor(hue: 0.53, saturation: 0.86, brightness: 0.91, alpha: 1.0)
    
    var dotLayer = CALayer()
    var lineLayer = CALayer()
    let indicatorColor = UIColor(hue: 0.0, saturation: 0.86, brightness: 0.91, alpha: 1.0)
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // Set the contentScaleFactor.
        self.contentScaleFactor = UIScreen.mainScreen().scale
        
        self.reticleLayer.contentsGravity = kCAGravityCenter
        self.reticleLayer.position = layer.position
        layer.addSublayer(self.reticleLayer)
        
        self.configureDotLayer(layer: predictedDotLayer, withColor: predictedIndicatorColor)
        self.predictedDotLayer.hidden = true
        self.configureLineLayer(layer: predictedLineLayer, withColor: self.predictedIndicatorColor)
        predictedLineLayer.hidden = true
        
        self.configureDotLayer(layer: dotLayer, withColor: indicatorColor)
        self.configureLineLayer(layer: lineLayer, withColor: indicatorColor)
        
        self.reticleLayer.addSublayer(self.predictedDotLayer)
        self.reticleLayer.addSublayer(self.predictedLineLayer)
        self.reticleLayer.addSublayer(self.dotLayer)
        self.reticleLayer.addSublayer(self.lineLayer)
        
        self.renderReticleImage()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIView Overrides
    override func intrinsicContentSize() -> CGSize
    {
        return self.reticleImage.size
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        CATransaction.setDisableActions(true)
        
        self.reticleLayer.position = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        
        self.layoutIndicator()
        
        CATransaction.setDisableActions(false)
    }
    
    func renderReticleImage()
    {
        let imageRadius = ceil(radius * 1.2)
        let imageSize = CGSize(width: imageRadius * 2, height: imageRadius * 2)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, self.contentScaleFactor)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(ctx, imageRadius, imageRadius)
        CGContextSetLineWidth(ctx, 2)
        CGContextSetStrokeColorWithColor(ctx, reticleColor.CGColor)
        CGContextStrokeEllipseInRect(ctx, CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2))
        
        // Draw targeting lines.
        let path = CGPathCreateMutable()
        var transform = CGAffineTransformIdentity
        
        for _ in 0..<4
        {
            CGPathMoveToPoint(path, &transform, radius * 0.5, 0)
            CGPathAddLineToPoint(path, &transform, radius * 1.15, 0)
            self.transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        }
        
        CGContextAddPath(ctx, path)
        CGContextStrokePath(ctx)
        
        self.reticleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.reticleLayer.contents = self.reticleImage.CGImage
        
        self.reticleLayer.bounds = CGRect(x: 0, y: 0, width: imageRadius * 2, height: imageRadius * 2)
        
        self.reticleLayer.contentsScale = contentScaleFactor
    }
    
    func layoutIndicator()
    {
        // Predicted.
        self.layoutIndicatorForAzimuthAngle(self.predictedAzimuthAngle, azimuthUnitVector: self.predictedAzimuthUnitVector, altitudeAngle: self.predictedAltitudeAngle, lineLayer: self.predictedLineLayer, dotLayer: self.predictedDotLayer)
        
        // Actual.
        self.layoutIndicatorForAzimuthAngle(self.actualAzimuthAngle, azimuthUnitVector: self.actualAzimuthUnitVector, altitudeAngle: self.actualAltitudeAngle, lineLayer: self.lineLayer, dotLayer: self.dotLayer)
    }
    
    func layoutIndicatorForAzimuthAngle(azimuthAngle: CGFloat, azimuthUnitVector: CGVector, altitudeAngle: CGFloat, lineLayer targetLineLayer: CALayer, dotLayer targetDotLayer: CALayer)
    {
        let reticleBounds = self.reticleLayer.bounds
        let centeringTransform = CGAffineTransformMakeTranslation(reticleBounds.width / 2, reticleBounds.height / 2)
        
        var rotationTransform = CGAffineTransformMakeRotation(azimuthAngle)
        
        
        // Draw the indicator opposite the azimuth by rotating pi radians, for easy visualization.
        rotationTransform = CGAffineTransformRotate(rotationTransform, CGFloat(M_PI))
        
        /*
         Make the length of the indicator's line representative of the `altitudeAngle`. When the angle is
         zero radians (parallel to the screen surface) the line will be at its longest. At `M_PI`/2 radians,
         only the dot on top of the indicator will be visible directly beneath the touch location.
         */
        let altitudeRadius = (1.0 - altitudeAngle / CGFloat(M_PI_2) * radius)
        
        var lineTransform = CGAffineTransformMakeScale(altitudeRadius, 1)
        lineTransform = CGAffineTransformConcat(lineTransform, rotationTransform)
        lineTransform = CGAffineTransformConcat(lineTransform, centeringTransform)
        targetLineLayer.setAffineTransform(lineTransform)
        
        var dotTransform = CGAffineTransformMakeTranslation(-azimuthUnitVector.dx * altitudeRadius, -azimuthUnitVector.dy * altitudeRadius)
        dotTransform = CGAffineTransformConcat(dotTransform, centeringTransform)
        
        targetDotLayer.setAffineTransform(dotTransform)
    }
    
    func configureDotLayer(layer targetLayer: CALayer, withColor color: UIColor)
    {
        targetLayer.backgroundColor = color.CGColor
        targetLayer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: dotRadius * 2, height: dotRadius * 2))
        targetLayer.cornerRadius = dotRadius
        targetLayer.position = CGPoint.zero
    }
    
    func configureLineLayer(layer targetLayer: CALayer, withColor color: UIColor)
    {
        targetLayer.backgroundColor = color.CGColor
        targetLayer.bounds = CGRect(x: 0, y: 0, width: 1, height: lineWidth)
        targetLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        targetLayer.position = CGPoint.zero
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
