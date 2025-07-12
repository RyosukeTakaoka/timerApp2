import Foundation
import ActivityKit
import Combine

class TimerManager: ObservableObject {
    @Published var remainingTime: TimeInterval = 0
    @Published var totalTime: TimeInterval = 0
    @Published var isActive: Bool = false
    @Published var isPaused: Bool = false
    
    private var timer: Timer?
    private var activity: Activity<TimerAttributes>?
    
    func startTimer(minutes: Int, seconds: Int) {
        let totalSeconds = TimeInterval(minutes * 60 + seconds)
        totalTime = totalSeconds
        remainingTime = totalSeconds
        isActive = true
        isPaused = false
        
        // Live Activity開始
        startLiveActivity()
        
        // タイマー開始
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func pauseTimer() {
        isActive = false
        isPaused = true
        timer?.invalidate()
        timer = nil
        updateLiveActivity()
    }
    
    func resumeTimer() {
        isActive = true
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
        updateLiveActivity()
    }
    
    func stopTimer() {
        isActive = false
        isPaused = false
        timer?.invalidate()
        timer = nil
        remainingTime = 0
        endLiveActivity()
    }
    
    private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateLiveActivity()
        } else {
            // タイマー終了
            stopTimer()
        }
    }
    
    private func startLiveActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled")
            return
        }
        
        let attributes = TimerAttributes(timerName: "集中する")
        let contentState = TimerAttributes.ContentState(
            remainingTime: remainingTime,
            totalTime: totalTime,
            isActive: isActive
        )
        
        do {
            activity = try Activity<TimerAttributes>.request(
                attributes: attributes,
                contentState: contentState,
                pushType: nil
            )
            print("Live Activity started successfully")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
    
    private func updateLiveActivity() {
        guard let activity = activity else { return }
        
        let contentState = TimerAttributes.ContentState(
            remainingTime: remainingTime,
            totalTime: totalTime,
            isActive: isActive
        )
        
        Task {
            do {
                await activity.update(using: contentState)
            } catch {
                print("Failed to update Live Activity: \(error)")
            }
        }
    }
    
    private func endLiveActivity() {
        guard let activity = activity else { return }
        
        Task {
            do {
                await activity.end(dismissalPolicy: .immediate)
                print("Live Activity ended successfully")
            } catch {
                print("Failed to end Live Activity: \(error)")
            }
        }
        self.activity = nil
    }
}
