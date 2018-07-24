//
//  WikiDetailViewController.swift
//  WikiApp
//
//  Created by Sachin Nautiyal on 7/24/18.
//  Copyright © 2018 Sachin Nautiyal. All rights reserved.
//

import UIKit
import WebKit

class WikiDetailViewController: UIViewController {
    
    
    @IBOutlet weak var webViewOutlet: UIView!
    var webView : WKWebView!
    @IBOutlet weak var progressViewOutlet: UIProgressView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    struct Constant {
        static let defaultUrl = "https://en.wikipedia.org/wiki/"
        static let errorTitle = "Error"
        static let okayText = "Okay"
        static let estimatedProgress = "estimatedProgress"
        static let loading = "loading"
    }
    var pageTitle : String?
    
    fileprivate func setupView() {
        webView = WKWebView(frame: webViewOutlet.frame)
        webViewOutlet.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        if let pTitle = pageTitle {
            self.title = pTitle
            let urlStr = Constant.defaultUrl + pTitle
            if let url = URL(string: urlStr) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        self.webView.reload()
    }
    
    @IBAction func safariButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.webView.goBack()
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        self.webView.goForward()
    }
    
}


// MARK: - Progress view for webView
extension WikiDetailViewController  : WKNavigationDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == Constant.loading) {
            backButtonOutlet.isEnabled = webView.canGoBack
            nextButtonOutlet.isEnabled = webView.canGoForward
        }
        if (keyPath == Constant.estimatedProgress) {
            progressViewOutlet.isHidden = webView.estimatedProgress == 1
            progressViewOutlet.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: Constant.errorTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.okayText, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressViewOutlet.setProgress(0.0, animated: false)
    }
}
