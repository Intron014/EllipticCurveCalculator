import SwiftUI

struct ScalarMultiplicationView: View {
    @State private var xInput = ""
    @State private var yInput = ""
    @State private var kInput = ""
    @State private var aCurve = ""
    @State private var bCurve = ""
    @State private var pCurve = ""
    @Binding var result: String
    
    var body: some View {
        VStack {
            HStack{
                
                TextField("a", text: $aCurve).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("b", text: $bCurve).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("p", text: $pCurve).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }
            HStack{
                TextField("x", text: $xInput).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("y", text: $yInput).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("k", text: $kInput).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }
            Button(action: {
                self.calculateScalarMultiplication()
            }) {
                if(result==""){
                    Text("Calculate Scalar Multiplication")
                }
                else {
                    Text(result)
                }
            }.padding()
                .buttonStyle(.borderedProminent)
        }
    }
    
    func calculateScalarMultiplication() {
        guard let x = Int(xInput), let y = Int(yInput),
              let k = Int(kInput), let a = Int(aCurve), let b = Int(bCurve), let ps = Int(pCurve) else {
            result = "Invalid input"
            return
        }
        let P = ECPoint(x: x, y: y)
        let curve = EllipticCurve(a: a, b: b, p: ps)
        let R = scalarMultiplication(k, P, curve)
        result = "Result of scalar multiplication: (\(R.x), \(R.y))"
    }
}
