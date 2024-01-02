//
//  LocalizationVC.swift
//  swift-example
//
//  Created by 픽셀로 on 2024/01/02.
//

import UIKit

final class LocalizationVC: UIViewController {
    
    // MARK: - Properties
    
    private let bundle = LanguageManager.shared.setBundle()
    private let languageManager = LanguageManager.shared
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(languageManager.setTextWithLanguage(bundle: bundle, forKey: LanguageLiterals.niceToMeetYou))
    }
}
