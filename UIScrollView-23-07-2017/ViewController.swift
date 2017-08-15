//
//  ViewController.swift
//  UIScrollView-23-07-2017
//
//  Created by Soeng Saravit on 7/23/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    var featureScrollView:UIScrollView!
    var featurePageControl:UIPageControl!
    
    let feature1 = ["title":"Apple Watch","price":"$0.99","image":"1"]
    let feature2 = ["title":"More Designs","price":"$1.99","image":"2"]
    let feature3 = ["title":"Notifications","price":"$0.99","image":"3"]
    
    var featureArray = [Dictionary<String,String>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //----- Scroll View---------
        self.featureScrollView = UIScrollView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 250))
        self.view.addSubview(featureScrollView)
        
        //----- Page Controll ------
        self.featurePageControl = UIPageControl(frame: CGRect(x: self.view.frame.width/2 - 15, y: self.featureScrollView.frame.height, width: 30, height: 10))
        self.featurePageControl.numberOfPages = 3
        self.featurePageControl.pageIndicatorTintColor = UIColor.blue
        self.featurePageControl.currentPageIndicatorTintColor = UIColor.red
        self.view.addSubview(featurePageControl)
        
        featureArray = [feature1,feature2,feature3]
        self.featureScrollView.isPagingEnabled = true
        self.featureScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(featureArray.count), height: 250)
        self.featureScrollView.showsHorizontalScrollIndicator = false
        self.featureScrollView.delegate = self
        loadFeature()
        featurePageControl.numberOfPages = featureArray.count
    }
    
    func loadFeature() {
        for (index,feature) in featureArray.enumerated(){
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
                featureView.titleLabel.text = feature["title"]
                featureView.priceLabel.text = feature["price"]
                featureView.featureImageView.image = UIImage(named: feature["image"]!)
                featureView.frame.size.width = self.view.frame.width
                featureView.frame.size.height = 200
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                self.featureScrollView.addSubview(featureView)
    
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.size.width
        featurePageControl.currentPage = Int(page)
    }

    
}

