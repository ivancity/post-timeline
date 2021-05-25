import Foundation

extension String {
    func getAppDateFormatted() -> String {
        let incomingDateFormat = DateFormatter()
        incomingDateFormat.calendar = Calendar(identifier: .iso8601)
        incomingDateFormat.locale = Locale(identifier: "en_US_POSIX")
        incomingDateFormat.dateFormat = "E MMM dd yyyy HH:mm:ss 'GMT'Z"
        guard let resultDate = incomingDateFormat.date(from: self) else {
            return self
        }
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: resultDate)
        let day = calendarDate.day
        let outputDateFormat = DateFormatter()
        outputDateFormat.dateFormat = "MMM"
        let monthString = outputDateFormat.string(from: resultDate)
        let dayString = day!.ordinal
        return "\(monthString) \(dayString)"
    }
}
