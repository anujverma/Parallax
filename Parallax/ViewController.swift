//
//  ViewController.swift
//  Parallax
//
//  Created by Anuj Verma on 12/3/15.
//  Copyright © 2015 Anuj Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = mainImage.image!.size
        print(headerImage.frame.origin)
        
//        let blurEffect = UIBlurEffect(style: .Dark)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.alpha = 0.8
//        blurredEffectView.frame = headerImage.bounds
//        view.addSubview(blurredEffectView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        let offset = Float(self.scrollView.contentOffset.y)
        print("Offset Y: \(offset)")
        
        //When scrolling up have parallax effect
        if offset > 0 {
            
        let headerImageY = convertValue(offset, r1Min: 0, r1Max: 197, r2Min: 0, r2Max: 75)

        headerImage.transform = CGAffineTransformMakeTranslation(headerImage.frame.origin.x, CGFloat(headerImageY))

        let headerY = headerImage.frame.origin.y
        print("Header Y: \(headerY)")
        
        //When scrolling down scale header image
        } else if offset < 0 {
            
            let headerScale = convertValue(offset, r1Min: 0, r1Max: -50, r2Min: 1, r2Max: 1.3)
            headerImage.transform = CGAffineTransformMakeScale(CGFloat(headerScale), CGFloat(headerScale))

        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
            headerImage.frame.origin.x = 0
            headerImage.frame.origin.y = 0
            headerImage.transform = CGAffineTransformMakeScale(1, 1)
        
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min:
        Float, r2Max: Float) -> Float {
            let ratio = (r2Max - r2Min) / (r1Max - r1Min)
            return value * ratio + r2Min - r1Min * ratio
    }
    

    
}

