import CoreGraphics
import Darwin
import Foundation

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data((message + "\n").utf8))
    exit(1)
}

var count: UInt32 = 0
guard CGGetActiveDisplayList(0, nil, &count) == .success else {
    fail("Could not enumerate active displays.")
}

var displays = [CGDirectDisplayID](repeating: 0, count: Int(count))
guard CGGetActiveDisplayList(count, &displays, &count) == .success else {
    fail("Could not read active displays.")
}
guard let display = displays.prefix(Int(count)).first(where: {
    CGDisplayIsBuiltin($0) != 0 && CGDisplayIsInMirrorSet($0) == 0
}) else {
    print("Skipped More Space because no unmirrored built-in display is active.")
    exit(0)
}

guard let current = CGDisplayCopyDisplayMode(display),
      let modes = CGDisplayCopyAllDisplayModes(display, nil) as? [CGDisplayMode] else {
    fail("Could not read built-in display modes.")
}

// More Space is the largest logical desktop size among the Retina modes.
let retinaModes = modes.filter {
    $0.isUsableForDesktopGUI() && $0.pixelWidth == 2 * $0.width && $0.pixelHeight == 2 * $0.height
}
guard let largest = retinaModes.max(by: { $0.width * $0.height < $1.width * $1.height }) else {
    print("Skipped More Space because no Retina desktop mode is available.")
    exit(0)
}
let size = "\(largest.width) × \(largest.height)"
if current.width == largest.width && current.height == largest.height &&
    current.pixelWidth == largest.pixelWidth && current.pixelHeight == largest.pixelHeight {
    print("Built-in display already uses More Space (\(size)).")
    exit(0)
}

let target = retinaModes.first {
    $0.width == largest.width && $0.height == largest.height && $0.refreshRate == current.refreshRate
} ?? largest

var configuration: CGDisplayConfigRef?
guard CGBeginDisplayConfiguration(&configuration) == .success, let configuration else {
    fail("Could not begin display configuration.")
}
guard CGConfigureDisplayWithDisplayMode(configuration, display, target, nil) == .success else {
    CGCancelDisplayConfiguration(configuration)
    fail("Could not configure the built-in display for \(size).")
}
guard CGCompleteDisplayConfiguration(configuration, .permanently) == .success else {
    fail("Could not save the built-in display configuration.")
}
print("Set built-in display to More Space (\(size)).")
