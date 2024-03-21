import Foundation
import CryptoSwift


func localized(_ key: String, _ table: String, _ value: String) -> String {
    if let path = Bundle.main.path(forResource: LocalStorage.shared.appLanguage!.rawValue, ofType: "lproj"), let bundle = Bundle(path: path) {
        return NSLocalizedString(key, bundle: bundle, comment: value)
    }
    
    return value
}

extension String {
    func toDic() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                return json
            } catch {
                print("Error while parse to Dic: \(error)")
            }
        }
        return nil
    }
    
    func toBase64Encoded() -> Data? {
        guard let result = Data(base64Encoded: Data(self.utf8).base64EncodedString()) else { return nil }
        return result
    }
    
    func aesDecrypt(password: String) -> String? {
        do {
            guard let keyBase64 = password.toBase64Encoded() else { return nil }
            
            let byeArray = [UInt8](keyBase64)
            
            let aes = try AES(key: byeArray, blockMode: ECB(), padding: .pkcs7)
            let decrypted = try aes.decrypt(Array(base64: self))
            
            return String(data: Data(decrypted), encoding: .utf8)
        } catch {
            return nil
        }
    }
}
