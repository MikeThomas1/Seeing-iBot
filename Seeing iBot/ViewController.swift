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
    
    let ipAddress = "192.168.1.1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoStreamView.delegate = self
        let size = joyStickView.frame.size
        let scene = GameScene(size: size) as GameScene
        
        joyStickView.showsFPS = true
        joyStickView.showsNodeCount = true
        joyStickView.ignoresSiblingOrder = true

        scene.scaleMode = .Fill
        scene.backgroundColor = UIColor.blackColor()
        
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
    
    func webViewDidFinishLoad(webView: UIWebView) {
        refreshStream.enabled = true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        refreshStream.enabled = false
    }
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        loadStream(ipAddress)
    }
}

