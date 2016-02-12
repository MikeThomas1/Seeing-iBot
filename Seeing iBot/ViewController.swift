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
    var ipAddress: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoStreamView.delegate = self
        
        let size = CGSizeMake(736, 414)
        
        let scene = GameScene(size: size) as GameScene
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)

        let defaults = NSUserDefaults.standardUserDefaults()
        if let address = defaults.stringForKey("ipAddress") {
            ipAddress = address
            loadStream(address)
        } else {
            showAlert()
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "IP", message: "Please enter the IP address of the Raspberry Pi \n i.e. 192.168.2.69", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
            textField.placeholder = "IP Address"
        }
        
        let ipAction = UIAlertAction(title: "Set IP", style: .Default) { (_) in
            let ipTextField = alertController.textFields![0] as UITextField
            self.ipAddress = ipTextField.text
            self.loadStream(self.ipAddress)
        }
        
        alertController.addAction(ipAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func loadStream(ipAddress: String) {
        let urlString = "http://\(ipAddress):8080/stream_simple.html"
        if let url = NSURL(string: urlString) {
            let streamRequest = NSURLRequest(URL: url)
            videoStreamView.loadRequest(streamRequest)
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        ipAddress = nil
        let alertController = UIAlertController(title: "Error Loading", message: "Encountered an error: \(error?.localizedDescription) \n Make sure that the Raspberry Pi is turned on and you've entered the correct IP address. i.e. 192.168.2.69", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
            textField.placeholder = "IP Address"
        }
        
        let ipAction = UIAlertAction(title: "Set IP", style: .Default) { (_) in
            let ipTextField = alertController.textFields![0] as UITextField
            self.ipAddress = ipTextField.text
            self.loadStream(self.ipAddress)
        }
        
        alertController.addAction(ipAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // TODO: hide loading spinner
        refreshStream.enabled = true
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.ipAddress, forKey: "ipAddress")
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        // TODO: start loading spinner
        refreshStream.enabled = false
    }
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        // TODO: move logic into function 
        // TODO: show loading spinner
        let defaults = NSUserDefaults.standardUserDefaults()
        if let address = defaults.stringForKey("ipAddress") {
            ipAddress = address
            loadStream(address)
        } else {
            showAlert()
        }
    }

}

