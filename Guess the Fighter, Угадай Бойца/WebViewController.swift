//
//  WebViewController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 12/4/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var link: String!
    var currentTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentTitle = "Mike Zambidis"
        self.titleLabel.text = self.currentTitle
        
        self.link = "https://www.youtube.com/watch?v=Y92Eppp8GDo"
        let url = NSURL (string: link)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forwardButton(sender: UIButton) {
        self.webView.goForward()
    }
    @IBAction func backButton(sender: UIButton) {
        self.webView.goBack()
    }
    
    @IBAction func stopButton(sender: UIButton) {
        self.webView.stopLoading()
    }
    
    @IBAction func refreshButton(sender: UIButton) {
        self.webView.reload()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
