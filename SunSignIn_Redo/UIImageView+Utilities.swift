
//
//  UIImageView+Download.swift
//  GolfMedia
//
//  Created by Jennifer Duffey on 6/9/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

extension UIImageView
{
	typealias ImageCallback = (image: UIImage) -> Void
	
	func loadFromURL(url: NSURL)
	{
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		
		dispatch_async(queue,
		{
			let imageData = NSData(contentsOfURL: url)
			
			if imageData != nil
			{
				dispatch_async(dispatch_get_main_queue(),
				{ () -> Void in
					let newImage = UIImage(data: imageData!)
					self.image = newImage
				})
			}
		})
	}
	
	func loadFromURLWithCallback(url: NSURL, callback: (image: UIImage)->())
	{
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		
		dispatch_async(queue,
		{
			let imageData = NSData(contentsOfURL: url)
			
			dispatch_async(dispatch_get_main_queue(),
			{ () -> Void in
				if imageData != nil
				{
					let newImage = UIImage(data: imageData!)
					callback(image: newImage!)
				}
			})
		})
	}
	
	func blurImage(blurImage: UIImage)
	{
		let imageToBlur = CIImage(image: blurImage)
		let blurFilter = CIFilter(name: "CIGaussianBlur")
		blurFilter!.setValue(imageToBlur, forKey: "inputImage")
		let resultImage = blurFilter!.valueForKey("outputImage") as! CIImage
		let blurredImage = UIImage(CIImage: resultImage)
		self.image = blurredImage
	}
}