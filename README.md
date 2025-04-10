<aside>


**스케쥴 관리 앱.**

일정 관리에 필요한 다양한 기능을 직관적인 인터페이스로 제공하며, 로컬 데이터 저장소를 통해 오프라인 환경에서도 안정적으로 동작하는 앱입니다.

MVVM(Model-View-ViewModel) 패턴을 적용해 UI(View)와 비즈니스 로직(ViewModel)을 명확히 분리하여, 유지보수성과 확장성을 높였습니다.

## 핵심 기능 ✨

✅ **일정 추가 및 수정 기능**

✅ **일정 확인 (Calendar 뷰)**

✅ **로컬 환경에서 동작**

> **💻 사용된 패키지 및 사용 이유**
> 
- 💡 **Hive**
    
    데이터를 로컬에 영구적으로 저장하기 위해 사용됩니다. 일정 정보와 사용자 설정을 보관하며, 빠르고 가벼운 NoSQL DB로 오프라인 환경에서도 원활히 작동합니다.
    
- 💡 **flutter_riverpod**
    
    MVVM 패턴에서 ViewModel의 상태를 관리하고, View와의 연결을 돕기 위해 사용됩니다.
    
    위젯 전체의 재빌드를 최소화하여, 데이터 변경 시 필요한 부분만 효율적으로 업데이트할 수 있습니다.
    
- 💡 **build_runner / freezed / json_serializable**
    
    코드 생성 및 빌드 도구로, 불변 데이터 클래스, JSON 직렬화/역직렬화 로직 등을 자동화합니다.
    
    프로젝트 규모가 커질수록 모델 관리가 복잡해지는데, 이를 자동으로 처리하여 유지보수성을 높입니다.
    
</aside>
