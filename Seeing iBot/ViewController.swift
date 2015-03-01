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
    @IBOutlet var videoStreamView: UIWebView!
    @IBOutlet var refreshStream: UIButton!
    var ipAddress: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoStreamView.delegate = self
        
        var size = CGSizeMake(736, 414)
        
        let scene = GameScene(size: size) as GameScene
        // Configure the view.
        let skView = self.view as SKView
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
        if let address = defaults.stringForKey("ipAddress")
        {
            self.ipAddress = address
            self.loadStream(address)
        } else {
            self.showAlert()
        }
    }
    
    func showAlert()
    {
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
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loadStream(ipAddress: String)
    {
        var urlString = "http://"
        urlString += ipAddress
        urlString += ":8080/stream_simple.html"
        
        var url = NSURL(string: urlString)
        var streamRequest = NSURLRequest(URL: url!)
        
        self.videoStreamView.loadRequest(streamRequest)
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.ipAddress = nil
        let alertController = UIAlertController(title: "Error Loading", message: "Encountered an error: \(error.localizedDescription) \n Make sure that the Raspberry Pi is turned on and you've entered the correct IP address. i.e. 192.168.2.69", preferredStyle: .Alert)
        
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
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // TODO: hide loading spinner
        self.refreshStream.enabled = true
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.ipAddress, forKey: "ipAddress")
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        // TODO: start loading spinner
        self.refreshStream.enabled = false
    }
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        // TODO: move logic into function 
        // TODO: show loading spinner
        let defaults = NSUserDefaults.standardUserDefaults()
        if let address = defaults.stringForKey("ipAddress")
        {
            self.ipAddress = address
            self.loadStream(address)
        } else {
            self.showAlert()
        }
    }

}

