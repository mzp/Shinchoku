import Foundation

extension NSDate {
    private var components: NSDateComponents {
        return NSCalendar.currentCalendar().components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: self)
    }

    var year: Int {
        return components.year
    }

    var month: Int {
        return components.month
    }

    var day: Int {
        return components.day
    }

    var weekday: Int {
        return components.weekday
    }

    var hour: Int {
        return components.hour
    }

    var minute: Int {
        return components.minute
    }

    var second: Int {
        return components.second
    }

    class func create(year year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> NSDate? {
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second

        return NSCalendar.currentCalendar().dateFromComponents(components)
    }
}