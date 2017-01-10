//
//  WebViewController.swift
//  newsReader
//
//  Created by lindashen on 1/9/17.
//  Copyright © 2017 lindashen. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIScrollViewDelegate {  //  0110, add UIScrollViewDelegate
    
    @IBOutlet weak var ClockLabel: UILabel!
    
    @IBOutlet weak var WebView: UIWebView!
    
    var url: String?
    
    var seconds = Int(0)
    var minutes = Int(0)
    var ClockTimer = Timer()
    
    private var lastContentOffset = CGFloat(0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Selector chooses the updateClockTime function and repeats makes the function repeat.
        ClockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("updateClockTime"), userInfo: nil, repeats: true)
        
        // this url is the same url in our json file in the viewconstroller.swift
        WebView.loadRequest(URLRequest(url: URL(string: url!)!))
        WebView.scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // move up
            print("up")
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            // move down
            print("down")
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
    func updateClockTime(){
//        ClockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.full)
        seconds += 1
        if (seconds == 60){
            seconds = 0
            minutes += 1
        }
        if (seconds < 10 && minutes < 10) {
            ClockLabel.text = "0\(minutes):0\(seconds)"
        } else if (seconds < 10 && minutes > 9) {
            ClockLabel.text = "\(minutes):0\(seconds)"
        } else if (seconds > 9 && minutes < 10) {
            ClockLabel.text = "0\(minutes):\(seconds)"
        } else {
            ClockLabel.text = "\(minutes):\(seconds)"
        }
    }
}










