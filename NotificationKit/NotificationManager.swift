import Foundation
import UserNotifications

public class NotificationManager {
    public static let shared = NotificationManager()
    
    private init() {}
    
    public func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            completion(granted, error)
        }
    }
    
    public func handleResponseNotification(userInfo: [AnyHashable: Any]) -> NotificationResponseModel? {
        // JSON verisini NotificationPayload modeline dönüştürme işlemi
        guard let data = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else {
            return nil
        }
        
        return try? JSONDecoder().decode(NotificationResponseModel.self, from: data)
    }
}
