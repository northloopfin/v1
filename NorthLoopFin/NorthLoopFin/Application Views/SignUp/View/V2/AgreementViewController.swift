//
//  AgreementViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 20/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import WebKit


class AgreementViewController: BaseViewController, WKNavigationDelegate{

    var agreementType = AppConstants.AGREEMENTTYPE.ACCOUNT
    var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Agreement")
        webView.loadFileURL(getURLToShow(), allowingReadAccessTo: getURLToShow())
        let request = URLRequest(url: getURLToShow())
        webView.load(request)

    }
    func getURLToShow()->URL{
        //var url = Bundle.main.url(forResource: "AccountAgreement", withExtension: "html", subdirectory: "LocalHtml")
        var url = Bundle.main.url(forResource: "AccountAgreement", withExtension: "html")!
        switch self.agreementType {
        case .ACCOUNT:
            url = Bundle.main.url(forResource: "AccountAgreement", withExtension: "html")!
        case .DEPOSIT:
            url = Bundle.main.url(forResource: "DepositAgreement", withExtension: "html")!
        case .CARD:
            url = Bundle.main.url(forResource: "CardAgreement", withExtension: "html")!
        default:
            break
        }
        return url
    }
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
    }
}
extension AgreementViewController:WKUIDelegate{
    
}
