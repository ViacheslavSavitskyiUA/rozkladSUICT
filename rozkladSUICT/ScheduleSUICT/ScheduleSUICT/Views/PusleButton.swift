//
//  PusleButton.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2024.
//

import SwiftUI

// MARK: - Strucutre for Circle
struct CircleData: Hashable {
    let width: CGFloat
    let opacity: Double
}

struct PJRPulseButton: View {
    
    // MARK: - Properties
    @State private var isAnimating: Bool = false

    var action: ()->()
    var buttonWidth: CGFloat
    var numberOfOuterCircles: Int
    var animationDuration: Double
    var circleArray = [CircleData]()


    init(action: @escaping ()->(), buttonWidth: CGFloat = 48, numberOfOuterCircles: Int = 3, animationDuration: Double  = 1) {
        self.action = action
        self.buttonWidth = buttonWidth
        self.numberOfOuterCircles = numberOfOuterCircles
        self.animationDuration = animationDuration
        
        var circleWidth = self.buttonWidth
        var opacity = (numberOfOuterCircles > 4) ? 0.40 : 0.20
        
        for _ in 0..<numberOfOuterCircles{
            circleWidth += 16
            self.circleArray.append(CircleData(width: circleWidth, opacity: opacity))
            opacity -= 0.05
        }
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            Group {
                ForEach(circleArray, id: \.self) { cirlce in
                    Circle()
                        .fill(Color.red)
                        .opacity(self.isAnimating ? cirlce.opacity : 0)
                        .frame(width: cirlce.width, height: cirlce.width)
                        .scaleEffect(self.isAnimating ? 1 : 0)
                }
                
            }
            .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true),
               value: self.isAnimating)

            Button(action: {
                action()
            }) {
                Text("🎁")
                    .font(.system(size: 24))
                    .foregroundStyle(Color.red)
                    .frame(width: 50, height: 50)
                    .background(Color.init(hex: "ea4335"), in: .circle)
                    .contentShape(.circle)
//                    .padding([.bottom, .trailing], 12)
                
            }
            .onAppear(perform: {
                self.isAnimating.toggle()
            })
        } //: ZSTACK
    }

}

//// MARK: - Preview
//struct PulseButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PJRPulseButton(action: <#() -> ()#>)
//    }
//}
