    //
//  suwikiHomePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/31.
//

import UIKit
import Alamofire
import SwiftyJSON

class suwikiHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // main Page == tableView 구현 스크롤 최대 10개 제한

    @IBOutlet weak var tableView: UITableView!
    var viewData: Array<homePageData> = []
    var viewData2: Array<homePageData> = []
    override func viewDidLoad() {
        navigationBarHidden()
        super.viewDidLoad()
        getMainPage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testApiBtn(_ sender: Any) {
        getMainPage()
        viewData2 = viewData
        print(viewData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainCell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! mainPageCell
        mainCell.lectureName.text = viewData[indexPath.row].lectureName
        mainCell.lectureType.text = viewData[indexPath.row].lectureType
        mainCell.lectureTotalAvg.text = "\(viewData[indexPath.row].lectureTotalAvg)"
        mainCell.professor.text = viewData[indexPath.row].professor
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.courseTxtField.text = filteredUswCourse[indexPath.row].courseName
        cell.roomTxtField.text = filteredUswCourse[indexPath.row].roomName
        cell.professorTxtField.text = filteredUswCourse[indexPath.row].professor
        cell.numTxtField.text = "\(filteredUswCourse[indexPath.row].num)학년,"
        cell.classTxtField.text = "\(filteredUswCourse[indexPath.row].classification),"
        cell.majorTxtField.text = filteredUswCourse[indexPath.row].major

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        return cell
         */
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
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
            self.viewData2 = self.viewData
            print(self.viewData)
            self.tableView?.reloadData()

        }
        
    }
    
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
    }



}

class mainPageCell: UITableViewCell {

    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var lectureType: UILabel!
    @IBOutlet weak var lectureTotalAvg: UILabel!
    @IBOutlet weak var professor: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
}
