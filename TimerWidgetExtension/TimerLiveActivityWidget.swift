import SwiftUI

struct TimerLiveActivityView: View {
    let remainingTime: TimeInterval
    let totalTime: TimeInterval
    let isActive: Bool
    let timerName: String
    
    var body: some View {
        HStack(spacing: 16) {
            // 円形プログレス
            CircularProgressView(
                progress: 1.0 - (remainingTime / totalTime),
                lineWidth: 8
            )
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(timerName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(timeString(from: remainingTime))
                    .font(.title2)
                    .fontWeight(.medium)
                    .monospacedDigit()
                    .foregroundColor(.orange)
                
                if isActive {
                    Text("実行中")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("一時停止")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
