//
//  ViewController.swift
//  Seeing iBot
//
//  Created by Michael Thomas on 3/1/15.
//  Copyright (c) 2015 Mike Thomas. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet private var videoStreamView: UIWebView!
    @IBOutlet private var refreshStream: UIButton!
    @IBOutlet weak var joyStickView: SKView!
    
    // TODO: disable app transport security
    let ipAddress = "192.168.1.1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoStreamView.delegate = self
        let size = joyStickView.frame.size
        let scene = GameScene(size: size) as GameScene
        
        // Configure the view.
        joyStickView.showsFPS = true
        joyStickView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        joyStickView.ignoresSiblingOrder = true

        scene.scaleMode = .Fill
        
        joyStickView.presentScene(scene)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        loadStream(ipAddress)
    }
    
    private func loadStream(ipAddress: String) {
        let urlString = "http://\(ipAddress):8080/stream_simple.html"
        if let url = NSURL(string: urlString) {
            let streamRequest = NSURLRequest(URL: url)
            videoStreamView.loadRequest(streamRequest)
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        // TODO: add the command in the error message
//        let alertController = UIAlertController(title: "Error Loading", message: "Encountered an error: \(error?.localizedDescription) \n Make sure that the Raspberry Pi is turned on and have adhoc wifi running", preferredStyle: .Alert)
//        
//        let retry = UIAlertAction(title: "Retry", style: .Default) { (_) in
//            self.loadStream(self.ipAddress)
//        }
//        
//        alertController.addAction(retry)
        
//        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // TODO: hide loading spinner
        refreshStream.enabled = true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        // TODO: start loading spinner
        refreshStream.enabled = false
    }
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        // TODO: once we have adhoc wifi and static ip address use the static 
        // ip here
        loadStream(ipAddress)
    }
}

