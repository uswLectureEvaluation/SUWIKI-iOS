# SUWIKI(2022.01 ~ )


[App Store - SUWIKI](https://apps.apple.com/kr/app/suwiki/id1615744899)
- 리펙토링은 SUWIKI 디렉터리에서 진행중입니다.

<img src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/280abf3b-8750-4941-aa14-6fb205426836" width="200">
<br>
<img src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/7eb97179-75bb-48a3-a247-84a7a0383963" width="400">

___
### 바로가기
  - [UI](#ui)
  - [담당 기능](#담당-기능)
  - [사용 기술](#사용-기술)
  - [개발일지 및 트러블 슈팅](#개발일지-및-트러블-슈팅)
    - [1. 시간표 UX 개선](#1-시간표-ux-개선)
      - [1.1 시간표를 강의에 추가하기 어려운 UX](#11-시간표를-강의에-추가하기-어려운-ux)
      - [1.2 HIG에 적합하지 않은 UI/UX](#12-hig에-적합하지-않은-uiux)
    - [2. 리펙토링 및 프로젝트 구조 설계](#2-리펙토링-및-프로젝트-구조-설계)
    - [3. App Group 적용](#3-app-group-적용)
    - [4. 코어데이터 NSBatchInsertRequest를 사용한 성능 개선](#4-코어데이터-nsbatchinsertrequest를-사용한-성능-개선)
    - [5. Alamofire serializingDecodable 적용](#5-alamofire-serializingdecodable-적용)
    - [6. Network Layer 설계](#6-network-layer-설계)
    - [7. 스파게티 코드 리펙토링](#7-스파게티-코드-리펙토링)
    - [8. Core Data thread-safe 문제](#8-core-data-thread-safe-문제)
    

## 🧑🏻‍💻 수원대학교 공식 시간표 & 강의평가 서비스
- **3,600명의 사용 유저, 다운로드 약 6,700회, 업데이트 16회**
- iOS 1인 개발 및 디자인 진행, 기획 참여
- 대량 데이터 저장 속도 **약 3초대에서 0.6초 미만으로 개선(약 83%)**
- 1,000줄 이상의 스파게티 코드 **약 240줄로 개선**
- 아키텍처가 없는 구조에서 MVC, 현재는 **MVVM + Clean Architecture 적용 진행 중**
- 2년간 운영하며 **약 12만줄 이상의 코드 작성**

## UI
<details>
<summary> 펼쳐보기</summary>
<div markdown="1">

  | **시간표** | **강의평가** | **위젯** |
  | :---: | :---: | :---: |
  | ![시간표](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/763634c5-5555-4810-b168-f9d78f95bbbc) | ![강의평가](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/51a06401-9824-4f79-88da-ad9a033bbb79) | ![위젯](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/7e2cd0de-d8ab-4805-897d-f1c5ee00238a) |

  | **시간표 추가 1** | **시간표 추가 2** | **시간표 추가 3** |
  | :---: | :---: | :---: |
  | ![시간표 추가 1](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/ad1069bd-8a97-44c4-8d5d-3fdba5522add) | ![시간표 추가 2](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/0d0efda0-0f10-47e5-bee3-47308b200060) | ![시간표 추가 3](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/e7f084f5-e939-4a2e-95f5-feebd44287c3) |

  | **강의평가** | **시험정보** | **글 작성** |
  | :---: | :---: | :---: |
  | ![강의평가](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/becb251f-83b2-4d76-b0a3-4278cd50b90d) | ![시험정보](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/9b5486e1-e30f-4f09-ba16-dd4a15caf5a3) | ![글 작성](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/e935a422-8e29-47e2-87f9-06d391bafe27) |

<br> 
</div>
</details>


## 담당 기능
- 앱 구조 설계 - Clean Architecture, MVVM
- 시간표, 시간표 위젯 구현(Core Data, Firebase)
- 강의평가 기능 구현(Alamofire, Network Layer 설계)
- 토큰 인터셉터 구현

## 사용 기술
- UIKit(Storyboard & Code Base), SwiftUI, SnapKit, Then, WidgetKit
- Swift Concurrency, Actor, Combine(일부 기능 binding)
- Core Data, Firebase
- Alamofire, JWT, Clean Architecture, MVVM

## 개발일지 및 트러블 슈팅
### 1. 시간표 UX 개선
### 1.1 시간표를 강의에 추가하기 어려운 UX
<img src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/3e520c19-4f28-41fc-9399-9179811c3312" align="left"><br><br><br><br><br><br>
<br><br><br><br><br>
<br>
<br>

- 유저는 강의명을 모를 경우 강의를 추가하기 어려운 UX 발생
  
**해결방안**
- 학과를 우선 선택할 수 있도록 UI 수정, 유저의 학과 즐겨찾기 기능 추가
- 강의, 교수명 검색으로 강의 검색 가능. 띄어쓰기 고려한 데이터 필터링 기능 구현
<br><br>

### 1.2 HIG에 적합하지 않은 UI/UX

<img src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/8e42817a-7f04-415a-98d8-8f5656ae17fc" aligt="left">

- iOS의 UX와는 동떨어진 UI / UX, 강의 정보 수정의 불필요한 UX 발생

**해결방안**
- 애플의 UX와 유사한 형태로 UI 수정
- 강의 정보 수정 기능 삭제
<br>

### 2. 리펙토링 및 프로젝트 구조 설계
![이미지](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/5fa794ff-e180-4a1c-a15e-5829fd2df909)  

**기존 SUWIKI 코드의 문제**
- 스토리보드 위주의 UI 구현
- 별도의 아키텍처 패턴이 적용되지 않음
- 한 파일의 코드가 1천줄이 넘어가고, 비슷한 기능의 함수가 여러개 정의됨
- 코드간의 결합도가 높고 응집도가 낮아 재사용성이 떨어짐

**현재**
- UI는 SwiftUI와 UIKit(Code Base)을 사용하여 구현 중
- 데이터 저장 공간을 Realm에서 Core Data로 전환
- MVC 패턴을 적용했었으나, ViewController의 코드가 매우 길어지는 문제를 해결하고자 MVVM을 적용
- SwiftUI와 UIKit을 MVVM 패턴 기반으로 구현 진행 중
- 데이터 저장 공간의 전환과 다른 UI 프레임워크에 대응하고자 클린 아키텍처를 적용하여 대응중

### 3. App Group 적용
![이미지](https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/f978682e-d9d9-46d0-a543-38e0d47009c9)

**App Group 적용 이유**
- 그림과 같이, Core Data에 저장되는 데이터를 App과 Widget Extension에서 공유되어야 함
- 기존 방식의 Core Data는 App 내부에서만 접근이 가능

**적용 방식**
- Core Data에 저장된 데이터를 위젯에서도 접근할 수 있음
- 선택된 시간표의 ID를 추적하기 위해 UserDefaults 또한 App Group을 적용함

### 4. 코어데이터 NSBatchInsertRequest를 사용한 성능 개선
```swift
func saveFirebaseCourse(course: [[String: Any]]) throws {
    try deleteFirebaseCourse()
    guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
        throw CoreDataError.entityError
    }
    let batchInsertRequest = NSBatchInsertRequest(entity: entity, objects: course)
    if let fetchResult = try? context.execute(batchInsertRequest),
        let batchInsertResult = fetchResult as? NSBatchInsertResult,
        let success = batchInsertResult.result as? Bool, 
        success {
            return
        }
    print(CoreDataError.batchInsertError.localizedDescription)
}
```
**데이터 저장 시 발생하는 문제 정의**
- 매 학기마다 Firebase에 저장된 2,000여 개의 데이터를 Core Data에 저장해야함
- 기존의 방식은 데이터의 갯수만큼 반복하여 저장하였으나 문제는 다음과 같음
1. 데이터 저장 시 약 3초 소요
2. 간헐적으로 에러 발생(Cocoa 132001). 대량의 데이터를 반복문을 통해 처리하는 과정에서 context와 entity를 계속 접근하기 때문에 에러가 발생한다고 추론

**따라서 NSBatchInsertRequest를 적용하여 문제를 해결**
- 데이터 저장에 약 0.5초 소요
- 단일 호출만 스택 프레임에 올라가 모든 데이터를 영구 저장소에 삽입할 수 있기에 메모리 효율성 증가

### 5. Alamofire serializingDecodable 적용
```swift
class APIProvider {
    static func request<T: Decodable>(
        _ object: T.Type,
        target: TargetType
    ) async throws -> T {
        return try await AlamofireManager
            .shared
            .session
            .request(target)
            .serializingDecodable()
            .value
    }
}
```
```swift
/// func search: 강의평가를 검색한 후, 검색 데이터를 서버에서 내려받습니다.
/// 무한스크롤 기능을 위해 페이지가 1일 경우 search 데이터로 초기화, 아닐 경우 append 합니다.
func search() async throws {
    guard !searchText.isEmpty else { return }
    do {
        if self.searchPage == 1 {
            searchLecture = try await searchUseCase.excute(searchText: searchText,
                                                           option: option,
                                                           page: searchPage,
                                                           major: major)
            await MainActor.run {
                lecture = searchLecture
            }
        } else {
            let searchData = try await searchUseCase.excute(searchText: searchText,
                                                            option: option,
                                                            page: searchPage,
                                                            major: major)
            await MainActor.run {
                searchLecture.append(contentsOf: searchData)
                lecture.append(contentsOf: searchData)
            }
        }
    } catch {
        fatalError(error.localizedDescription)
    }
}
```

**responseDecodable과 serializingDecodable의 차이**
- 현재 코드 작성 시 completion handler를 지양하고 async / await를 지향하는 코드를 작성 중
- responseDecodable 대신 serializingDecodable을 사용(serializingDecodable은 DataTask 반환)
- responseDecodable은 핸들러가 메인 스레드에서 호출되지만, serializngDecodable은 스레드 관리가 따로 되지 않음(responseDecodable은 내부적으로 데이터 처리 기능 실행 위치가 메인큐로 지정되어 있음)

**해결 방안**
- 호출부 메소드 전체가 아닌 반환된 데이터에 Main Actor 적용하여 프로퍼티 업데이트

### 6. Network Layer 설계
### 기존 네트워크 호출 방식의 문제
```swift
func getDetailPage(){
    let url = "https://api.kr"

    let headers: HTTPHeaders = [
        "Authorization" : String(keychain.get("AccessToken") ?? "")
    ]

    AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
        
        let data = response.value
        let json = JSON(data ?? "")["data"]
        
        let totalAvg = String(format: "%.1f", round(json["lectureTotalAvg"].floatValue * 1000) / 1000)
        let totalSatisfactionAvg = String(format: "%.1f", round(json["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
        let totalHoneyAvg = String(format: "%.1f", round(json["lectureHoneyAvg"].floatValue * 1000) / 1000)
        let totalLearningAvg = String(format: "%.1f", round(json["lectureLearningAvg"].floatValue * 1000) / 1000)
        
        let detailLectureData = detailLecture(id: json["id"].intValue, semesterList: json["semesterList"].stringValue, professor: json["professor"].stringValue, majorType: json["majorType"].stringValue, lectureType: json["lectureType"].stringValue, lectureName: json["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg, lectureTeamAvg: json["lectureTeamAvg"].floatValue, lectureDifficultyAvg: json["lectureDifficultyAvg"].floatValue, lectureHomeworkAvg: json["lectureHomeworkAvg"].floatValue)
        
        self.detailLectureArray.append(detailLectureData)
        self.lectureViewUpdate()
    }
}
```
- 동일하게 작동하는 메소드를 매번 작성하는 문제 발생
- DTO를 따로 정의하지 않고, SwiftyJSON을 사용해서 매번 하나씩 파싱함
- 코드의 재사용성, 가독성이 매우 떨어짐
- 메소드에서 URL이 노출됨

### 개선 후
```swift
extension DTO {
    struct DetailLectureResponse: Codable {
        /// 강의 ID
        let id: Int
        /// 해당 강의 년도 + 학기 -> "2021-1,2022-1"
        let semesterList: String
        /// 교수명
        let professor: String
        /// 개설 학과
        let majorType: String
        /// 이수 구분
        let lectureType: String
        /// 강의명
        let lectureName: String
        /// 강의평가 평균 지수
        let lectureTotalAvg: Float
        /// 강의평가 만족도 지수
        let lectureSatisfactionAvg: Float
        /// 강의평가 꿀강 지수
        let lectureHoneyAvg: Float
        /// 강의평가 배움 지수
        let lectureLearningAvg: Float
        /// 강의평가 팀플 지수
        let lectureTeamAvg: Float
        /// 강의평가 난이도 지수
        let lectureDifficultyAvg: Float
        /// 강의평가 과제 지수
        let lectureHomeworkAvg: Float
    }
}
```
```swift
extension APITarget.Lecture {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "lecture")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getHome:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getHome:
            "/all"
        case .search:
            "/search"
        case .detail:
            ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .getHome(allLectureRequest):
            return .query(allLectureRequest)
        case let .search(searchLectureRequest):
            return .query(searchLectureRequest)
        case let .detail(detailLectureRequest):
            return .query(detailLectureRequest)
        }
    }
}
```
```swift
func fetchDetail(
    id: Int
) async throws -> DetailLecture {
    let target = APITarget.Lecture.detail(
        DTO.DetailLectureRequest(lectureId: id)
    )
    let dtoDetailLecture = try await APIProvider.request(
        DTO.DecodingDetailLectureResponse.self,
        target: target
    )
    return dtoDetailLecture.detailLecture.entity
}
```
- 네트워크 계층 설계
- 추상화를 통한 공통된 기능들을 인터페이스로 정의, 중복 기능은 확장으로 구현 
- 확장성과 재사용성을 고려한 DTO 설계
- 클린아키텍처의 데이터 흐름을 지향

### 7. 스파게티 코드 리펙토링
**문제 상황**
- 기존의 시간표 중복 검증 로직은 약 천 줄가량의 코드로 복잡하게 구현되어 있음
- 대부분의 버그가 시간표 중복 검증이 정상적으로 이루어지지 않아 버그 해결이 어려움
- 크롤링 하여 얻어오는 시간표 데이터가 규칙적이지 않은 문제
- 가독성이 매우 떨어지는 코드

**해결 방안**
- 시간표 중복 검증 클래스 생성
- 재사용 가능한 메소드 사용, 중복 코드 최소화로 가독성 증가
- 2천여개의 시간표 데이터의 케이스 정의, 케이스 별로 시간표 중복 검증 로직을 대응함<br>
  (일반 강의 - 하나의 강의와 하나의 강의실, 강의 시간 1 : 강의실 N, 강의실 1 : 강의 시간 N, 온라인 강의)
- 약 240줄로 개선

### 8. Core Data thread-safe 문제
- 해결해보기!
