//
//  BitmapBuffer+DebugDraw.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit

extension BitmapBufferContextAccessor {
    public func debugDrawRect(_ rect: CGRect, color: UIColor) {
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.withAlphaComponent(0.2).cgColor)
        context.addRect(rect.insetBy(dx: -0.5, dy: -0.5))
        context.drawPath(using: .fillStroke)
    }

    public func debugDrawPoint(_ point: CGPoint, color: UIColor) {
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.withAlphaComponent(0.2).cgColor)
        context.addEllipse(in: CGRect(x: point.x - 1, y: point.y - 1, width: 3, height: 3))
        context.drawPath(using: .fillStroke)
    }
}

extension BitmapBuffer {
    public func withDebugDrawContext(execute block: (BitmapBufferContextAccessor) throws -> Void) throws {
        try withContext { accessor in
            accessor.context.translateBy(x: 0, y: accessor.rect.height)
            accessor.context.scaleBy(x: 1, y: -1)
            try block(accessor)
        }
    }

    public func debugDrawRect(_ rect: CGRect, color: UIColor) throws {
        try withDebugDrawContext { accessor in
            accessor.debugDrawRect(rect, color: color)
        }
    }

    public func debugDrawPoint(_ point: CGPoint, color: UIColor) throws {
        try withContext { accessor in
            accessor.debugDrawPoint(point, color: color)
        }
    }
}

extension BitmapBuffer.RawDataAccessor {
    public func withDebugDrawContext(execute block: (BitmapBufferContextAccessor) throws -> Void) throws {
        try withContext { accessor in
            accessor.context.translateBy(x: 0, y: accessor.rect.height)
            accessor.context.scaleBy(x: 1, y: -1)
            try block(accessor)
        }
    }

    public func debugDrawRect(_ rect: CGRect, color: UIColor) throws {
        try withDebugDrawContext { accessor in
            accessor.debugDrawRect(rect, color: color)
        }
    }

    public func debugDrawPoint(_ point: CGPoint, color: UIColor) throws {
        try withContext { accessor in
            accessor.debugDrawPoint(point, color: color)
        }
    }
}
