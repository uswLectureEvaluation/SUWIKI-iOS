//
//  Department.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/31.
//

import Foundation

struct Major { //: Equatable, Hashable, Decodable
    var name: String
    var bookmark: Bool = false
    var courseCount: Int = 0

    
    init(name: String, courseCount: Int = 0) {
        self.name = name
        self.courseCount = courseCount
    }

    static func majorCount(name: String) async throws -> Major {
        var count = await CoreDataManager.shared.fetchCourseCount(major: name)
        return Major(name: name, courseCount: count)
    }
}

enum MajorNames {
    static let list = ["전체", "간호학과", "건설환경공학", "건설환경에너지공학부", "건축도시부동산학부", "건축학", "경영", "경영학부", "경제금융", "경제학부", "공예디자인", "관광경영", "관현악과", "교양", "교양(야)", "국악과", "국어국문학", "국제개발협력", "글로벌비즈니스", "기계공학", "데이터과학부", "도시부동산학", "디자인학부", "러시아어문학", "레저스포츠", "무용", "문화콘텐츠테크놀러지", "미디어SW", "미디어커뮤니케이션학과", "바이오공학 및 마케팅", "바이오싸이언스", "바이오화학산업학부", "법·행정학부", "법학", "사학", "산업공학", "산업및기계공학부", "성악과", "소방행정학과(야)", "스포츠과학부", "시스템반도체융복합전공", "식품영양학과", "신소재공학", "아동가족복지학과", "연극", "영어영문학", "영화영상", "외국어학부", "외식경영", "운동건강관리", "융합화학산업", "의류학과", "인문학부", "일어일문학", "자유전공학부", "작곡과", "전기공학", "전기전자공학부", "전자공학", "전자물리", "전자재료공학", "전자재료공학부", "정보보호", "정보통신", "정보통신학부", "조소", "조형예술학부", "중어중문학", "창업학 융복합전공", "체육학", "커뮤니케이션디자인", "컴퓨터SW", "컴퓨터학부", "클라우드융복합전공", "패션디자인", "프랑스어문학", "피아노과", "행정학", "행정학과(야)", "호텔경영", "호텔관광학부", "화학공학", "화학공학·신소재공학부", "환경에너지공학", "회계", "회화"]
}






//["간호학과", "건설환경공학", "건설환경에너지공학부", "건축도시부동산학부", "건축학", "경영", "경영학부", "경제금융", "경제학부", "공예디자인", "관광경영", "관현악과", "교양", "교양(야)", "국악과", "국어국문학", "국제개발협력", "글로벌비즈니스", "기계공학", "데이터과학부", "도시부동산학", "디자인학부", "러시아어문학", "레저스포츠", "무용", "문화콘텐츠테크놀러지", "미디어SW", "미디어커뮤니케이션학과", "바이오공학 및 마케팅", "바이오싸이언스", "바이오화학산업학부", "법·행정학부", "법학", "사학", "산업공학", "산업및기계공학부", "성악과", "소방행정학과(야)", "스포츠과학부", "시스템반도체융복합전공", "식품영양학과", "신소재공학", "아동가족복지학과", "연극", "영어영문학", "영화영상", "외국어학부", "외식경영", "운동건강관리", "융합화학산업", "의류학과", "인문학부", "일어일문학", "자유전공학부", "작곡과", "전기공학", "전기전자공학부", "전자공학", "전자물리", "전자재료공학", "전자재료공학부", "정보보호", "정보통신", "정보통신학부", "조소", "조형예술학부", "중어중문학", "창업학 융복합전공", "체육학", "커뮤니케이션디자인", "컴퓨터SW", "컴퓨터학부", "클라우드융복합전공", "패션디자인", "프랑스어문학", "피아노과", "행정학", "행정학과(야)", "호텔경영", "호텔관광학부", "화학공학", "화학공학·신소재공학부", "환경에너지공학", "회계", "회화"]


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

//var name = [
//    ["간호학과", "건설환경공학", "건축학과", "경영학과", "경제금융학과", "공예디자인학과", "관현악과", "국악과", "국어국문학", "국제개발협력학과", "기계공학과"],
//    ["도시부동산학과"],
//    ["러시아어문학", "레저스포츠학과"],
//    ["문화컨텐츠테크놀러지학과", "미디어SW학과"],
//    ["바이오공학 및 마케팅", "법학"],
//    ["사학", "산업공학과", "성악과", "소방행정학과(야)", "시스템반도체융복합학과", "식품영양학과", "신소재공학과"],
//    ["아동가족복지학과", "연극과", "영어영문학", "영화영상과", "외식경영학과", "운동건강관리학과", "융합화학산업", "의류학과", "일어일문학"],
//    ["작곡과", "전기공학과", "전자공학과", "전자재료공학", "정보보호학과", "정보통신공학과", "조소과", "중어중문학"],
//    ["체육학과"],
//    ["커뮤니케이션디자인학과", "컴퓨터SW학과", "클라우드융복합학과"],
//    ["패션디자인학과", "피아노과"],
//    ["행정학", "호텔경영학과", "화학공학과", "환경에너지공학", "회계학과", "회화과"]
//]

//var section = ["", "ㄱ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅍ", "ㅎ"]
//var nameWithSection = [
//    ["전체"],
//    ["간호학과", "건설환경공학", "건설환경에너지공학부", "건축도시부동산학부", "건축학", "경영", "경영학부", "경제금융", "경제학부", "공예디자인", "관광경영", "관현악과", "교양", "교양(야)", "국악과", "국어국문학", "국제개발협력", "글로벌비즈니스", "기계공학"],
//    ["데이터과학부", "도시부동산학", "디자인학부"],
//    ["러시아어문학", "레저스포츠"],
//    ["무용", "문화콘텐츠테크놀러지", "미디어SW", "미디어커뮤니케이션학과"],
//    ["바이오공학 및 마케팅", "바이오싸이언스", "바이오화학산업학부", "법·행정학부", "법학"],
//    ["사학", "산업공학", "산업및기계공학부", "성악과", "소방행정학과(야)", "스포츠과학부", "시스템반도체융복합전공", "식품영양학과", "신소재공학"],
//    ["아동가족복지학과", "연극", "영어영문학", "영화영상", "외국어학부", "외식경영", "운동건강관리", "융합화학산업", "의류학과", "인문학부", "일어일문학"],
//    ["자유전공학부", "작곡과", "전기공학", "전기전자공학부", "전자공학", "전자물리", "전자재료공학", "전자재료공학부", "정보보호", "정보통신", "정보통신학부", "조소", "조형예술학부", "중어중문학"],
//    ["창업학 융복합전공", "체육학"],
//    ["커뮤니케이션디자인", "컴퓨터SW", "컴퓨터학부", "클라우드융복합전공"],
//    ["패션디자인", "프랑스어문학", "피아노과"],
//    ["행정학", "행정학과(야)", "호텔경영", "호텔관광학부", "화학공학", "화학공학·신소재공학부", "환경에너지공학", "회계", "회화"]
//]
