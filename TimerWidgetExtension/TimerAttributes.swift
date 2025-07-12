import Foundation
import ActivityKit

struct TimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        let remainingTime: TimeInterval
        let totalTime: TimeInterval
        let isActive: Bool
    }
    
    let timerName: String
}
