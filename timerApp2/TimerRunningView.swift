import SwiftUI

struct TimerRunningView: View {
    @ObservedObject var timerManager: TimerManager
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            // 円形プログレス
            ZStack {
                CircularProgressView(
                    progress: 1.0 - (timerManager.remainingTime / timerManager.totalTime),
                    lineWidth: 12
                )
                .frame(width: 250, height: 250)
                
                VStack(spacing: 8) {
                    Text(timeString(from: timerManager.remainingTime))
                        .font(.system(size: 42, weight: .thin, design: .monospaced))
                        .foregroundColor(.primary)
                    
                    Text(timerManager.isActive ? "実行中" : "一時停止")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            
            // コントロールボタン
            HStack(spacing: 30) {
                Button(action: {
                    timerManager.stopTimer()
                    onBack()
                }) {
                    Text("終了")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.red)
                        .cornerRadius(25)
                }
                
                Button(action: {
                    if timerManager.isActive {
                        timerManager.pauseTimer()
                    } else {
                        timerManager.resumeTimer()
                    }
                }) {
                    Text(timerManager.isActive ? "一時停止" : "再開")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.orange)
                        .cornerRadius(25)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
