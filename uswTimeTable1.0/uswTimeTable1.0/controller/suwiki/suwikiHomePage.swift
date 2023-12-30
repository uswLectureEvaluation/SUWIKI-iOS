//
//  suwikiHomePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/31.
//

import UIKit

import Alamofire
import SwiftyJSON
import GoogleMobileAds
import DropDown
import KeychainSwift
import Cosmos


class suwikiHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // main Page == tableView 구현 스크롤 최대 10개 제한

    @IBOutlet weak var suwikiImageView: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryDropDown: UIView!
    @IBOutlet weak var categoryTextField: UILabel!
    @IBOutlet weak var majorCategoryBtn: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var majorTypeLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var chooseMajorLabel: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)

    var tableViewUpdateData: Array<homePageData> = []
    let dropDown = DropDown()
    let keychain = KeychainSwift()

    var count = 0
    
    var option = "modifiedDate"
    
    var majorType: String = ""
    
    let categoryList = ["종합", "만족도", "꿀강", "배움", "날짜"]

    override func viewDidLoad() {
        print("viewdidLoad")
        tableView.separatorInset.left = 0
// 테이블뷰 왼쪽 여백
        // bannerView.adUnitID = "ca-app-pub-8919128352699409/3950816041"
        bannerView.adUnitID = "ca-app-pub-8919128352699409/3950816041"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
                        
        searchTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 6.0, height: 0.0))
        searchTextField.leftViewMode = .always // 텍스트 필드 왼쪽 여백 주기
        
        navigationBarHidden()
        super.viewDidLoad()
        
        categoryDropDown.layer.borderWidth = 1.0
        categoryDropDown.layer.borderColor = UIColor.systemGray5.cgColor
        categoryDropDown.layer.cornerRadius = 10.0
        
        majorCategoryBtn.layer.borderWidth = 1.0
        majorCategoryBtn.layer.borderColor = UIColor.systemGray5.cgColor
        majorCategoryBtn.layer.cornerRadius = 10.0
        
        
        dropDown.anchorView = categoryDropDown
        dropDown.dataSource = categoryList
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textFont = UIFont.systemFont(ofSize: 14)
        

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.categoryTextField.text = categoryList[index]
            self.categoryTextField.font = UIFont(name: "Pretendard", size: 14)
            self.categoryTextField.textColor = colorLiteralBlue
            
            
            if categoryTextField.text == "날짜" {
                tableViewUpdateData.removeAll()
                option = "modifiedDate"
                print(option)
                getLectureData(option: option, majorType: majorType)
                
            } else if categoryTextField.text == "꿀강" {
                tableViewUpdateData.removeAll()
                option = "lectureHoneyAvg"
                getLectureData(option: option, majorType: majorType)

            } else if categoryTextField.text == "만족도"{
                tableViewUpdateData.removeAll()
                option = "lectureSatisfactionAvg"
                getLectureData(option: option, majorType: majorType)

            } else if categoryTextField.text == "배움" {
                tableViewUpdateData.removeAll()
                option = "lectureLearningAvg"
                getLectureData(option: option, majorType: majorType)

            } else if categoryTextField.text == "종합"{
                tableViewUpdateData.removeAll()
                option = "lectureTotalAvg"
                getLectureData(option: option, majorType: majorType)

            }
            
            
        }
        
        self.searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
        tableViewUpdateData.removeAll()
        tableView.reloadData()
        getMajorType()
        getLectureData(option: option, majorType: majorType)
        
        
        
        super.viewWillAppear(true)
    }

  
    @IBAction func majorCategoryBtnClicked(_ sender: Any) {
        
        if keychain.get("AccessToken") != nil {
            
            let majorVC = self.storyboard?.instantiateViewController(withIdentifier: "majorVC") as! MajorCategoryPage
            majorVC.modalPresentationStyle = .fullScreen
            self.present(majorVC, animated: true, completion: nil)
            
        } else {
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginController
            self.present(nextVC, animated: true, completion: nil)
            
        }

        
    }
    @IBAction func categoryButtonClicked(_ sender: Any) {
        dropDown.show()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUpdateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainCell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! mainPageCell
        mainCell.lectureName.text = tableViewUpdateData[indexPath.row].lectureName 
        mainCell.lectureType.text = tableViewUpdateData[indexPath.row].lectureType
        mainCell.lectureTotalAvg.text = tableViewUpdateData[indexPath.row].lectureTotalAvg
        mainCell.majorType.text = tableViewUpdateData[indexPath.row].majorType
        mainCell.professor.text = tableViewUpdateData[indexPath.row].professor
        mainCell.ratingBarView.rating = Double(tableViewUpdateData[indexPath.row].lectureTotalAvg)!
        mainCell.lectureName.sizeToFit()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        mainCell.selectedBackgroundView = bgColorView
 
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if keychain.get("AccessToken") != nil{
            let url = "https://api.kr"

            let headers: HTTPHeaders = [
                "Authorization" : String(keychain.get("AccessToken") ?? "")
            ]

            AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
                
                if response.response?.statusCode == 403{
                    
                    let alert = UIAlertController(title:"권한이 없는 사용자입니다.",
                        message: "관리자에게 문의하거나, 이용 제한 내역을 확인해주세요!",
                        preferredStyle: UIAlertController.Style.alert)
                    let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(cancle)
                    self.present(alert, animated: true, completion: nil)
                    
                } else if response.response?.statusCode == 200 {
                    let AD = UIApplication.shared.delegate as? AppDelegate
                    AD?.lectureId = self.tableViewUpdateData[indexPath.row].id
                    // tokenReissuance(id: viewData[indexPath.row].id)
                    let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! lectureDetailedInformationPage
                    detailVC.lectureId = self.tableViewUpdateData[indexPath.row].id
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            }
            
        } else {
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginController
            self.present(nextVC, animated: true, completion: nil)
                    
        }
    }
    

    func getMajorType(){
        let AD = UIApplication.shared.delegate as? AppDelegate
        
        if let majorData = AD?.majorType{
            
            if majorData == "1"{
                chooseMajorLabel.isHidden = true
                majorTypeLabel.isHidden = false
                majorLabel.isHidden = false
            } else {
                if majorData == ""{
                    majorType = ""
                    chooseMajorLabel.text = "전체"
                } else {
                    majorType = majorData
                    chooseMajorLabel.text = majorType
                }
                
                chooseMajorLabel.isHidden = false
                majorTypeLabel.isHidden = true
                majorLabel.isHidden = true
            }
        }
    }
    
    //            if json["data"].count == 10{
    //                for index in 0..<10{
    //
    //                    let jsonData = json["data"][index]
    //                    let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
    //                    let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
    //                    let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
    //                    let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
    //
    //
    //                    let readData = homePageData(id: jsonData["id"].intValue, semesterList: jsonData["semesterList"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
    //
    //                    self.tableViewUpdateData.append(readData)
    //
    //                }
    //            } else {
    
    // #MARK: 강의 데이터 불러오는 함수, 추후에 majorType 매개변수 추가, 파라미터 추가
    func getLectureData(option: String, majorType: String){
        let url = "https://api.kr"
        
        print(option)
        let parameter: Parameters = [
            "option" : option,
            "majorType" : majorType
        ]
        // JSONEncoding --> URLEncoding으로 변경해야 데이터 넘어옴(파라미터 사용 시)
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default).responseJSON { (response) in
            
            let data = response.data
            let json = JSON(data!)

            for index in 0..<json["data"].count{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                
                let readData = homePageData(id: jsonData["id"].intValue, semesterList: jsonData["semesterList"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
            
                self.tableViewUpdateData.append(readData)
            }
            
            
            
            self.tableView?.reloadData()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func searchBtnClicked(_ sender: Any) {
        if keychain.get("AccessToken") != nil {
            let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "resultVC") as! searchedResultPage
            resultVC.searchData = searchTextField.text!
            self.navigationController?.pushViewController(resultVC, animated: true)
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginController
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.searchTextField {
            searchBtnClicked(self)
        }
        return true
    }
    

    
}

class mainPageCell: UITableViewCell {

    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var lectureType: UILabel!
    @IBOutlet weak var lectureTotalAvg: UILabel!
    @IBOutlet weak var professor: UILabel!
    @IBOutlet weak var majorType: UILabel!
    
    @IBOutlet weak var ratingBarView: CosmosView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 12.0
        
    }
    
    
}
