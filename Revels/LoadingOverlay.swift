//
//  LoadingOverlay.swift
//  Revels
//
//  Created by Vedant Jain on 27/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    init() {
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
//        overlayView.backgroundColor = UIColor(r: 68, g: 68, b: 68)
        overlayView.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        overlayView.backgroundColor = .white
//        overlayView.alpha = 0.7
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        activityIndicator.style = .whiteLarge
        activityIndicator.style = .gray
        activityIndicator.center = CGPoint(x: overlayView.bounds.width/2, y: overlayView.bounds.height/2)
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    public func showOverlay(view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
