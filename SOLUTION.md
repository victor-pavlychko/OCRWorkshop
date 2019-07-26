# Solutions to excercises

## BitmapRowAnalyzer.swift

```swift
private func analyzeBitmap(_ accessor: BitmapBuffer<GrayscalePixel>.RawDataAccessor) throws -> BitmapRowAnalyzerResult {
    var result = BitmapRowAnalyzerResult()

    var lastRowKind: BitmapRowAnalyzerResult.Line.Kind?
    for row in 0 ..< accessor.height {
        let info = analyzeRow(accessor, row: row)
        let kind = classifyRow(info)

        if kind != lastRowKind, let kind = kind {
            result.lines.append(BitmapRowAnalyzerResult.Line(row: row, kind: kind))
        }

        lastRowKind = kind
    }

    return result
}
```

## TextDetector.swift

```swift
func detect() throws -> TextDetectorResult {
    let hpBar = try bitmapRowInfo
        .lines
        .drop { $0.kind != .white }
        .first { $0.kind == .hpBar }
        .unwrapped(or: GenericError("HP bar not found"))
        .row

    let whiteLineAfterHpBar = try bitmapRowInfo
        .lines
        .drop { $0.kind != .white }
        .drop { $0.kind != .hpBar }
        .dropFirst()
        .filter {  $0.kind == .white }
        .dropFirst()
        .first
        .unwrapped(or: GenericError("Failed to find two white lines after HP bar"))
        .row

    // ...
}
```

## TextRecognizer.swift

```swift
private func analyzeTextBlock(_ textBlock: TextDetectorResult.TextBlock) throws -> String {
    return try textBlock
        .characterBoxes
        .compactMap { try analyzeSymbol(boundingBox: textBlock.boundingBox, characterBox: $0) }
        .joined()
}
```

```swift
private func classify(_ pixelBuffer: CVPixelBuffer) throws -> String? {
    let prediction = try hpClassifier.prediction(image: pixelBuffer)
    let classLabel = prediction.classLabel
    let probability = prediction.output[classLabel] ?? 0

    // ...
}
```
