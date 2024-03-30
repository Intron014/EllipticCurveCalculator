import SwiftUI
import Foundation

// Define a structure for elliptic curve points
struct ECPoint {
    let x: Int
    let y: Int
}

// Define a structure for the elliptic curve
struct EllipticCurve {
    let a: Int
    let b: Int
    let p: Int // Prime modulus
}

// Define point addition on the elliptic curve
func pointAddition(_ P: ECPoint, _ Q: ECPoint, _ curve: EllipticCurve) -> ECPoint {
    // Handle the case when one of the points is the point at infinity
    if P.x == Int.max {
        return Q
    } else if Q.x == Int.max {
        return P
    }
    
    // Handle the case when the points are equal
    if P.x == Q.x && P.y == -Q.y {
        return ECPoint(x: Int.max, y: Int.max) // point at infinity
    }
    
    // Compute the slope of the line
    let m: Int
    if P.x == Q.x && P.y == Q.y {
        let num = (3 * P.x * P.x + curve.a) % curve.p
        let den = (2 * P.y) % curve.p
        let inv = modInverse(den, curve.p)
        let slope = (num * inv) % curve.p
        m = slope
    } else {
        let num = (Q.y - P.y) % curve.p
        let den = (Q.x - P.x) % curve.p
        let inv = modInverse(den, curve.p)
        let slope = (num * inv) % curve.p
        m = slope
    }
    
    // Compute the x-coordinate of the result
    let xR = (m * m - P.x - Q.x) % curve.p
    
    // Compute the y-coordinate of the result
    let yR = (m * (P.x - xR) - P.y) % curve.p
    
    return ECPoint(x: (xR + curve.p) % curve.p, y: (yR + curve.p) % curve.p)
}

// Define a function to calculate the modular inverse
func modInverse(_ a: Int, _ m: Int) -> Int {
    var (t, newt) = (0, 1)
    var (r, newr) = (m, a)

    while newr != 0 {
        let quotient = r / newr
        (t, newt) = (newt, t - quotient * newt)
        (r, newr) = (newr, r - quotient * newr)
    }

    if r > 1 { return -1 } // No modular inverse exists
    if t < 0 { t += m } // Ensure positive result
    return t
}

// SwiftUI ContentView
struct ContentView: View {
    @State private var aInput = ""
    @State private var bInput = ""
    @State private var pInput = ""
    @State private var x1Input = ""
    @State private var y1Input = ""
    @State private var x2Input = ""
    @State private var y2Input = ""
    @State private var result = ""
    
    var body: some View {
        VStack {
            Text("Elliptic Curve Point Addition").font(.title)
            TextField("a", text: $aInput).padding()
            TextField("b", text: $bInput).padding()
            TextField("p", text: $pInput).padding()
            TextField("x1", text: $x1Input).padding()
            TextField("y1", text: $y1Input).padding()
            TextField("x2", text: $x2Input).padding()
            TextField("y2", text: $y2Input).padding()
            Button(action: {
                self.calculate()
            }) {
                Text("Calculate")
            }.padding()
            Text(result).padding()
        }.padding()
    }
    
    func calculate() {
        guard let a = Int(aInput), let b = Int(bInput), let p = Int(pInput),
              let x1 = Int(x1Input), let y1 = Int(y1Input),
              let x2 = Int(x2Input), let y2 = Int(y2Input) else {
            result = "Invalid input"
            return
        }
        
        let curve = EllipticCurve(a: a, b: b, p: p)
        let P = ECPoint(x: x1, y: y1)
        let Q = ECPoint(x: x2, y: y2)
        let R = pointAddition(P, Q, curve)
        result = "Result of point addition: (\(R.x), \(R.y))"
    }
}
