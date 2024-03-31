import SwiftUI

struct EllipticCurveGraphView: View {
    let curve: EllipticCurve
    @State private var showPointAddition = false
    @State private var showScalarMultiplication = false
    @State private var pointAdditionResult = ""
    @State private var scalarMultiplicationResult = ""
    @State private var x1Input = ""
    @State private var y1Input = ""
    @State private var x2Input = ""
    @State private var y2Input = ""
    @State private var kInput = ""
    
    var body: some View {
        VStack {
            Text("Elliptic Curve Graph").font(.title)
            
            EllipticCurvePlot(curve: curve)
                .frame(width: 300, height: 300)
                .border(Color.black)
            
            Button(action: {
                self.showPointAddition.toggle()
            }) {
                Text("Perform Point Addition")
            }.padding()
            
            Button(action: {
                self.showScalarMultiplication.toggle()
            }) {
                Text("Perform Scalar Multiplication")
            }.padding()
        }
        .sheet(isPresented: $showPointAddition) {
            PointAdditionView(curve: curve, result: $pointAdditionResult)
        }
        .sheet(isPresented: $showScalarMultiplication) {
            ScalarMultiplicationView(curve: curve, result: $scalarMultiplicationResult)
        }
    }
}

struct EllipticCurvePlot: View {
    let curve: EllipticCurve
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                // Plot points on the curve within the bounds of the geometry
                for x in 0..<Int(geometry.size.width) {
                    let ySquared = (x * x * x + curve.a * x + curve.b) % curve.p
                    let y = Int(sqrt(Double(ySquared)))
                    
                    // Plot point (x, y)
                    path.addEllipse(in: CGRect(x: x, y: y, width: 2, height: 2))
                }
            }.stroke(Color.blue, lineWidth: 1)
        }
    }
}

struct EllipticCurveGraphView_Previews: PreviewProvider {
    static var previews: some View {
        EllipticCurveGraphView(curve: EllipticCurve(a: 1, b: 1, p: 17))
    }
}
