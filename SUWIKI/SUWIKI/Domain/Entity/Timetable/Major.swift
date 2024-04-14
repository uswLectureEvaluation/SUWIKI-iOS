//
//  Department.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/31.
//

import Foundation

struct Major: Identifiable { //: Equatable, Hashable, Decodable
    let id = UUID()
    var name: String
    var bookmark: Bool = false
    var courseCount: Int = 0

    init(name: String, courseCount: Int = 0) {
        self.name = name
        self.courseCount = courseCount
    }

    static func majorCount(name: String) -> Major {
        let count = CoreDataManager.shared.fetchCourseCount(major: name)
        return Major(name: name, courseCount: count)
    }
}


struct MockMajor: Identifiable {
    let id = UUID()
    let name: String
}

enum MajorNames {
    static let list: [MockMajor] = [
        MockMajor(name: "전체"),
        MockMajor(name: "간호학과"),
        MockMajor(name: "건설환경공학"),
        MockMajor(name: "건설환경에너지공학부"),
        MockMajor(name: "건축도시부동산학부"),
        MockMajor(name: "건축학"),
        MockMajor(name: "경영"),
        MockMajor(name: "경영학부"),
        MockMajor(name: "경제금융"),
        MockMajor(name: "경제학부"),
        MockMajor(name: "공예디자인"),
        MockMajor(name: "관광경영"),
        MockMajor(name: "관현악과"),
        MockMajor(name: "교양"),
        MockMajor(name: "교양(야)"),
        MockMajor(name: "국악과"),
        MockMajor(name: "국어국문학"),
        MockMajor(name: "국제개발협력"),
        MockMajor(name: "글로벌비즈니스"),
        MockMajor(name: "기계공학"),
        MockMajor(name: "데이터과학부"),
        MockMajor(name: "도시부동산학"),
        MockMajor(name: "디자인학부"),
        MockMajor(name: "러시아어문학"),
        MockMajor(name: "레저스포츠"),
        MockMajor(name: "무용"),
        MockMajor(name: "문화콘텐츠테크놀러지"),
        MockMajor(name: "미디어SW"),
        MockMajor(name: "미디어커뮤니케이션학과"),
        MockMajor(name: "바이오공학 및 마케팅"),
        MockMajor(name: "바이오싸이언스"),
        MockMajor(name: "바이오화학산업학부"),
        MockMajor(name: "법·행정학부"),
        MockMajor(name: "법학"),
        MockMajor(name: "사학"),
        MockMajor(name: "산업공학"),
        MockMajor(name: "산업및기계공학부"),
        MockMajor(name: "성악과"),
        MockMajor(name: "소방행정학과(야)"),
        MockMajor(name: "스포츠과학부"),
        MockMajor(name: "시스템반도체융복합전공"),
        MockMajor(name: "식품영양학과"),
        MockMajor(name: "신소재공학"),
        MockMajor(name: "아동가족복지학과"),
        MockMajor(name: "연극"),
        MockMajor(name: "영어영문학"),
        MockMajor(name: "영화영상"),
        MockMajor(name: "외국어학부"),
        MockMajor(name: "외식경영"),
        MockMajor(name: "운동건강관리"),
        MockMajor(name: "융합화학산업"),
        MockMajor(name: "의류학과"),
        MockMajor(name: "인문학부"),
        MockMajor(name: "일어일문학"),
        MockMajor(name: "자유전공학부"),
        MockMajor(name: "작곡과"),
        MockMajor(name: "전기공학"),
        MockMajor(name: "전기전자공학부"),
        MockMajor(name: "전자공학"),
        MockMajor(name: "전자물리"),
        MockMajor(name: "전자재료공학"),
        MockMajor(name: "전자재료공학부"),
        MockMajor(name: "정보보호"),
        MockMajor(name: "정보통신"),
        MockMajor(name: "정보통신학부"),
        MockMajor(name: "조소"),
        MockMajor(name: "조형예술학부"),
        MockMajor(name: "중어중문학"),
        MockMajor(name: "창업학 융복합전공"),
        MockMajor(name: "체육학"),
        MockMajor(name: "커뮤니케이션디자인"),
        MockMajor(name: "컴퓨터SW"),
        MockMajor(name: "컴퓨터학부"),
        MockMajor(name: "클라우드융복합전공"),
        MockMajor(name: "패션디자인"),
        MockMajor(name: "프랑스어문학"),
        MockMajor(name: "피아노과"),
        MockMajor(name: "행정학"),
        MockMajor(name: "행정학과(야)"),
        MockMajor(name: "호텔경영"),
        MockMajor(name: "호텔관광학부"),
        MockMajor(name: "화학공학"),
        MockMajor(name: "화학공학·신소재공학부"),
        MockMajor(name: "환경에너지공학"),
        MockMajor(name: "회계"),
        MockMajor(name: "회화")
    ]
}
