
import Foundation

enum SignPostColor: UInt {
    case blue = 0
    case green
    case purple
    case orange
    case red
}

enum Event: UInt32 {
    case imageDownload = 1
    case imageDecode
    case tiltAnimation
}

func DebugSignPost(event: Event, eventObject: AnyHashable) {
    if #available(iOS 10.0, *) {
        kdebug_signpost(event.rawValue, UInt(abs(eventObject.hashValue)), 0, 0, UInt(4))
    } else {
        // Fallback on earlier versions, some syscall()
    }
}

func DebugSignPostStart(event: Event, eventObject: AnyHashable, signPostColor: SignPostColor) {
    if #available(iOS 10.0, *) {
        kdebug_signpost_start(event.rawValue, UInt(abs(eventObject.hashValue)), 0, 0, UInt(signPostColor.rawValue))
    } else {
        // Fallback on earlier versions
    }
}

func DebugSignPostEnd(event: Event, eventObject: AnyHashable, signPostColor: SignPostColor) {
    if #available(iOS 10.0, *) {
        kdebug_signpost_end(event.rawValue, UInt(abs(eventObject.hashValue)), 0, 0, UInt(signPostColor.rawValue))
    } else {
        // Fallback on earlier versions
    }
}
