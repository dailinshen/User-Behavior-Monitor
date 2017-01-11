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
    @IBOutlet weak var PercentageLabel: UILabel!
    
    @IBOutlet weak var SaveSubmitBtn: UIButton!
    
    @IBOutlet weak var WebView: UIWebView!
    
    var url: String?
    
    var seconds = Int(0)
    var minutes = Int(0)
    var ClockTimer = Timer()
    
    var percentage_store: Double = 0.0
    
    var store_data = [Array<Any>]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Selector chooses the updateClockTime function and repeats makes the function repeat.
        ClockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("updateClockTime"), userInfo: nil, repeats: true)
        
        // this url is the same url in our json file in the viewconstroller.swift
        WebView.loadRequest(URLRequest(url: URL(string: url!)!))
        
        WebView.scrollView.delegate = self
        
        
        
        
        
        // ------------------This part is the general html. Need to be speciic.------------------
        guard let myURL = URL(string: (url)!) else {
            print("Error")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("HTML: \r\(myHTMLString)")
        } catch let error {
            print("Error")
        }
        // ------------------This part is the general html. Need to be speciic.------------------
        
        
        
        
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Note that scrollView.contentOffset.y (maximum) + WebView.fram.size.height = scrollView.contentSize.height
        
        let percentage: Double = Double(round(scrollView.contentOffset.y / (scrollView.contentSize.height - WebView.frame.size.height) * 10000) / 100)
        
        let string_percentage = String(percentage)
        percentage_store = percentage
        PercentageLabel.text = "\(string_percentage)%"
        
//        let script = "alert('Javascript')"
//        print(WebView.stringByEvaluatingJavaScript(from: script))
        
//        let currentString = WebView.request?.url?.absoluteString
//        guard let myURL = URL(string: (currentString)!) else {
//            print("Error")
//            return
//        }
//        do {
//            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
//            print("HTML: \(myHTMLString)")
//        } catch let error {
//            print("Error")
//        }
    }
    
    func updateClockTime(){
        
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
        
        
        let currentvalues: [Double] = [Double(seconds + minutes * 60), percentage_store]
        store_data.append(currentvalues)
        print(store_data)
    }
    
    @IBAction func SaveSubmitBtnPressed(_ sender: Any) {
        print("pressed")
    }
    
}














