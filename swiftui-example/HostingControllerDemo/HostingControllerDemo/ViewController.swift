//
//  ViewController.swift
//  HostingControllerDemo
//
//  Created by 픽셀로 on 2/6/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIController = UIHostingController(rootView: SwiftUIView(text: "Integration Three"))
        
        addChild(swiftUIController)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(swiftUIController.view)
        
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        swiftUIController.didMove(toParent: self)
    }

    @IBSegueAction func showSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text: "Integration One"))
    }
    
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text: "Integration Two"))
    }
    
}
