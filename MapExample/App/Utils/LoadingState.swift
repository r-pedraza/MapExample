enum LoadingState<Value, Error> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
