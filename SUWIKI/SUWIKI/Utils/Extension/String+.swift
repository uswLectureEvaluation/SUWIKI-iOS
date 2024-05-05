//
//  String+.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

extension String {
    public func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: self)
    }

    public func formatDate(to: String = "yyyy.MM.dd") -> String {
        if let date = self.stringToDate() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = to
            return dateFormatter.string(from: date)
        }
        return "2023.04.17"
    }

    public func isIdVaild() -> Bool {
        let idregex = "^[a-zA-Z0-9]{6,20}$"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idregex)
        return idTest.evaluate(with: self)
    }

    public func isPasswordVaild() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }

    public func isEmailVaild() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@suwon\\.ac\\.kr"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
