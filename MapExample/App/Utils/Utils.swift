import Foundation
import UIKit

struct Utils {
    static var authorizationsURL: URL {
        return URL(string: UIApplication.openSettingsURLString)!
    }
}
