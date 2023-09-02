
import RxSwift
import Action

protocol PlacesViewModelInputs {
    var viewDidLoad: AnyObserver<Void> { get }
    var pulledToRefresh: AnyObserver<Void> { get }
    var repeatClicked: AnyObserver<Void> { get }
    var clearCacheClicked: AnyObserver<Void> { get }//gggggggggggggggggggggg
}
////vggggggggggggggggggggg