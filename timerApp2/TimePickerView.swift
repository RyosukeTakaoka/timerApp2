import SwiftUI

struct TimePickerView: View {
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // 分のピッカー
                Picker("分", selection: $selectedMinutes) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)")
                            .tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geometry.size.width * 0.3)
                .clipped()
                
                Text("分")
                    .font(.title2)
                    .frame(width: geometry.size.width * 0.1)
                
                // 秒のピッカー
                Picker("秒", selection: $selectedSeconds) {
                    ForEach(0..<60, id: \.self) { second in
                        Text("\(second)")
                            .tag(second)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geometry.size.width * 0.3)
                .clipped()
                
                Text("秒")
                    .font(.title2)
                    .frame(width: geometry.size.width * 0.1)
            }
        }
        .frame(height: 200)
    }
}
