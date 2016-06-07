//
//  Line.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/2/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class Line: NSObject
{
    var points = [LinePoint]()
    
    var pointsWaitingForUpdatesByEstimationIndex = [NSNumber: LinePoint]()
    
    var committedPoints = [LinePoint]()
    
    var isComplete: Bool
    {
        return self.pointsWaitingForUpdatesByEstimationIndex.count == 0
    }
    
    
    func addPointOfType(pointType: LinePoint.PointType, forTouch touch: UITouch) -> CGRect
    {
        let previousPoint = self.points.last
        
        let previousSequenceNumber = previousPoint?.sequenceNumber ?? -1
        
        let point = LinePoint(touch: touch, sequenceNumber: previousSequenceNumber + 1, pointType: pointType)
        
        if let estimationIndex = point.estimationUpdateIndex
        {
            if !point.estimatedPropertiesExpectingUpdates.isEmpty
            {
                pointsWaitingForUpdatesByEstimationIndex[estimationIndex] = point
            }
        }
        
        self.points.append(point)
        
        let updateRect = self.updateRectForLinePoint(point, previousPoint: previousPoint)
        
        return updateRect
    }
    
    
    func removePointsWithType(type: LinePoint.PointType) -> CGRect
    {
        var updateRect = CGRect.null
        var priorPoint: LinePoint?
        
        points = points.filter
        { point in
            let keepPoint = !point.pointType.contains(type)
            
            if !keepPoint
            {
                var rect = self.updateRectForLinePoint(point)
                
                if let priorPoint = priorPoint
                {
                    rect.unionInPlace(updateRectForLinePoint(priorPoint))
                }
                
                updateRect.unionInPlace(rect)
            }
            
            priorPoint = point
            
            return keepPoint
        }
        
        return updateRect
    }
    
    
    func updateRectForLinePoint(point: LinePoint, previousPoint optionalPreviousPoint: LinePoint? = nil) -> CGRect
    {
        var rect = CGRect(origin: point.location, size: CGSize.zero)
        
        var pointMagnitude = point.magnitude
        
        if let previousPoint = optionalPreviousPoint
        {
            pointMagnitude = max(pointMagnitude, previousPoint.magnitude)
            rect = CGRectUnion(rect, CGRect(origin: previousPoint.location, size: CGSize.zero))
        }
        
        // The negative magnitude ensures an outset rectangle.
        let magnitude = -3.0 * pointMagnitude - 2.0
        rect.insetInPlace(dx: magnitude, dy: magnitude)
        
        return rect
    }
    
    func drawInContext(context: CGContext, isDebuggingEnabled: Bool, usePreciseLocation: Bool)
    {
        var maybePriorPoint: LinePoint?
        
        for point in points
        {
            guard let priorPoint = maybePriorPoint else
            {
                maybePriorPoint = point
                continue
            }
            
            // This color will used by default for `.Standard` touches.
            var color = UIColor.blackColor()
            
            let pointType = point.pointType
            
            if isDebuggingEnabled
            {
                if pointType.contains(.Cancelled)
                {
                    color = UIColor.redColor()
                }
                else if pointType.contains(.NeedsUpdate)
                {
                    color = UIColor.orangeColor()
                }
                else if pointType.contains(.Finger)
                {
                    color = UIColor.purpleColor()
                }
                else if pointType.contains(.Coalesced)
                {
                    color = UIColor.greenColor()
                }
                else if pointType.contains(.Predicted)
                {
                    color = UIColor.blueColor()
                }
            }
            else
            {
                if pointType.contains(.Cancelled)
                {
                    color = UIColor.clearColor()
                }
                else if pointType.contains(.Finger)
                {
                    color = UIColor.purpleColor()
                }
                
                if pointType.contains(.Predicted) && !pointType.contains(.Cancelled)
                {
                    color = color.colorWithAlphaComponent(0.5)
                }
                
            }
            
            let location = usePreciseLocation ? point.preciseLocation : point.location
            let priorLocation = usePreciseLocation ? priorPoint.preciseLocation : priorPoint.location
            
            CGContextSetStrokeColorWithColor(context, color.CGColor)
            
            CGContextBeginPath(context)
            
            CGContextMoveToPoint(context, priorLocation.x, priorLocation.y)
            
            CGContextAddLineToPoint(context, location.x, location.y)
            
            CGContextSetLineWidth(context, point.magnitude)
            
            CGContextStrokePath(context)
            
            // Draw azimuith and elevation on all non-coalesced points when debugging.
            if isDebuggingEnabled && !pointType.contains(.Coalesced) && !pointType.contains(.Predicted) && !pointType.contains(.Finger)
            {
                CGContextBeginPath(context)
                
                CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
                
                CGContextSetLineWidth(context, 0.5)
                
                CGContextMoveToPoint(context, location.x, location.y)
                
                var targetPoint = CGPoint(x: 0.5 + 10.0 * cos(point.azimuthAngle), y: 0.0)
                targetPoint = CGPointApplyAffineTransform(targetPoint, CGAffineTransformMakeRotation(point.azimuthAngle))
                targetPoint.x += location.x
                targetPoint.y += location.y
                CGContextAddLineToPoint(context, targetPoint.x, targetPoint.y)
                CGContextStrokePath(context)
            }
            
            maybePriorPoint = point
        }
        
    }
    
    
    func drawFixedPointsInContext(context: CGContext, isDebuggingEnabled: Bool, usePreciseLocation: Bool, commitAll: Bool = false)
    {
        let allPoints = points
        
        var committing = [LinePoint]()
        
        if commitAll == true
        {
            committing = allPoints
            self.points.removeAll()
        }
        else
        {
            for (index, point) in allPoints.enumerate()
            {
                // Only points whose type does not include `.NeedsUpdate` or `.Predicted` and are not last or prior to last point can be committed.
                guard point.pointType.intersect([.NeedsUpdate, .Predicted]).isEmpty && index < allPoints.count - 2 else
                {
                    committing.append(points.first!)
                    
                    break
                }
                
                guard index > 0 else
                {
                    continue
                }
                
                // First time to this point should be index 1 if there is a line segment that can be committed.
                let removed = points.removeFirst()
                committing.append(removed)
            }
        }
        
        // If only one point could be committed, no further action is required. Otherwise, draw the `committedLine`.
        guard committing.count > 1 else
        {
            return
        }
        
        let committedLine = Line()
        committedLine.points = committing
        committedLine.drawInContext(context, isDebuggingEnabled: isDebuggingEnabled, usePreciseLocation: usePreciseLocation)
        
        if committedPoints.count > 0
        {
            // Remove what was the last point committed point; it is also the first point being committed now.
            committedPoints.removeLast()
        }
        
        // Store the points being committed for redrawing later in a different style if needed.
        committedPoints.appendContentsOf(committing)
    }
}

class LinePoint: NSObject
{
    struct PointType: OptionSetType
    {
        let rawValue: Int
        
        static var Standard: PointType
        {
            return self.init(rawValue: 0)
        }
        
        static var Coalesced: PointType
        {
            return self.init(rawValue: 1 << 0)
        }
        
        static var Predicted: PointType
        {
            return self.init(rawValue: 1 << 1)
        }
        
        static var NeedsUpdate: PointType
        {
            return self.init(rawValue: 1 << 2)
        }
        
        static var Updated: PointType
        {
            return self.init(rawValue: 1 << 3)
        }
        
        static var Cancelled: PointType
        {
            return self.init(rawValue: 1 << 4)
        }
        
        static var Finger: PointType
        {
            return self.init(rawValue: 1 << 5)
        }
    }
    
    var sequenceNumber: Int
    
    let timestamp: NSTimeInterval
    
    var force: CGFloat
    
    var location: CGPoint
    
    var preciseLocation: CGPoint
    
    var estimatedPropertiesExpectingUpdates: UITouchProperties
    
    var estimatedProperties: UITouchProperties
    
    let type: UITouchType
    
    var altitudeAngle: CGFloat
    
    var azimuthAngle: CGFloat
    
    let estimationUpdateIndex: NSNumber?
    
   
    var pointType: PointType
    
    var magnitude: CGFloat
    {
        return max(force, 0.025)
    }
    
    
    init(touch: UITouch, sequenceNumber: Int, pointType: PointType)
    {
        self.sequenceNumber = sequenceNumber
        self.type = touch.type
        self.pointType = pointType
        
        self.timestamp = touch.timestamp
        let view = touch.view
        self.location = touch.locationInView(view)
        self.preciseLocation = touch.preciseLocationInView(view)
        self.azimuthAngle = touch.azimuthAngleInView(view)
        self.estimatedProperties = touch.estimatedProperties
        self.estimatedPropertiesExpectingUpdates = touch.estimatedPropertiesExpectingUpdates
        self.altitudeAngle = touch.altitudeAngle
        self.force = (type == .Stylus || touch.force > 0) ? touch.force : 1.0
        
        if !estimatedPropertiesExpectingUpdates.isEmpty
        {
            self.pointType.unionInPlace(.NeedsUpdate)
        }
        
        self.estimationUpdateIndex = touch.estimationUpdateIndex
    }
    
    
    
    
}