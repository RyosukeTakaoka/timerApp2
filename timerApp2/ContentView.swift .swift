import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @State private var selectedMinutes = 25
    @State private var selectedSeconds = 0
    @State private var showingTimer = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                if showingTimer {
                    // タイマー実行画面
                    TimerRunningView(
                        timerManager: timerManager,
                        onBack: { showingTimer = false }
                    )
                } else {
                    // タイマー設定画面
                    TimerSetupView(
                        selectedMinutes: $selectedMinutes,
                        selectedSeconds: $selectedSeconds,
                        onStart: {
                            timerManager.startTimer(minutes: selectedMinutes, seconds: selectedSeconds)
                            showingTimer = true
                        }
                    )
                }
            }
            .navigationTitle("集中する")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
