//
//  TransactionRepositoryTests.swift
//  TransactionsTests
//
//  Created by Gursimran Singh Gill on 2026-02-04.
//

import XCTest
@testable import Transactions

final class TransactionRepositoryTests: XCTestCase {
    func testFetchTransactions_success() async throws {
        let mockDTO = TransactionDTO(
            id: "1",
            transactionType: "DEBIT",
            merchantName: "Test Merchant",
            description: "Test Description",
            amount: AmountDTO(value: 10, currency: "CAD"),
            postedDate: "2026-02-04",
            fromAccount: "Test Account",
            fromCardNumber: "1234"
        )
        let responseDTO = TransactionListResponseDTO(transactions: [mockDTO])
        let data = try JSONEncoder().encode(responseDTO)
        let mockDataSource = MockTransactionDataSource(dataToReturn: data)
        let repository = TransactionRepository(dataSource: mockDataSource)
        let transactions = try await repository.fetchTransactions()
        
        XCTAssertEqual(transactions.count, 1)
        XCTAssertEqual(transactions.first?.id, "1")
        XCTAssertEqual(transactions.first?.transactionType, .debit)
    }
    
    func testFetchTransactions_dataSourceError() async {
        let mockDataSource = MockTransactionDataSource(errorToThrow: TransactionDataSourceError.fileNotFound)
        let repository = TransactionRepository(dataSource: mockDataSource)
        
        do {
            _ = try await repository.fetchTransactions()
            XCTFail("Expected fetchTransactions to throw")
        } catch let error as TransactionDataSourceError {
            XCTAssertNotNil(error)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchTransactions_mappingError() async throws {
        let invalidData = Data("invalid json".utf8)
        let mockDataSource = MockTransactionDataSource(dataToReturn: invalidData)
        let repository = TransactionRepository(dataSource: mockDataSource)
        
        do {
            _ = try await repository.fetchTransactions()
            XCTFail("Expected fetchTransactions to throw")
        } catch let error as TransactionDataSourceError {
            switch error {
            case .decodingFailed:
                XCTAssertTrue(true)
            default:
                XCTFail("Unexpected TransactionDataSourceError: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}

final class MockTransactionDataSource: TransactionDataSourceProtocol {
    let dataToReturn: Data?
    let errorToThrow: Error?
    
    init(dataToReturn: Data? = nil, errorToThrow: Error? = nil) {
        self.dataToReturn = dataToReturn
        self.errorToThrow = errorToThrow
    }
    
    func loadTransactions() async throws -> Data {
        if let error = errorToThrow { throw error }
        return dataToReturn ?? Data()
    }
}
