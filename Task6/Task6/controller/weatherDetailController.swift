//
//  weatherDetailController.swift
//  Task6
//
//  Created by sophia on 12/5/19.
//  Copyright © 2019 sophia. All rights reserved.
//

import UIKit

class weatherDetailController: UIViewController {
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    var summary = String()
    var temperature = String()
    var icon = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.temp.text = temperature
        self.desc.text = icon
        self.detail.text = summary
    }
}
