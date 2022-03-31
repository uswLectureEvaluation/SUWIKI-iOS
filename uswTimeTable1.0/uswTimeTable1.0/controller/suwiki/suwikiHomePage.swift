    //
//  suwikiHomePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/31.
//

import UIKit
import Alamofire
import SwiftyJSON

class suwikiHomePage: UIViewController { // main Page == tableView 구현 스크롤 최대 10개 제한

    var viewData: Array<homePageData> = []
    
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
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: jsonData["lectureTotalAvg"].floatValue, lectureStatisfactionAvg: jsonData["lectureStatisfactionAvg"].floatValue, lectureHoneyAvg: jsonData["lectureHoneyAvg"].floatValue, lectureLearningAvg: jsonData["lectureLearningAvg"].floatValue)
                
                self.viewData.append(readData)
                            
            }
            print(self.viewData)
           
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
