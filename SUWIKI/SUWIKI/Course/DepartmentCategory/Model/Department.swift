//
//  Department.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/31.
//

import Foundation

struct Department: Equatable, Hashable, Decodable {
    var section = ["ㄱ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅍ", "ㅎ"]
    var name = [
        ["간호학과", "건설환경공학", "건축학과", "경영학과", "경제금융학과", "공예디자인학과", "관현악과", "국악과", "국어국문학", "국제개발협력학과", "기계공학과"],
        ["도시부동산학과"],
        ["러시아어문학", "레저스포츠학과"],
        ["문화컨텐츠테크놀러지학과", "미디어SW학과"],
        ["바이오공학 및 마케팅", "법학"],
        ["사학", "산업공학과", "성악과", "소방행정학과(야)", "시스템반도체융복합학과", "식품영양학과", "신소재공학과"],
        ["아동가족복지학과", "연극과", "영어영문학", "영화영상과", "외식경영학과", "운동건강관리학과", "융합화학산업", "의류학과", "일어일문학"],
        ["작곡과", "전기공학과", "전자공학과", "전자재료공학", "정보보호학과", "정보통신공학과", "조소과", "중어중문학"],
        ["체육학과"],
        ["커뮤니케이션디자인학과", "컴퓨터SW학과", "클라우드융복합학과"],
        ["패션디자인학과", "피아노과"],
        ["행정학", "호텔경영학과", "화학공학과", "환경에너지공학", "회계학과", "회화과"]
    ]
}

//            DepartmentSection(items: ["간호학과", "건설환경공학", "건축학과", "경영학과", "경제금융학과", "공예디자인학과", "관현악과", "국악과", "국어국문학", "국제개발협력학과", "기계공학과"].map { Department(name: $0) }, header: "ㄱ"),
//            DepartmentSection(items: [Department(name: "도시부동산학과")], header: "ㄷ"),
//            DepartmentSection(items: ["러시아어문학", "레저스포츠학과"].map { Department(name: $0) }, header: "ㄹ"),
//            DepartmentSection(items: ["문화컨텐츠테크놀러지학과", "미디어SW학과"].map { Department(name: $0) }, header: "ㅁ"),
//            DepartmentSection(items: ["사학", "산업공학과", "성악과", "소방행정학과(야)", "시스템반도체융복합학과", "식품영양학과", "신소재공학과"].map { Department(name: $0) }, header: "ㅅ"),
//            DepartmentSection(items: ["아동가족복지학과", "연극과", "영어영문학", "영화영상과", "외식경영학과", "운동건강관리학과", "융합화학산업", "의류학과", "일어일문학"].map { Department(name: $0) }, header: "ㅇ"),
//            DepartmentSection(items: ["작곡과", "전기공학과", "전자공학과", "전자재료공학", "정보보호학과", "정보통신공학과", "조소과", "중어중문학"].map { Department(name: $0) }, header: "ㅈ"),
//            DepartmentSection(items: [Department(name: "체육학과")], header: "ㅊ"),
//            DepartmentSection(items: ["커뮤니케이션디자인학과", "컴퓨터SW학과", "클라우드융복합학과"].map { Department(name: $0) }, header: "ㅋ"),
//            DepartmentSection(items: ["패션디자인학과", "피아노과"].map { Department(name: $0) }, header: "ㅌ"),
//            DepartmentSection(items: ["행정학", "호텔경영학과", "화학공학과", "환경에너지공학", "회계학과", "회화과"].map { Department(name: $0) }, header: "ㅎ")
