import SwiftUI

struct TimerSetupView: View {
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int
    let onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            // 時間表示
            Text(timeString(minutes: selectedMinutes, seconds: selectedSeconds))
                .font(.system(size: 48, weight: .thin, design: .monospaced))
                .foregroundColor(.primary)
            
            // 時間選択ピッカー
            TimePickerView(
                selectedMinutes: $selectedMinutes,
                selectedSeconds: $selectedSeconds
            )
            
            Spacer()
            
            // 開始ボタン
            Button(action: onStart) {
                Text("開始")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.orange)
                    .cornerRadius(25)
            }
            .disabled(selectedMinutes == 0 && selectedSeconds == 0)
            .opacity(selectedMinutes == 0 && selectedSeconds == 0 ? 0.6 : 1.0)
            .padding(.horizontal, 40)
        }
        .padding()
    }
    
    private func timeString(minutes: Int, seconds: Int) -> String {
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
