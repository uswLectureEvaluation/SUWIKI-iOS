# SUWIKI(2022.01 ~ )
<br>

![image](https://user-images.githubusercontent.com/81678959/182590817-3ffdfe89-cafc-434b-821c-9241d486c322.png)

## 🧑🏻‍💻 수원대학교 공식 시간표 & 강의평가 서비스
- 3,600명의 사용 유저, 다운로드 약 6,700회, 업데이트 16회
- iOS 1인 개발, 디자인 - 기획 참여
- 대량 데이터 저장 속도 약 3초대에서 0.6초 미만으로 개선(약 83%)
- 1,000줄 이상의 스파게티 코드 약 240줄로 개선
- 아키텍처가 없는 구조에서 MVC, 현재는 MVVM + Clean Architecture 적용 진행 중
- 2년간 운영중

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
**1.1 시간표를 강의에 추가하기 어려운 UX**
<img width="622" alt="image" src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/3e520c19-4f28-41fc-9399-9179811c3312">
- 유저는 강의명을 모를 경우 강의를 추가하기 어려운 UX 발생
  
**해결방안**
- 학과를 우선 선택할 수 있도록 UI 수정, 유저의 학과 즐겨찾기 기능 추가
- 강의, 교수명 검색으로 강의 검색 가능. 띄어쓰기 고려한 데이터 필터링 기능 구현

**1.2 HIG에 적합하지 않은 UI/UX**
<img width="474" alt="image" src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/5cca0e9b-d832-4d01-bc76-ea1c3be209b3">
- iOS의 UX와는 동떨어진 UI / UX, 강의 정보 수정의 불필요한 UX 발생

**해결방안**
- 애플의 UX와 유사한 형태로 UI 수정
- 강의 정보 수정 기능 삭제
  
### 2. 리펙토링 및 프로젝트 구조 설계
<img width="602" alt="image" src="https://github.com/uswLectureEvaluation/SUWIKI-iOS/assets/49385546/5fa794ff-e180-4a1c-a15e-5829fd2df909">


### 3. App Group 적용
### 4. 코어데이터 NSBatchInsertRequest를 사용한 성능 개선
### 5. Alamofire serializingDecodable 적용
### 6. Network Layer 설계
### 7. Core Data thread-safe 문제
### 8. 스파게티 코드 리펙토링


## 📱서비스 화면 (일부)

<details>
<summary>살펴보기</summary>
<div markdown="1">

| **시간표** |||
| :---: | :---: | :---: |
| ![시간표](https://velog.velcdn.com/images/sozohoy/post/6ae52c9c-baf0-45ec-b555-e7c328625b47/image.png) | ![](https://velog.velcdn.com/images/sozohoy/post/b7f50284-825a-4be2-ac15-945d3c1b02d7/image.png) | ![](https://velog.velcdn.com/images/sozohoy/post/e0bd5c99-e318-4d3f-a13e-7ed2cf7a7788/image.png) |

| **강의평가 메인** | **강의평가 필터링** | **강의평가 상세보기** |
| :---: | :---: | :---: |
| ![강의평가 메인](https://user-images.githubusercontent.com/49385546/203537086-e4477b92-67df-4344-9704-54f95645f032.gif) | ![강의평가 필터링](https://user-images.githubusercontent.com/49385546/203535149-f4583326-e5cd-43a3-98a0-c2cd59603d91.gif) | ![강의평가 상세보기](https://user-images.githubusercontent.com/49385546/203535036-ffba8e80-e37a-4e3b-a07c-1d6f982dafc2.gif) |

| **강의평가 작성** | **강의평가 검색** | **내 정보** |
| :---: | :---: | :---: |
| ![강의평가 작성](https://user-images.githubusercontent.com/49385546/203535237-24fd2012-e67f-4a8c-8ea6-e7396d313343.gif) | ![강의평가 작성](https://user-images.githubusercontent.com/49385546/203535225-44509bb3-3b4e-4a63-9f39-1f00e40cacb7.gif) | ![내 정보](https://user-images.githubusercontent.com/49385546/203537127-ad26a47f-7260-43d9-a974-0db9ba7860af.gif) |

| **로그인** |||
| :---: | :---: | :---: |
| ![로그인](https://i.ibb.co/drqHwZ4/1.png) | ![](https://i.ibb.co/W3Lk4D6/2.png) | ![](https://i.ibb.co/W3Lk4D6/2.png) |

| **회원가입** |||
| :---: | :---: | :---: |
| ![회원가입](https://user-images.githubusercontent.com/49385546/203537563-f0d11807-74a2-44ef-becd-6ca0899ad5d3.png) | ![](https://user-images.githubusercontent.com/49385546/203537574-d8aec9c1-b6a5-41a1-8542-af8473f2acd7.png) | ![](https://user-images.githubusercontent.com/49385546/203537585-f138b2f7-faae-4982-a66a-c774c12ecf47.png) |
 
<br> 
</div>
</details>

## 📖 사용한 기술

<details>
<summary>살펴보기</summary>
<div markdown="1">

### iOS

- Xcode
- Swift
- UIKit
- Alamofire / SwiftyJSON
- Firebase
- Realm
- Keychain, UserDefaults

### 기능 키워드

- UITableView
- UIScrollView
- UICollectionView
- Delegate
- UITextView
- UITextField
- Network
- UITabBarController
- NotificationCenter

</div>
</details>

## 😭 Problems  

<details>
<summary>살펴보기</summary>
<div markdown="1">

### 1. 종속성 관리

&nbsp;`Realm` 데이터베이스를 이용하여 사용자의 기기에 시간표 데이터들을 저장해놓는 작업을 진행하던 중, 파악하기 어려운 에러가 발생했다. 해당 문제로 아무것도 모르는 채로 2주 이상을 헤맸었다.

![스크린샷 2022-11-23 오후 9 26 10](https://user-images.githubusercontent.com/49385546/203546584-4b7cedff-93fd-48e1-bab7-94883c19c5b5.png)

 &nbsp;몇주간 헤맨 결과 나는 라이브러리를 `Swift Package Manager`과 `CocoaPods` 둘을 이용해 라이브러리들을 설치 하였는데, 
그 부분에서 충돌이 발생했던 것이다. `SwiftPM`을 사용하지 않고 `CocoaPods`로만 라이브러리를 설치했고, 문제는 간단하게 해결 되었다.
<br> &nbsp;문제를 해결할 수 있는 다양한 해결방법들에 대해 고민하게 되었다.<br>

![스크린샷 2022-11-23 오후 9 23 21](https://user-images.githubusercontent.com/49385546/203546016-92b15a7e-376b-443a-b558-de62123c6017.png)
 <br>
https://github.com/realm/realm-swift/issues/7643

### 2. 네트워크, API 주소 관리
&nbsp;완성된 프로젝트 에서는 API 주소를 매번 컨트롤러 내부에서 선언하고 있다. 
<br> &nbsp;새로 하게된 프로젝트에서는 API 주소를 관리하도록 `enum`을 사용했고, API URL을 따로 관리하게 되니 훨씬 편리하고 컨트롤러에서의 코드도 줄었다.<br>
https://github.com/Usw-SUGO/iOS

### 3. 아키텍쳐 패턴의 중요성
&nbsp;첫 개발이었기에 아키텍쳐 패턴의 존재를 모르고 있었다. 최근에 시간표 부분에서의 버그가 존재하여 버그를 찾으려 해봤지만 수백 ~ 길면 수천줄의 코드가 지저분하게 나열된 덕분에 어느 부분에서의 문제인지 판단이 서지 않았다.
<br>&nbsp;이후에 MVC 패턴을 적용시키려고 나름 애를 썼지만 많은 부분이 `Controller`에서 진행되고 있다. 이러한 문제를 겪고 아키텍쳐 패턴의 중요성을 깨닫고 마찬가지로 **SUGO** 프로젝트에서 MVC 패턴을 사용하게 되었고, 다양한 패턴들에 대해 공부를 진행하게 되었다. 설계의 중요성을 깨달았다.

### 4. 토큰 재발급
&nbsp;수위키는 자동로그인을 지원하고 있는데, 자동로그인을 위해서는 토큰을 인터셉트한 후 유효성 검사를 마친 뒤 <br>
재발급을 해주어야 했다. 다양한 키워드들을 수집하고 적용하여 해결하게 되었다.
<br>&nbsp;`Alamofire`에서 제공하는 `RequestIntercepter` 프로토콜을 이용, `adapt`, `retry` 메소드를 활용하여 인터셉터를 적용하였다.
https://sozohoy.tistory.com/25
<br>

 <img width="796" alt="스크린샷 2022-11-23 오후 10 21 46" src="https://user-images.githubusercontent.com/49385546/203557987-5107a17a-6b1e-4226-9357-5bc4184946a6.png">
 
### 이외에도...
&nbsp;기술적인 문제들은 많다. 엉망이고 효율적이지 않은 코드들을 리펙토링할 수 없는 지경이기에, 2023년 상반기에 시간표 부분을 전체적으로 재구현 할 예정이다.<br>(현 상황에선 리펙토링이 불가하다고 판단.) 마무리 되는대로 강의평가 부분도 리펙토링을 진행할 예정이다.
</div>
</details>
