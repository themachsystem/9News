//
//  NewsPageViewController.swift
//  News
//
//  Created by Alvis Mach on 13/3/21.
//

import UIKit
import WebKit

class NewsPageViewController: UIViewController {
    var viewModel: NewsPageViewModel!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.newsTitle
        loadNewsPage()
    }
    
    private func loadNewsPage() {
        if let url = URL(string: viewModel.newsUrl) {
            webView.load(URLRequest(url: url))
        }
    }
}

