//
//  RestrictedPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class RestrictedPage: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension RestrictedPage: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
}
