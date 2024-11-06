//
//  HomeViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 10/23/24.
//

import UIKit

class HomeViewController: UIViewController {

    let homeScreen = HomeView()
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

}
