//
//  File.swift
//  
//
//  Created by 한지석 on 4/16/24.
//

import Foundation

class KeychainManager {

    static let shared = KeychainManager()
    let service = "com.sozohoy.uswTimeTable"

    private init() { }

    func create(
        token: TokenType,
        value: String
    ) {
        /// Keychain Query
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: token.account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]

        /// Keychain의 Key값에 중복이 생길경우 저장할 수 없으므로 기존의 것을 삭제
        SecItemDelete(keychainQuery)

        /// 생성
        let status: OSStatus = SecItemAdd(keychainQuery, nil)
        assert(status == noErr, "@Log - Failed to save token")
    }

    func read(
        token: TokenType
    ) -> String? {

        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: token.account,
            /// CFData로 불러오는 것
            kSecReturnData: true,
            /// 중복되는 경우 하나의 값만 가져오게 하도록
            kSecMatchLimit: kSecMatchLimitOne
        ]

        /// CFData -> AnyObject -> Data
        var cfDataToAnyObject: AnyObject?
        let status = SecItemCopyMatching(keychainQuery,
                                         &cfDataToAnyObject)

        if status == errSecSuccess {
            let retrievedData = cfDataToAnyObject as! Data
            let value = String(data: retrievedData, encoding: .utf8)
            return value
        } else {
            print("@Log - Failed to read token - status code == \(status)")
            return nil
        }
    }

    func delete(
        token: TokenType
    ) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: token.account
        ]

        let status = SecItemDelete(keychainQuery)
        assert(status == noErr, "@Log - Failed to delete token")
    }

}
