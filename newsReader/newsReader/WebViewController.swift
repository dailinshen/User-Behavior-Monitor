//
//  WebViewController.swift
//  newsReader
//
//  Created by lindashen on 1/9/17.
//  Copyright © 2017 lindashen. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var WebView: UIWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WebView.loadRequest(URLRequest(url: URL(string: url!)!)) // this url is the same url in our json file in the viewconstroller.swift
    }
    
}
