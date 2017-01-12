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
    
    var story_title: String = "title"
    
    var seconds = Int(0)
    var minutes = Int(0)
    var ClockTimer = Timer()
    
    var percentage_store: Double = 0.0
    
    var store_data = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Selector chooses the updateClockTime function and repeats makes the function repeat.
        ClockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("updateClockTime"), userInfo: nil, repeats: true)
        
        // this url is the same url in our json file in the viewconstroller.swift
        WebView.loadRequest(URLRequest(url: URL(string: url!)!))
        
        WebView.scrollView.delegate = self
        
        store_data.append("Time,Percentage")
        
        // ------------------This part is the general html. Need to be speciic.------------------
//        guard let myURL = URL(string: (url)!) else {
//            print("Error")
//            return
//        }
//        do {
//            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
//            print("HTML: \r\(myHTMLString)")
//        } catch let error {
//            print("Error")
//        }
        
        // It seems like we could use stringByEvaluatingJavascript to write a jQuery based on the HTML and each scroll behavior performed by the user.
        //        self.WebView.stringByEvaluatingJavaScript(from: "alert('This is a javascript')")
        
        // ------------------This part is the general html. Need to be speciic.------------------
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Note that scrollView.contentOffset.y (maximum) + WebView.fram.size.height = scrollView.contentSize.height
        
        let percentage: Double = Double(round(scrollView.contentOffset.y / (scrollView.contentSize.height - WebView.frame.size.height) * 10000) / 100)
        
        let string_percentage = String(percentage)
        percentage_store = percentage
        PercentageLabel.text = "\(string_percentage)%"
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
        
        let currentvalues = String(seconds + minutes * 60) + "," + String(percentage_store)
        store_data.append(currentvalues)
    }
    
    @IBAction func SaveSubmitBtnPressed(_ sender: Any) {
        print("pressed")
        
        // save time and percentage to local disk.
        do {
            // get the documents folder url
            
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let title_temp = story_title.replacingOccurrences(of: " ", with: "_", options: String.CompareOptions.literal, range: nil)
            
            // create the destination url for the text file to be saved
            // This url will be used to send to AWS account. 
            
            let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("\(title_temp).txt")
            let text = store_data.joined(separator: "\n")
            do {
                // writing to disk
                try text.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)
                
                // saving was successful. any code posterior code goes here
                // reading from disk
                do {
                    // success notification
                    print("successfully saved at\(fileDestinationUrl)")
                } catch let error as NSError {
                    print("error loading contentsOf url \(fileDestinationUrl)")
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print("error writing to url \(fileDestinationUrl)")
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print("error getting documentDirectoryURL")
            print(error.localizedDescription)
        }
    }
    
}
























