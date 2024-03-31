import SwiftUI

struct PointAdditionView: View {
    @State private var x1Input = ""
    @State private var y1Input = ""
    @State private var x2Input = ""
    @State private var y2Input = ""
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
                TextField("x1", text: $x1Input).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("y1", text: $y1Input).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }
            HStack{
                TextField("x2", text: $x2Input).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("y2", text: $y2Input).padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }
            
            Button(action: {
                self.calculatePointAddition()
            }) {
                if(result==""){
                    Text("Calculate Point Addition")
                }
                else {
                    Text(result)
                }
            }.padding()
                .buttonStyle(.borderedProminent)
        }
    }
    
    func calculatePointAddition() {
        guard let x1 = Int(x1Input), let y1 = Int(y1Input),
              let x2 = Int(x2Input), let y2 = Int(y2Input), let a = Int(aCurve), let b = Int(bCurve), let ps = Int(pCurve) else {
            result = "Invalid input"
            return
        }
        
        let P = ECPoint(x: x1, y: y1)
        let Q = ECPoint(x: x2, y: y2)
        let curve = EllipticCurve(a: a, b: b, p: ps)
        let R = pointAddition(P, Q, curve)
        result = "Result of point addition: (\(R.x), \(R.y))"
    }
}
