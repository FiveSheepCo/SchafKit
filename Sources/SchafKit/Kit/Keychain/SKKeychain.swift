import Foundation

public class SKKeychain {
    
    /// Sets a specified value for a key id and returns whether the operation was successful.
    public static func set(password : String, for id : String) -> Bool {
        let addquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrAccount as String: id,
                                       kSecValueData as String: password.data(using: .utf8)!]
        
        SecItemDelete(addquery as CFDictionary)
        
        if password.isEmpty {
            return true
        }
        
        let status = SecItemAdd(addquery as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// Gets a specified value for a key id and returns it if successful.
    public static func getPassword(for id : String) -> String? {
        let getquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrAccount as String: id,
                                       kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getquery as CFDictionary, &item)
        guard status == errSecSuccess, let passwordData = item as? Data else {
            return nil
        }
        return String(data: passwordData, encoding: .utf8)
    }
}
