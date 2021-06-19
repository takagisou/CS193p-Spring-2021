//
//  ShapePreview.swift
//  Set
//
//  Created by sana on 2021/06/06.
//

import SwiftUI

struct ShapePreview: View {
    var body: some View {
        VStack {
            Squiggle().stroke(lineWidth: 3)
            Diamond().stroke(lineWidth: 3)
            Oval().stroke(lineWidth: 3)
        }
    }
}


struct Diamond: Shape {
    let lineWidth: CGFloat = 3.0
    
        
    func path(in rect: CGRect) -> Path {
        let diagonalLength = rect.width / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let top = CGPoint(
            x: center.x,
            y: center.y - diagonalLength / 2)
        let left = CGPoint(
            x: rect.minX,
            y: center.y)
        let bottom = CGPoint(
            x: center.x,
            y: center.y + diagonalLength / 2)
        let right = CGPoint(
            x: rect.maxX,
            y: center.y)
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        return p
//        return p.stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)).path(in: rect)
    }
}

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let width: CGFloat
        let height: CGFloat
        
        if rect.height * 2 < rect.width {
            height = rect.height
            width = height * 2
        } else {
            width = rect.width
            height = width / 2
        }

        let radius = height / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        // top left
        let topLeft = CGPoint(
            x: center.x - width/2 + radius,
            y: center.y - radius)
        let bottomLeft = CGPoint(
            x: topLeft.x,
            y: topLeft.y + (radius * 2))
        let bottomRight = CGPoint(
            x: bottomLeft.x + width / 2,
            y: bottomLeft.y)
        let topRight = CGPoint(
            x: bottomRight.x,
            y: topLeft.y)
        let centerLeft = CGPoint(
            x: topLeft.x,
            y: center.y)
        let centerRight = CGPoint(
            x: topRight.x,
            y: center.y)
        
        var p = Path()
        let rotationAdjustment: Angle = .radians(Double.pi)
        p.addArc(center: centerLeft,
                 radius: radius,
                 startAngle: .radians(Double.pi / 2) - rotationAdjustment,
                 endAngle: .radians(Double.pi * 3/2) - rotationAdjustment,
                 clockwise: true)
        p.addLine(to: bottomRight)
        p.addArc(center: centerRight,
                 radius: radius,
                 startAngle: .radians(Double.pi * 3/2) - rotationAdjustment,
                 endAngle: .radians(Double.pi / 2) - rotationAdjustment,
                 clockwise: true)
        p.addLine(to: topLeft)
        
        return p
    }
}


struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let width: CGFloat
        let height: CGFloat
        
        if rect.height * 2 < rect.width {
            height = rect.height
            width = height * 2
        } else {
            width = rect.width
            height = width / 2
        }

        
        let r: CGRect = .init(
            x: rect.minX,
            y: rect.midY - height/2,
            width: width,
            height: height)
        
        return Rectangle().path(in: r)
    }
}

struct ShapePreview_Previews: PreviewProvider {
    static var previews: some View {
        ShapePreview()
    }
}
