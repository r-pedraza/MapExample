public enum GenericError: Error, CustomStringConvertible {
    case badRequest
    case badStoredUsers
    case parseObjectError(message: String)
    case userLocationAuthorizationError
    
    // MARK: - CustomStringConvertible
    public var description: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .badStoredUsers:
            return "Bad Stored Users"
        case .parseObjectError:
            return "Parse Object Error"
        case .userLocationAuthorizationError:
            return "User Location Error"
        }
    }
}
