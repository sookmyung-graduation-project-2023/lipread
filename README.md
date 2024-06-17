## 🦻🏻 프로젝트 소개
> 청각장애인을 위한 구어 학습 서비스

청각 장애인들이 실생활에서 자주 쓰이는 문장을 중심으로 구어를 학습할 수 있는 서비스 입니다.   
LipRead는 AI를 통해 제작된 대화 영상을 통해 청각장애인들의 독화 훈련과 청능 훈련을 도와 다양한 상황에서 의사소통을 원활히 할 수 있도록 도움을 주고자 합니다. 

## 기능 구현
앱의 주요 기능은 ‘구어 학습하기’, ‘구어 학습용 대화 생성하기’, ‘학습 기록 확인하기’로 구성된다.
사용자는 먼저 구글 소셜 로그인을 통해 앱에 접속한다.
 
#### [소셜 로그인 화면]
![Frame 2609125](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/98d29bd8-591e-45a1-adbd-f174551bbb9f)

### 1. 구어 학습하기
사용자는 일상 생활 속 대화 주제 중에서 학습하고 싶은 주제를 선택해 해당 상황에서 사용할 수 있는 유용한 문장으로 구어를 연습한다. 일상 대화 주제는 ‘음식점’, ‘교통’, ‘쇼핑’, ‘의료’, ‘여행’, ‘영화관’, ‘학교’, ‘미용실’, ‘은행’, ‘친목’, ‘인간관계’, ‘학원’ 총 12가지 카테고리로 분류되어 있으며, 필요에 따라 원하는 카테고리에 해당하는 주제만 필터링해서 볼 수도 있다. 

#### [(왼)메인 화면, (우)일상 대화 주제의 카테고리 분류]
![Frame 2609126](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/60116958-aa7f-470e-99cb-17bc1cc5670f)
사용자가 대화 주제를 선택하면 해당 주제에 대한 상세 설명과 대화에 참여하는 두 인물에 대한 역할 정보를 확인할 수 있다. 이미 학습을 진행한 상태면 ‘학습 평균 정답률’, ‘누적 학습 시간’, ‘누적 학습 시간’, ‘가장 많이 틀린 문장’ 등 학습 통계 기록을 하단에서 확인할 수 있다.
 
#### [학습 콘텐츠 상세 설명 화면]
![Frame 2609127](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/4e72cc2b-fa22-4276-8bf8-03f1c0a21809)

화면에서 학습 시작을 누르면 청각장애인은 두 사람이 번갈아 등장하며 말하는 영상을 시청하면서 구어를 학습한다.
그림0은 대화 영상을 시청하며 구어를 학습하는 과정을 요약한 순서도다. 사용자는 영상을 시청하면서 영상 속 인물의 입술 움직임을 관찰하거나 잔존 청력을 통해 영상의 내용을 유추한 뒤 정답이라고 생각하는 문장을 녹음한다. 이후 자신이 녹음한 내용을 정답과 비교하며 틀린 부분을 확인하며 이 과정을 반복한다. 학습 완료되면 상단의 학습 종료 버튼을 눌러 학습을 종료한 뒤 학습 통계를 확인할 수 있다.
 
#### [학습 과정 화면]
![Frame 2609135](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/be3b5a15-d8d3-4611-bbe9-33d1da3763bb)
(영상은 모자이크 됨)

### 2. 구어 학습용 대화 생성하기
사용자는 자신이 원하는 주제로 학습용 대화 영상을 생성할 수 있다. 이를 위해 2가지 방법이 제공된다. 하나는 최근에 학습한 일상 대화 주제와 유사한 주제로 영상을 생성하는 방법이고, 다른 하나는 완전히 새로운 학습용 주제로 영상을 생성하는 방법이다.
 ### [사용자 맞춤형 대화 영상 생성 화면]
 ![Frame 2609124](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/998cbde6-00e1-4b64-bb75-fa715c7e2d53)
 
### 2-1. 최근 학습 주제로 생성
#### [최근 학습 주제로 대화 주제 생성 과정 화면]
![Frame 2609123](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/c6c66450-e0c0-43d7-b286-ae7c64fdd36b)
사용자는 최근 학습한 주제 중 추가로 학습을 해보고 싶은 단어나 문장을 입력해 새로운 대화 영상을 생성하고 학습을 할 수 있다.

### 2-2. 새로운 대화 주제로 생성
#### [새로운 대화 주제 생성 과정 화면]
![Frame 2609132](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/6a6adce5-b8c8-4be8-945d-0224b7cff149)
사용자는 새로운 일상 대화 주제를 입력해 학습용 대화 영상을 생성할 수도 있다. 이때는 대화 상황, 대화 속 등장하는 두 인물에 대한 역할 정보, 추가 학습 단어 등의 정보를 제공한 뒤에 사용자 맞춤형 대화 주제를 생성할 수 있다. 영상 속에 등장하는 인물은 ‘남성’, ‘여성’, ‘중년 남성’, ‘중년 여성’ 중에 한 명을 선택할 수 있으며, 선택지에 따라 영상 생성할 때 사용하는 이미지를 다르게 선택하고 인물에 맞는 서로 다른 음성을 사용한다. 각 인물에 따른 음성은 ‘남성’, ‘여성’, ‘중년 남성’, ‘중년 여성’ 순으로 OpenAI TTS의 echo, nova, onyx, alloy를 사용한다. 

### 3. 학습 기록 살피기
#### [학습 통계 화면]
![Frame 73](https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/9635cab6-2921-4312-a30e-9ff3dc396518)
사용자는 학습을 완료할 때마다 학습 기록을 캘린더에서 확인할 수 있다. 세부적인 학습 기록을 살필 때는 학습 통계 정보와 학습 중 틀린 문장을 확인할 수 있다. 

# 발표 자료
 <img width="1920" alt="1" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/f9f26836-97a3-401c-8cec-828e5ca508fa">
<img width="1920" alt="2" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/6c15e752-c27c-43b6-bbc3-b9920be153ca">
<img width="1920" alt="3" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/3b38e8c2-6fb2-4b7a-83e6-5fe5238985ff">
<img width="1920" alt="4" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/b7f3417a-c838-4e84-a636-dc44ebf62b7e">
<img width="1920" alt="5" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/057e2333-840d-4212-88c8-5d1f62530ee8">
<img width="1920" alt="6" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/609a2569-9020-4d51-badd-f042a25a062a">
<img width="1920" alt="7" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/99af298c-43b4-4a93-9251-2fa898159325">
<img width="1920" alt="8" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/74bc7a9c-2cec-45b8-871a-da0e2ac2be0b">
<img width="1920" alt="9" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/809509a3-b326-4db4-8f60-eb2396ba23d3">
<img width="1920" alt="10" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/8b26b67d-a96c-4915-900f-889362ca93ac">
<img width="1920" alt="11" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/72fa9dd9-d8cb-4f07-a3e4-92cfdc3f8522">
<img width="1920" alt="12" src="https://github.com/sookmyung-graduation-project-2023/lipread/assets/40076944/81cea73e-2679-4981-a93d-342a09717ed6">
