import Foundation

protocol UserRepository {
    func getUserList(page: Int, pageSize: Int, completion: @escaping (Result<UsersPage, Error>) -> Void) -> Void
}
