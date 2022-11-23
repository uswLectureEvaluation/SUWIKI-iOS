# SUWIKI(2022.01 ~ )
<br>

![image](https://user-images.githubusercontent.com/81678959/182590817-3ffdfe89-cafc-434b-821c-9241d486c322.png)

## 🧑🏻‍💻 수원대학교 시간표 & 강의평가 서비스

<br>

### 개발 동기
- 대학생 전용 시간표 앱(에브리타임)에서 더 이상 재학 중인 학교의 시간표 & 강의평가 기능을 서비스해주지 않음.
- Swift로 개발하게 된 첫번째 앱, 첫번째 프로젝트

<br>

## 📱서비스 화면 (일부)

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

## 📜 사용한 기술

### iOS

- Xcode
- Swift
- UIKit
- Alamofire / SwiftyJSON
- Firebase
- Realm
- Keychain, UserDefaults

<br>

## Problems 

### 1. 종속성 관리

&nbsp;처음 `Swift`를 접하고 바로 프로젝트를 진행해서 내 실력을 키우자고 마음 먹었기에, 아무런 기초도 없이 프로젝트를 진행했다.
<br> &nbsp;Realm 데이터베이스를 이용하여 사용자의 기기에 시간표 데이터들을 저장해놓는 작업을 진행하던 중, 파악하기 어려운 에러가 발생했다. 해당 문제로 아무것도 모르는 채로 2주 이상을 헤맸었다.

![스크린샷 2022-11-23 오후 9 26 10](https://user-images.githubusercontent.com/49385546/203546584-4b7cedff-93fd-48e1-bab7-94883c19c5b5.png)

 &nbsp; 몇주간 헤맨 결과 나는 라이브러리를 `Swift Package Manager`과 `CocoaPods` 둘을 이용해 라이브러리들을 설치 하였는데, 
그 부분에서 충돌이 발생했던 것이다. `SwiftPM`을 사용하지 않고 `CocoaPods`로만 라이브러리를 설치했고, 문제는 간단하게 해결 되었다.
<br> &nbsp; 첫번째 고비를 맞이하면서 다양하게 문제를 해결해보려고 노력을 많이 했다. 덕분에 웬만한 문제는 해결할 수 있을 것이라는 자신감을 갖게 되었다.
![스크린샷 2022-11-23 오후 9 23 21](https://user-images.githubusercontent.com/49385546/203546016-92b15a7e-376b-443a-b558-de62123c6017.png)
 <br>
https://github.com/realm/realm-swift/issues/7643

### 2. 네트워크, API 주소 관리
&nbsp; 완성된 프로젝트 에서는 API 주소를 매번 컨트롤러 내부에서 선언하고 있다. 코드를 효율적으로 사용하지 못하며, 안전하지도 않은 방법이라고 생각하게 되었다. 
<br> &nbsp;기존에 있는 프로젝트에서는 아직 리펙토링은 되어있지 않은 상황이고 새로 하게된 프로젝트(**SUGO**)에서는 API 주소를 관리하도록 `enum`을 사용했고, API URL을 따로 관리하게 되니 훨씬 편리하고 컨트롤러에서의 코드도 줄었다.

### 3. 아키텍쳐 패턴의 중요성
&nbsp;프로젝트를 진행할 때 먼저 시간표 어플리케이션을 목표로 개발을 진행했다. 아무것도 모르는 상황이었기에 일단 개발을 진행하였고, 덕분에 리펙토링을 할 수 없을정도의 지저분한 코드들이 완성되었다. 최근에 시간표 부분에서의 버그가 존재하여 버그를 찾으려 해봤지만 수백 ~ 길면 수천줄의 코드가 지저분하게 나열된 덕분에 어느 부분에서의 문제인지 판단이 서지 않았다.
<br>&nbsp;이후에 MVC 패턴을 적용시키려고 나름 애를 썼지만 많은 부분이 `Controller`에서 진행되고 있다. 이러한 문제를 겪고 아키텍쳐 패턴의 중요성을 깨닫고 마찬가지로 **SUGO** 프로젝트에서 MVC 패턴을 사용하게 되었고, 다양한 패턴들에 대해 공부를 진행하게 되었다. 설계의 중요성을 깨닫게 되었다.

### 4. 토큰 재발급
&nbsp;수위키는 자동로그인을 지원하고 있는데, 자동로그인을 위해서는 토큰을 인터셉트한 후 유효성 검사를 마친 뒤 <br>
재발급을 해주어야 했다. 하지만 어떻게 하는지 알리가 없었고 다양한 경로로 정보들을 수집했다.


 
