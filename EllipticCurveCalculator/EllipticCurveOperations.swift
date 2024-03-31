import Foundation

func isPointOnCurve(_ point: ECPoint, _ curve: EllipticCurve) -> Bool {
    let x = point.x
    let y = point.y
    let p = curve.p
    let a = curve.a
    let b = curve.b
    
    let left = (y * y) % p
    let right = ((x * x * x) + (a * x) + b) % p
    
    return left == right
}

func pointAddition(_ P: ECPoint, _ Q: ECPoint, _ curve: EllipticCurve) -> ECPoint {
    if P.x == Int.max {
        return Q
    } else if Q.x == Int.max {
        return P
    }
    
    if P.x == Q.x && P.y == -Q.y {
        return ECPoint(x: Int.max, y: Int.max)
    }
    
    let m: Int
    if P.x == Q.x && P.y == Q.y {
        let num = (3 * P.x * P.x + curve.a) % curve.p
        let den = (2 * P.y) % curve.p
        let inv = modInverse(den, curve.p)
        if(inv == 999999){
            return ECPoint(x: -1, y: -1)
        }
        let slope = (num * inv) % curve.p
        m = slope
    } else {
        let num = (Q.y - P.y) % curve.p
        let den = (Q.x - P.x) % curve.p
        let inv = modInverse(den, curve.p)
        if(inv == 999999){
            return ECPoint(x: -1, y: -1)
        }
        let slope = (num * inv) % curve.p
        m = slope
    }
    
    let xR = (m * m - P.x - Q.x) % curve.p
    
    let yR = (m * (P.x - xR) - P.y) % curve.p
    
    let result = ECPoint(x: (xR + curve.p) % curve.p, y: (yR + curve.p) % curve.p)
    
    if !isPointOnCurve(result, curve) {
        return ECPoint(x: -2, y: -2)
    }
    
    return result
}

func scalarMultiplication(_ k: Int, _ P: ECPoint, _ curve: EllipticCurve) -> ECPoint {
    var result = ECPoint(x: Int.max, y: Int.max) 
    
    var Q = P
    var kCopy = k
    
    while kCopy > 0 {
        if kCopy % 2 == 1 {
            result = pointAddition(result, Q, curve)
        }
        
        Q = pointAddition(Q, Q, curve)
        kCopy /= 2
    }
    
    return result
}

func modInverse(_ a: Int, _ m: Int) -> Int {
    var (t, newt) = (0, 1)
    var (r, newr) = (m, a)

    while newr != 0 {
        let quotient = r / newr
        (t, newt) = (newt, t - quotient * newt)
        (r, newr) = (newr, r - quotient * newr)
    }

    if r > 1 { return 999999 }
    if t < 0 { t += m }
    return t
}
