//
//  loginModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/25.
//

import Foundation

struct userModel{
    // API get한 이후에
    
    func isValidId(id: String) -> Bool {
            let IdRegEx = "[A-Za-z0-9]{5,13}"
            let IdTest = NSPredicate(format: "SELF MATCHES %@", IdRegEx)
            return IdTest.evaluate(with: id)
        } // 아이디 형식 검사
        
        
    func isValidPassword(pwd: String) -> Bool {
            let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordTest.evaluate(with: pwd) // 비밀번호 형식 검사
        
    }
    
    
    // "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
}
