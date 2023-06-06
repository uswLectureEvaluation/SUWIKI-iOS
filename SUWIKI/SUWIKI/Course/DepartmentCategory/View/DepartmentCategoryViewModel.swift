//
//  DepartmentCategoryViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/01.
//

import Combine

final class DepartmentCategoryViewModel {
    
    var department = Department()
    
//    struct Input {
//        let selectMajor = PublishSubject<String>()
//    }
//
//    struct Output {
//        let selectedMajor = PublishSubject<String>()
//    }
//
//    let input = Input()
//    let output = Output()
    var cancellable = Set<AnyCancellable>()
    
    func selectedMajor(major: String) {
        print(major)
    }
    
}
