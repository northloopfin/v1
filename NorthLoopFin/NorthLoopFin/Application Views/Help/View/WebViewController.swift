//
//  WebViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 28/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: BaseViewController {
    
    var navTitle: String?
    var url:URL?
    var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: navTitle ?? "")
        print(self.url)
        //webView.loadFileURL(self.url!, allowingReadAccessTo: self.url!)
        let request = URLRequest(url: self.url!)
        webView.load(request)
    }
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
    }
}
extension WebViewController:WKUIDelegate{
    
}
