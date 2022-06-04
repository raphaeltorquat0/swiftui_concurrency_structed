import SwiftUI

struct MarsProgressView: View {
    @State var degressY: Double = -92
    @State var offsetX: Double = -30
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color.accentColor, lineWidth: 2)
                    .frame(width: 60, height: 60)
                    .background {
                        EllipticalGradient(colors: [Color.accentColor.opacity(0.2), Color.accentColor], center: UnitPoint(x: 0.2, y: 0.5), startRadiusFraction: 0.4, endRadiusFraction: 0.9
                        )
                        .clipShape(Circle())
                    }
                Circle()
                    .fill(Color.accentColor.opacity(0.5))
                    .frame(width: 12, height: 12)
                    .rotation3DEffect(
                        .degrees(degressY),
                        axis: (x:0, y:1, z:0),
                        anchor: UnitPoint.init(x: 0.5, y: 0.5)
                    )
                    .offset(x: offsetX, y: -8)
                Circle()
                    .fill(Color.accentColor.opacity(0.2))
                    .frame(width: 4, height: 4)
                    .rotation3DEffect(
                    .degrees(degressY),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: UnitPoint.init(x: 0.5, y: 0.5)
                    )
                    .offset(x: offsetX - 6, y:2)
                Circle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(width: 6, height: 6)
                    .rotation3DEffect(
                    .degrees(degressY + 2),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: UnitPoint.init(x: 0.5, y: 0.5)
                    )
                    .offset(x: offsetX + 4, y:5)
            }
            Text("Loading...")
                .foregroundColor(Color.accentColor)
                .padding()
            Spacer()
        }
        .task {
            withAnimation(.linear(duration:2).repeatForever(autoreverses:false)) {
                degressY = 90
                offsetX = 30
            }
        }
    }
}

struct MarsProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MarsProgressView()
    }
}
