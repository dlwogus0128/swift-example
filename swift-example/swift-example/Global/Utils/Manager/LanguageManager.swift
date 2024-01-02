//
//  LanguageManager.swift
//  swift-example
//
//  Created by 픽셀로 on 2024/01/02.
//

import Foundation

@frozen
enum LanguageType {
    case ko // 한국어
    case en // 영어
}

final class LanguageManager: NSObject {
    
    // MARK: - Properties
    
    static let shared = LanguageManager()
    
    // MARK: - initializer
    
    override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    /// 현재의 언어 설정 상태의 코드를 string 값으로 return 해주는 함수입니다.
    func getCurrentLanguageCodeAsString() -> String {
        let language = Locale.current.languageCode!
        let index = language.index(language.startIndex, offsetBy: 2)
        let languageCode = String(language[..<index])
        return languageCode
    }
    
    /// 기기 설정 언어에 따른 번들을 가져오는 함수입니다.
    func setBundle() -> Bundle {
        let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String
        let index = language.index(language.startIndex, offsetBy: 2)
        let languageCode = String(language[..<index]) // "ko", "en" 등
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        guard let bundle = Bundle(path: path!) else { return Bundle() }
        return bundle
    }
    
    /// 언어 타입과 key 값을 입력하면, 해당하는 string 값을 return 합니다. VC에서 Bundle 선언 이후 호출합니다.
    func setTextWithLanguage(bundle: Bundle, forKey: String) -> String {
      return bundle.localizedString(forKey: forKey, value: nil, table: nil)
    }
    
    /// 언어 변경 시
    func changeLanguage(languageType: LanguageType) {
        var languageCode = String()
        
        switch languageType {
        case .ko:
            languageCode = "ko"
        case .en:
            languageCode = "en"
        }
        
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
