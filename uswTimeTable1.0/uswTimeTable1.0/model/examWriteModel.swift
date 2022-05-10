//
//  examWriteModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/28.
//

import Foundation

struct examBtnClickedType{
    
    struct levelType{
        var easyLevel: Bool = false
        var normalLevel: Bool = false
        var hardLevel: Bool = false
        var levelPoint = 3
        
        mutating func checkPoint(easy: Bool, normal: Bool, hard: Bool){
            if easy == true {
                levelPoint = 0
            } else if normal == true {
                levelPoint = 1
            } else if hard == true {
                levelPoint = 2
            } else {
                levelPoint = 3
            }
        }
    }
        
    struct examType{
        
    }
}
