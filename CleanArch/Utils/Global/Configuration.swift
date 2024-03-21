import Foundation


struct Configuration {
    static let shared = Configuration();
    
    var appURL: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "APP_URL") as! String
        }
    }
    
    var appName: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "APP_DISPLAY_NAME") as! String
        }
    }
    
    var versionCode: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "VERSION_CODE") as! String
        }
    }
    
    var versionName: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "VERSION_NAME") as! String
        }
    }
    
    var awsConfigURL: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "APP_CONFIG_AWS_URL") as! String
        }
    }
    
    var apiVersion: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "API_VERSION") as! String
        }
    }
    
    var bundleIdentifier: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "BUNDLE_IDENTIFIER") as! String
        }
    }
    
}
