//
//  Candlestick.swift
//  
//
//  Created by Justin Cummings on 10/30/21.
//

import Foundation
import SwiftUI

public struct Whisker: View, InsettableShape {
    private let inset: CGFloat

    public func inset(by amount: CGFloat) -> Whisker {
        Whisker(inset: self.inset + amount)
    }

    public var body: some View {
        GeometryReader { geometry in
            self.path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
        }
    }

    func midpoint(of size: CGFloat) -> CGFloat {
        return size / 2
    }

    public let thickness: CGFloat = 2

    public init(inset: CGFloat = 0) {
        self.inset = inset
    }

    public func path(in rect: CGRect) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let horizontalCenter = midpoint(of: width)
        let thicknessOffset = midpoint(of: thickness)
        return Path { path in

            // start at top left corner of whisker oriented vertically with whisker ends at bottom
            path.move(to: CGPoint(x: horizontalCenter - thicknessOffset, y: 0))
            // left edge of vertical part
            path.addLine(to: CGPoint(x: horizontalCenter - thicknessOffset, y: height - thickness))
            // top left edge of whisker end
            path.addLine(to: CGPoint(x: 0, y: height - thickness))
            // vertical edge of left whisker end
            path.addLine(to: CGPoint(x: 0, y: height))
            // bottom edge of whisker end
            path.addLine(to: CGPoint(x: width, y: height))
            // vertical edge of right whisker end
            path.addLine(to: CGPoint(x: width, y: height - thickness))
            // top edge of right whisker end
            path.addLine(to: CGPoint(x: horizontalCenter + thicknessOffset, y: height - thickness))
            // right edge of vertical part
            path.addLine(to: CGPoint(x: horizontalCenter + thicknessOffset, y: 0))
            // top edge of vertical part
            path.closeSubpath()
        }.offsetBy(dx: inset, dy: inset)

    }

}

struct Whisker_Previews: PreviewProvider {
    static var previews: some View {
        Whisker()
            .previewLayout(.fixed(width: 200, height: 300))
    }
}
