//
//  loginModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/25.
//

import Foundation

struct userModel{
    
    // 1. 아이디 / 비밀번호 형식 검사 후 형식에 맞지 않으면 로그인 실패
    // 2. 형식에 알맞을 시 해당 str post -> token check 하여 로그인        
    
    func isValidId(id: String) -> Bool {
            let IdRegEx = "[a-z0-9]{5,13}"
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
