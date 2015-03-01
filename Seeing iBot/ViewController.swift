//
//  ViewController.swift
//  Seeing iBot
//
//  Created by Michael Thomas on 3/1/15.
//  Copyright (c) 2015 Mike Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var videoStreamView: UIWebView!
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        
        self.showAlert()
    }
    
    func showAlert()
    {
        let alertController = UIAlertController(title: "IP", message: "Please enter the IP address of the Raspberry Pi \n i.e. 192.168.2.69", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "IP Address"
        }
        
        let ipAction = UIAlertAction(title: "Set IP", style: .Default) { (_) in
            let ipTextField = alertController.textFields![0] as UITextField
            // TODO: validate entered ip address
            self.loadStream(ipTextField.text)
        }
        
        alertController.addAction(ipAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loadStream(ipAddress: String)
    {
        var urlString = "http://"
        urlString += ipAddress
        urlString += ":8080/?action=stream"
        
        var url = NSURL(string: urlString)
        var streamRequest = NSURLRequest(URL: url!)
        
        self.videoStreamView.loadRequest(streamRequest)
        
    }
}

