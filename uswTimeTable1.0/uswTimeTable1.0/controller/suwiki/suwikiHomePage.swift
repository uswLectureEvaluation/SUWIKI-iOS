    //
//  suwikiHomePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/31.
//

import UIKit
import Alamofire
import SwiftyJSON

class suwikiHomePage: UIViewController {

    override func viewDidLoad() {
        navigationBarHidden()
        super.viewDidLoad()
        getMainPage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testApiBtn(_ sender: Any) {
        getMainPage()
    }
    
    func getMainPage(){
        let url = "https://api.suwiki.kr/lecture/findAllList"
        
        
        
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            var data = response.data
            var json = JSON(data!)
            var jsonData = json["data"]
            var lectureName = jsonData["lectureName"].stringValue
            print(jsonData)
        }
        
    }
    
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
