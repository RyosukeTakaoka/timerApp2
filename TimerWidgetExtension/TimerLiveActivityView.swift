import ActivityKit
import WidgetKit
import SwiftUI

struct TimerLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock screen/banner UI
            TimerLiveActivityView(
                remainingTime: context.state.remainingTime,
                totalTime: context.state.totalTime,
                isActive: context.state.isActive,
                timerName: context.attributes.timerName
            )
            .padding()
            .background(Color(.systemBackground))
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading) {
                        Text("Timer")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(context.attributes.timerName)
                            .font(.headline)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timeString(from: context.state.remainingTime))
                        .font(.title2)
                        .fontWeight(.medium)
                        .monospacedDigit()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    CircularProgressView(
                        progress: 1.0 - (context.state.remainingTime / context.state.totalTime),
                        lineWidth: 4
                    )
                    .frame(width: 80, height: 80)
                }
            } compactLeading: {
                Image(systemName: "timer")
                    .foregroundColor(.orange)
            } compactTrailing: {
                Text(timeString(from: context.state.remainingTime))
                    .font(.caption)
                    .monospacedDigit()
            } minimal: {
                Image(systemName: "timer")
                    .foregroundColor(.orange)
            }
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

