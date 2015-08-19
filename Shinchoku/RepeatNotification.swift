import Foundation
import UIKit

// 毎時n分に「進捗どうですか」というLocalNotificationを送る
class RepeatNotification {
    static let CategoryName = "shinchoku"

    static func requestPermission() {
        let category = UIMutableUserNotificationCategory()
        category.identifier = CategoryName

        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert], categories: Set([category]))
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }

    private let minute : Int

    init(minute : Int){
        self.minute = minute
    }

    func register(){
        // 重複して通知されるのを避けるために、過去に登録ずみのをクリアしておく。
        UIApplication.sharedApplication().cancelAllLocalNotifications()

        let notification = UILocalNotification()
        notification.timeZone = NSTimeZone.systemTimeZone()
        notification.fireDate = nextTime()
        notification.alertBody = "進捗どうですか"
        notification.alertTitle = "進捗どうですか"
        notification.category = RepeatNotification.CategoryName
        notification.repeatInterval = .Hour
        notification.soundName = UILocalNotificationDefaultSoundName;
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    // 次に通知する時刻を取得する
    private func nextTime() -> NSDate {
        let now = NSDate()
        let date = NSDate.create(year: now.year, month: now.month, day: now.day, hour: now.hour, minute: now.minute, second: 0)

        if date!.timeIntervalSinceNow > 0 {
            return date!
        } else {
            return NSDate.create(year: now.year, month: now.month, day: now.day, hour: now.hour+1, minute: minute, second: 0)!
        }
    }
}